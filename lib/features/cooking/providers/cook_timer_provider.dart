import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Zamanlayıcı bittiğinde ses ve haptic bildirim callback'i.
typedef TimerFinishedCallback = void Function(ActiveTimerState timer);

/// Tek bir pişirme zamanlayıcısının durumu.
class ActiveTimerState {
  const ActiveTimerState({
    required this.id,
    required this.stepNumber,
    required this.label,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    this.targetEndTime,
  });

  final String id;
  final int stepNumber;
  final String label;
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;

  /// Arka planda (iOS uygulama askıya alındığında) sürenin kaymaması için
  /// gerçek duvar saati bitiş zamanı.
  final DateTime? targetEndTime;

  bool get isFinished => remainingSeconds <= 0;

  double get progress => totalSeconds > 0 ? (totalSeconds - remainingSeconds) / totalSeconds : 1.0;

  String get formattedRemaining {
    final m = remainingSeconds ~/ 60;
    final s = remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  ActiveTimerState copyWith({
    int? remainingSeconds,
    bool? isRunning,
    DateTime? targetEndTime,
    bool clearTargetEndTime = false,
  }) {
    return ActiveTimerState(
      id: id,
      stepNumber: stepNumber,
      label: label,
      totalSeconds: totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isRunning: isRunning ?? this.isRunning,
      targetEndTime: clearTargetEndTime ? null : (targetEndTime ?? this.targetEndTime),
    );
  }
}

/// Pişirme anında adımlardan başlatılan çoklu/paralel zamanlayıcıları yönetir.
/// Süre bittiğinde mutfakta yemeğin yanmasını önlemek için haptic titreşim ve ses çalar.
class CookTimersNotifier extends StateNotifier<Map<String, ActiveTimerState>> {
  CookTimersNotifier({
    TimerFinishedCallback? onTimerFinished,
    DateTime Function()? nowProvider,
  })  : _onTimerFinished = onTimerFinished ?? _defaultOnTimerFinished,
        _now = nowProvider ?? DateTime.now,
        super(const {});

  final TimerFinishedCallback _onTimerFinished;
  final DateTime Function() _now;
  Timer? _ticker;

  static void _defaultOnTimerFinished(ActiveTimerState timer) {
    try {
      HapticFeedback.heavyImpact();
      SystemSound.play(SystemSoundType.alert);
    } catch (_) {
      // Test ortamı veya platform servis yokluğu koruması
    }
  }

  void startOrToggleTimer({
    required int stepNumber,
    required String label,
    required int durationSeconds,
  }) {
    final timerId = 'step_$stepNumber';
    final existing = state[timerId];
    final now = _now();

    if (existing != null) {
      if (existing.isFinished) {
        // Yeniden başlat
        state = {
          ...state,
          timerId: existing.copyWith(
            remainingSeconds: durationSeconds,
            isRunning: true,
            targetEndTime: now.add(Duration(seconds: durationSeconds)),
          ),
        };
      } else if (existing.isRunning) {
        // Duraklat
        state = {
          ...state,
          timerId: existing.copyWith(
            isRunning: false,
            clearTargetEndTime: true,
          ),
        };
      } else {
        // Devam ettir
        state = {
          ...state,
          timerId: existing.copyWith(
            isRunning: true,
            targetEndTime: now.add(Duration(seconds: existing.remainingSeconds)),
          ),
        };
      }
    } else {
      // Yeni zamanlayıcı ekle ve başlat
      final newTimer = ActiveTimerState(
        id: timerId,
        stepNumber: stepNumber,
        label: label,
        totalSeconds: durationSeconds,
        remainingSeconds: durationSeconds,
        isRunning: true,
        targetEndTime: now.add(Duration(seconds: durationSeconds)),
      );
      state = {...state, timerId: newTimer};
    }

    _ensureTickerRunning();
  }

  /// Uygulama arka plandan (background) ön plana (resumed) döndüğünde
  /// duvar saatine (`targetEndTime`) göre kalan süreleri senkronize eder.
  void syncWithWallClock() {
    if (state.isEmpty) return;
    final now = _now();
    final updated = <String, ActiveTimerState>{};
    final justFinished = <ActiveTimerState>[];

    for (final entry in state.entries) {
      final t = entry.value;
      if (t.isRunning && t.targetEndTime != null) {
        final diffSeconds = t.targetEndTime!.difference(now).inSeconds;
        final nextSec = diffSeconds > 0 ? diffSeconds : 0;
        final updatedTimer = t.copyWith(
          remainingSeconds: nextSec,
          isRunning: nextSec > 0,
          clearTargetEndTime: nextSec == 0,
        );
        updated[entry.key] = updatedTimer;
        if (nextSec == 0 && t.remainingSeconds > 0) {
          justFinished.add(updatedTimer);
        }
      } else {
        updated[entry.key] = t;
      }
    }

    state = updated;
    for (final finished in justFinished) {
      _onTimerFinished(finished);
    }
  }

  void resetTimer(String timerId) {
    final existing = state[timerId];
    if (existing == null) return;

    state = {
      ...state,
      timerId: existing.copyWith(
        remainingSeconds: existing.totalSeconds,
        isRunning: false,
        clearTargetEndTime: true,
      ),
    };
  }

  void removeTimer(String timerId) {
    final next = Map<String, ActiveTimerState>.from(state)..remove(timerId);
    state = next;
    if (state.isEmpty || !state.values.any((t) => t.isRunning)) {
      _stopTicker();
    }
  }

  void clearAll() {
    _stopTicker();
    state = const {};
  }

  void _ensureTickerRunning() {
    if (_ticker != null && _ticker!.isActive) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      var anyRunning = false;
      final updated = <String, ActiveTimerState>{};
      final justFinished = <ActiveTimerState>[];

      for (final entry in state.entries) {
        final t = entry.value;
        if (t.isRunning && t.remainingSeconds > 0) {
          anyRunning = true;
          final nextSec = t.remainingSeconds - 1;
          final updatedTimer = t.copyWith(
            remainingSeconds: nextSec,
            isRunning: nextSec > 0,
            clearTargetEndTime: nextSec == 0,
          );
          updated[entry.key] = updatedTimer;

          if (nextSec == 0) {
            justFinished.add(updatedTimer);
          }
        } else {
          updated[entry.key] = t;
        }
      }

      state = updated;

      // Süresi biten zamanlayıcılar için fiziksel ve işitsel bildirim
      for (final finished in justFinished) {
        _onTimerFinished(finished);
      }

      if (!anyRunning) {
        _stopTicker();
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }
}

final cookTimersProvider =
    StateNotifierProvider<CookTimersNotifier, Map<String, ActiveTimerState>>((ref) {
  return CookTimersNotifier();
});
