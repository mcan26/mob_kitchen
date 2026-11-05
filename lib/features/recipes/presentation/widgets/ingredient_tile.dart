import 'package:flutter/material.dart';

import '../../../../core/domain/aisle_category.dart';
import '../../../../core/theme/mob_colors.dart';
import '../../domain/entities/recipe_ingredient.dart';
import '../../domain/services/portion_scaler.dart';

/// Tarif detayında malzeme satırı; porsiyona göre ölçeklenmiş miktar, reyon bilgisi,
/// market tüyosu (buying_tip) ve alternatif malzeme (substitute_option) içerir.
class IngredientTile extends StatefulWidget {
  const IngredientTile({
    super.key,
    required this.ingredient,
    required this.originalServings,
    required this.targetServings,
  });

  final RecipeIngredient ingredient;
  final int originalServings;
  final int targetServings;

  @override
  State<IngredientTile> createState() => _IngredientTileState();
}

class _IngredientTileState extends State<IngredientTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final scaled = PortionScaler.scaleIngredient(
      widget.ingredient,
      baseServings: widget.originalServings,
      targetServings: widget.targetServings,
    );

    final amountStr = PortionScaler.formatAmount(scaled.amount, scaled.unit);
    final unitStr = scaled.unit.label;
    final hasDetails = (widget.ingredient.buyingTip != null &&
            widget.ingredient.buyingTip!.trim().isNotEmpty) ||
        (widget.ingredient.substituteOption != null &&
            widget.ingredient.substituteOption!.trim().isNotEmpty);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _expanded ? MobColors.primaryLight.withValues(alpha: 0.4) : MobColors.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: hasDetails ? () => setState(() => _expanded = !_expanded) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Reyon Mikro İkonu
                    _AisleIconBadge(aisle: widget.ingredient.aisleCategory),
                    const SizedBox(width: 10),
                    // Malzeme Adı
                    Expanded(
                      child: Text(
                        widget.ingredient.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MobColors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Miktar + Birim
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: MobColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MobColors.border),
                      ),
                      child: Text(
                        unitStr.isEmpty ? amountStr : '$amountStr $unitStr',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: MobColors.primaryLight,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    if (hasDetails) ...[
                      const SizedBox(width: 6),
                      Icon(
                        _expanded ? Icons.keyboard_arrow_up : Icons.info_outline,
                        size: 18,
                        color: _expanded ? MobColors.primaryLight : MobColors.textMuted,
                      ),
                    ],
                  ],
                ),
                // Genişletilebilir Market & Alternatif Alanı
                if (hasDetails && _expanded) ...[
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: MobColors.border),
                  const SizedBox(height: 10),
                  if (widget.ingredient.buyingTip != null &&
                      widget.ingredient.buyingTip!.trim().isNotEmpty) ...[
                    _TipRow(
                      icon: Icons.storefront_outlined,
                      label: 'Market Tüyosu',
                      text: widget.ingredient.buyingTip!,
                      color: MobColors.gold,
                    ),
                  ],
                  if (widget.ingredient.substituteOption != null &&
                      widget.ingredient.substituteOption!.trim().isNotEmpty) ...[
                    if (widget.ingredient.buyingTip != null) const SizedBox(height: 6),
                    _TipRow(
                      icon: Icons.swap_horiz,
                      label: 'Alternatif',
                      text: widget.ingredient.substituteOption!,
                      color: MobColors.green,
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AisleIconBadge extends StatelessWidget {
  const _AisleIconBadge({required this.aisle});

  final AisleCategory aisle;

  @override
  Widget build(BuildContext context) {
    final (icon, color) = switch (aisle) {
      AisleCategory.produce => (Icons.eco_outlined, MobColors.green),
      AisleCategory.butcherDeli => (Icons.restaurant_outlined, MobColors.red),
      AisleCategory.dairy => (Icons.egg_outlined, MobColors.gold),
      AisleCategory.bakery => (Icons.bakery_dining_outlined, const Color(0xFFD39E82)),
      AisleCategory.pantry => (Icons.kitchen_outlined, const Color(0xFF78909C)),
      AisleCategory.spices => (Icons.local_fire_department_outlined, MobColors.primaryLight),
    };

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow({
    required this.icon,
    required this.label,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 15, color: color),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              height: 1.35,
              fontWeight: FontWeight.w500,
              color: MobColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
