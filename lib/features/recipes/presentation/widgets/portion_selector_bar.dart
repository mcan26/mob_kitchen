import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';

/// Dinamik porsiyon seçici: 1, 2, 4 gibi hızlı porsiyon butonları veya +/- hassas ayar.
class PortionSelectorBar extends StatelessWidget {
  const PortionSelectorBar({
    super.key,
    required this.currentServings,
    required this.onChanged,
    this.minServings = 1,
    this.maxServings = 12,
  });

  final int currentServings;
  final ValueChanged<int> onChanged;
  final int minServings;
  final int maxServings;

  @override
  Widget build(BuildContext context) {
    const quickOptions = [1, 2, 4];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: MobColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: MobColors.border),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.people_alt_outlined,
            size: 20,
            color: MobColors.primaryLight,
          ),
          const SizedBox(width: 8),
          const Text(
            'Porsiyon:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: MobColors.textPrimary,
            ),
          ),
          const Spacer(),
          // Hızlı Butonlar (1, 2, 4)
          for (final count in quickOptions) ...[
            _QuickOptionButton(
              count: count,
              isSelected: currentServings == count,
              onTap: () => onChanged(count),
            ),
            const SizedBox(width: 6),
          ],
          const SizedBox(width: 4),
          // Eksi Butonu
          _CircleIconButton(
            icon: Icons.remove,
            enabled: currentServings > minServings,
            onTap: () {
              if (currentServings > minServings) {
                onChanged(currentServings - 1);
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$currentServings',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: MobColors.textPrimary,
              ),
            ),
          ),
          // Artı Butonu
          _CircleIconButton(
            icon: Icons.add,
            enabled: currentServings < maxServings,
            onTap: () {
              if (currentServings < maxServings) {
                onChanged(currentServings + 1);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _QuickOptionButton extends StatelessWidget {
  const _QuickOptionButton({
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? MobColors.primary : MobColors.card,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? MobColors.primary : MobColors.border,
          ),
        ),
        child: Text(
          '$count',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : MobColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? MobColors.cardSubtle : MobColors.card.withValues(alpha: 0.3),
          shape: BoxShape.circle,
          border: Border.all(color: MobColors.border),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? MobColors.textPrimary : MobColors.textMuted,
        ),
      ),
    );
  }
}
