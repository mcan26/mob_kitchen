import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../providers/cook_timer_provider.dart';

/// Pişirme anında çalışan paralel zamanlayıcıları ekranın üstünde gösteren yüzen çubuk.
class FloatingTimerBar extends ConsumerWidget {
  const FloatingTimerBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timers = ref.watch(cookTimersProvider);
    if (timers.isEmpty) return const SizedBox.shrink();

    final timerList = timers.values.toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: MobColors.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MobColors.goldBorder.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: timerList.map((timer) {
            final isFinished = timer.isFinished;
            final isRunning = timer.isRunning;

            return Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isFinished
                    ? MobColors.green.withValues(alpha: 0.2)
                    : isRunning
                        ? MobColors.goldSurface
                        : MobColors.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isFinished
                      ? MobColors.green
                      : isRunning
                          ? MobColors.gold
                          : MobColors.border,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isFinished
                        ? Icons.check_circle
                        : isRunning
                            ? Icons.timer
                            : Icons.pause_circle_outline,
                    size: 16,
                    color: isFinished
                        ? MobColors.green
                        : isRunning
                            ? MobColors.gold
                            : MobColors.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Adım ${timer.stepNumber}: ',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: MobColors.textPrimary,
                    ),
                  ),
                  Text(
                    isFinished ? 'Bitti! 🎉' : timer.formattedRemaining,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w900,
                      color: isFinished ? MobColors.green : MobColors.gold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Duraklat / Devam Butonu
                  if (!isFinished)
                    InkWell(
                      onTap: () {
                        ref.read(cookTimersProvider.notifier).startOrToggleTimer(
                              stepNumber: timer.stepNumber,
                              label: timer.label,
                              durationSeconds: timer.totalSeconds,
                            );
                      },
                      child: Icon(
                        isRunning ? Icons.pause : Icons.play_arrow,
                        size: 16,
                        color: MobColors.textPrimary,
                      ),
                    ),
                  const SizedBox(width: 4),
                  // Kapat Butonu
                  InkWell(
                    onTap: () {
                      ref.read(cookTimersProvider.notifier).removeTimer(timer.id);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 14,
                      color: MobColors.textMuted,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
