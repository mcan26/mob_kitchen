import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../domain/entities/macros.dart';

class MacroBadgeRow extends StatelessWidget {
  const MacroBadgeRow({
    super.key,
    required this.macros,
    this.compact = false,
  });

  final Macros macros;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: compact ? 6 : 8,
      runSpacing: 4,
      children: [
        _buildPill(
          label: '${macros.kcal} kcal',
          icon: Icons.local_fire_department,
          color: MobColors.primary,
        ),
        _buildPill(
          label: '${macros.proteinG}g protein',
          icon: Icons.fitness_center,
          color: MobColors.green,
        ),
        if (!compact) ...[
          _buildPill(
            label: '${macros.carbsG}g karb',
            icon: Icons.grain,
            color: MobColors.gold,
          ),
          _buildPill(
            label: '${macros.fatG}g yağ',
            icon: Icons.water_drop_outlined,
            color: MobColors.textSecondary,
          ),
        ],
      ],
    );
  }

  Widget _buildPill({
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: compact ? 12 : 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: compact ? 11 : 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
