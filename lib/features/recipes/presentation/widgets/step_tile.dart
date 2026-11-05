import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../domain/entities/recipe_step.dart';

/// Tarif detayında adım kartı; talimat, duyusal işaretler, şef ipucu ve sayaç gösterir.
class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.step,
  });

  final RecipeStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MobColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Başlık Satırı & Adım Rozeti
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: MobColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${step.stepNumber}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  step.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: MobColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
              if (step.timerSeconds != null && step.timerSeconds! > 0) ...[
                const SizedBox(width: 8),
                _TimerPill(seconds: step.timerSeconds!),
              ],
            ],
          ),
          const SizedBox(height: 12),
          // Ana Talimat
          Text(
            step.instruction,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: MobColors.textPrimary,
            ),
          ),
          // Duyusal İpucu (Sensory Cue)
          if (step.sensoryCue.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: MobColors.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MobColors.border),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: MobColors.primaryLight,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.4,
                          color: MobColors.textSecondary,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Sensory Cue: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: MobColors.primaryLight,
                            ),
                          ),
                          TextSpan(text: step.sensoryCue),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Şef Tüyosu (Chef Tip)
          if (step.chefTip.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: MobColors.goldSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MobColors.goldBorder.withValues(alpha: 0.6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.lightbulb_outline,
                    size: 16,
                    color: MobColors.gold,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.4,
                          color: MobColors.textPrimary,
                        ),
                        children: [
                          const TextSpan(
                            text: "Chef's Secret: ",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: MobColors.gold,
                            ),
                          ),
                          TextSpan(text: step.chefTip),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          // Hata Uyarısı (Mistake Warning)
          if (step.mistakeWarning != null && step.mistakeWarning!.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: MobColors.redSurface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: MobColors.red.withValues(alpha: 0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: MobColors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      step.mistakeWarning!,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: MobColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimerPill extends StatelessWidget {
  const _TimerPill({required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final minutes = seconds ~/ 60;
    final remainingSec = seconds % 60;
    final label = remainingSec == 0 ? '$minutes min' : '$minutes min $remainingSec s';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: MobColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: MobColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.timer_outlined,
            size: 14,
            color: MobColors.gold,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: MobColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}
