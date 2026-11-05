import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';

class GoldenRulesCard extends StatelessWidget {
  const GoldenRulesCard({
    super.key,
    required this.rules,
  });

  final List<String> rules;

  @override
  Widget build(BuildContext context) {
    if (rules.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MobColors.goldSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MobColors.goldBorder, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: MobColors.gold.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified,
                  size: 18,
                  color: MobColors.gold,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Şefin Altın Kuralları',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: MobColors.gold,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final (index, rule) in rules.indexed) ...[
            if (index > 0) const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: MobColors.gold,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    rule,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                      color: MobColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
