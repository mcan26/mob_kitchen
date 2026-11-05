import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/features/cooking/providers/cook_timer_provider.dart';

void main() {
  group('CookTimersNotifier Tests', () {
    test('başlangıçta zamanlayıcı listesi boştur', () {
      final notifier = CookTimersNotifier();
      expect(notifier.state, isEmpty);
      notifier.dispose();
    });

    test('startOrToggleTimer yeni zamanlayıcı başlatır ve duraklatır', () {
      final notifier = CookTimersNotifier();

      // Başlat
      notifier.startOrToggleTimer(
        stepNumber: 1,
        label: 'Tavuk Mühürleme',
        durationSeconds: 120,
      );

      final timer = notifier.state['step_1'];
      expect(timer, isNotNull);
      expect(timer!.stepNumber, equals(1));
      expect(timer.totalSeconds, equals(120));
      expect(timer.remainingSeconds, equals(120));
      expect(timer.isRunning, isTrue);
      expect(timer.formattedRemaining, equals('02:00'));

      // Aynı metoda tekrar basılınca duraklatmalı
      notifier.startOrToggleTimer(
        stepNumber: 1,
        label: 'Tavuk Mühürleme',
        durationSeconds: 120,
      );

      expect(notifier.state['step_1']!.isRunning, isFalse);

      notifier.dispose();
    });

    test('birden fazla adımı paralel zamanlayıcı olarak yönetir', () {
      final notifier = CookTimersNotifier();

      notifier.startOrToggleTimer(
        stepNumber: 1,
        label: 'Tavuk',
        durationSeconds: 300,
      );

      notifier.startOrToggleTimer(
        stepNumber: 2,
        label: 'Sos',
        durationSeconds: 180,
      );

      expect(notifier.state.length, equals(2));
      expect(notifier.state.containsKey('step_1'), isTrue);
      expect(notifier.state.containsKey('step_2'), isTrue);

      notifier.removeTimer('step_1');
      expect(notifier.state.length, equals(1));
      expect(notifier.state.containsKey('step_2'), isTrue);

      notifier.clearAll();
      expect(notifier.state, isEmpty);

      notifier.dispose();
    });

    test('resetTimer sayacı sıfırlar ve durdurur', () {
      final notifier = CookTimersNotifier();

      notifier.startOrToggleTimer(
        stepNumber: 3,
        label: 'Fırınlama',
        durationSeconds: 60,
      );

      notifier.resetTimer('step_3');

      final timer = notifier.state['step_3']!;
      expect(timer.remainingSeconds, equals(60));
      expect(timer.isRunning, isFalse);

      notifier.dispose();
    });

    test('zamanlayıcı sıfıra indiğinde onTimerFinished tetiklenir', () async {
      ActiveTimerState? finishedTimer;

      final notifier = CookTimersNotifier(
        onTimerFinished: (timer) => finishedTimer = timer,
      );

      notifier.startOrToggleTimer(
        stepNumber: 1,
        label: 'Kısa Süre',
        durationSeconds: 1,
      );

      // 1 saniye geri sayımı bekle
      await Future<void>.delayed(const Duration(milliseconds: 1150));

      expect(finishedTimer, isNotNull);
      expect(finishedTimer!.stepNumber, equals(1));
      expect(finishedTimer!.remainingSeconds, equals(0));
      expect(finishedTimer!.isFinished, isTrue);

      notifier.dispose();
    });

    test('syncWithWallClock arka planda geçen süreyi duvar saatine göre senkronize eder', () {
      var mockNow = DateTime(2026, 10, 16, 18, 0, 0);
      ActiveTimerState? finishedTimer;

      final notifier = CookTimersNotifier(
        nowProvider: () => mockNow,
        onTimerFinished: (t) => finishedTimer = t,
      );

      notifier.startOrToggleTimer(
        stepNumber: 1,
        label: 'Makarna Haşlama',
        durationSeconds: 300,
      );

      // Kullanıcı uygulamayı arka plana attı ve 120 saniye geçti
      mockNow = mockNow.add(const Duration(seconds: 120));
      notifier.syncWithWallClock();

      expect(notifier.state['step_1']!.remainingSeconds, equals(180));
      expect(notifier.state['step_1']!.isRunning, isTrue);
      expect(finishedTimer, isNull);

      // 200 saniye daha geçti (toplam 320 sn > 300 sn)
      mockNow = mockNow.add(const Duration(seconds: 200));
      notifier.syncWithWallClock();

      expect(notifier.state['step_1']!.remainingSeconds, equals(0));
      expect(notifier.state['step_1']!.isFinished, isTrue);
      expect(finishedTimer, isNotNull);

      notifier.dispose();
    });
  });
}
