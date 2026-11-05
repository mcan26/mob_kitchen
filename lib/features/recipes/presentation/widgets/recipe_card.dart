import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../../../core/theme/recipe_visuals.dart';
import '../../domain/entities/recipe.dart';
import 'macro_badge_row.dart';

/// Mob Kitchen estetiğinde zengin tarif kartı.
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
    required this.onTap,
    this.onFavoriteToggle,
  });

  final Recipe recipe;
  final VoidCallback onTap;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final isAi = !recipe.isBuiltIn;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAi ? MobColors.primaryLight.withValues(alpha: 0.3) : MobColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst Görsel / Banner Alanı
              _CardHeader(
                recipe: recipe,
                isAi: isAi,
                onFavoriteToggle: onFavoriteToggle,
              ),

              // İçerik Alanı
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kategori & Süre Satırı
                    Row(
                      children: [
                        _MetaChip(
                          icon: Icons.category_outlined,
                          label: recipe.category.label,
                          color: MobColors.primaryLight,
                        ),
                        const SizedBox(width: 8),
                        _MetaChip(
                          icon: Icons.timer_outlined,
                          label: '${recipe.totalTimeMinutes} dk',
                          color: MobColors.gold,
                        ),
                        const SizedBox(width: 8),
                        _MetaChip(
                          icon: Icons.people_outline,
                          label: '${recipe.baseServings} Porsiyon',
                          color: MobColors.textSecondary,
                        ),
                        const Spacer(),
                        _DifficultyChip(difficulty: recipe.difficulty.label),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Başlık
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: MobColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Alt başlık / Açıklama
                    Text(
                      recipe.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: MobColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Makro Özet Rozetleri
                    MacroBadgeRow(
                      macros: recipe.macros,
                      compact: true,
                    ),

                    // Etiketler (Tags)
                    if (recipe.tags.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: recipe.tags.take(3).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: MobColors.surface,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: MobColors.border),
                            ),
                            child: Text(
                              '#$tag',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: MobColors.textMuted,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader({
    required this.recipe,
    required this.isAi,
    required this.onFavoriteToggle,
  });

  final Recipe recipe;
  final bool isAi;
  final VoidCallback? onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    final visual = RecipeVisuals.forRecipe(recipe);

    return Container(
      height: 122,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: visual.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Arka plan dokusu ve mutfak ikonu
          Positioned(
            right: -6,
            bottom: -14,
            child: Icon(
              visual.icon,
              size: 100,
              color: visual.accentColor.withValues(alpha: 0.12),
            ),
          ),

          // Sağ alt: İştah açıcı tabak emojisi & imza rozeti
          Positioned(
            left: 14,
            bottom: 12,
            right: 14,
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: visual.accentColor.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Text(
                    visual.dishEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: visual.accentColor.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    visual.culinaryBadge,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: visual.accentColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sol üst: AI / Mob rozeti
          Positioned(
            left: 14,
            top: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isAi
                    ? Colors.purple.withValues(alpha: 0.85)
                    : MobColors.primary.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isAi ? Icons.auto_awesome : Icons.local_fire_department,
                    size: 13,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isAi ? 'AI REMIX' : 'MOB KLASİĞİ',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sağ üst: Favori butonu
          Positioned(
            right: 12,
            top: 12,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onFavoriteToggle,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 20,
                    color: recipe.isFavorite ? MobColors.primary : MobColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  const _DifficultyChip({required this.difficulty});

  final String difficulty;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: MobColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty,
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: MobColors.textSecondary,
        ),
      ),
    );
  }
}
