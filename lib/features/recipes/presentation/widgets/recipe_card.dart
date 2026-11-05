import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../../../core/theme/recipe_visuals.dart';
import '../../domain/entities/recipe.dart';
import 'macro_badge_row.dart';

bool get _isTestEnvironment => Platform.environment.containsKey('FLUTTER_TEST');

/// Editorial culinary recipe card with photography and high-contrast typography.
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
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        color: MobColors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isAi ? MobColors.primaryLight.withValues(alpha: 0.35) : MobColors.border,
          width: isAi ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Food Photography / Header
              _CardHeader(
                recipe: recipe,
                isAi: isAi,
                onFavoriteToggle: onFavoriteToggle,
              ),

              // Content Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category, Time & Servings Meta Row
                    Row(
                      children: [
                        _MetaChip(
                          icon: Icons.restaurant_menu_rounded,
                          label: recipe.category.label,
                          color: MobColors.primaryLight,
                        ),
                        const SizedBox(width: 8),
                        _MetaChip(
                          icon: Icons.timer_outlined,
                          label: '${recipe.totalTimeMinutes} min',
                          color: MobColors.gold,
                        ),
                        const SizedBox(width: 8),
                        _MetaChip(
                          icon: Icons.people_outline,
                          label: '${recipe.baseServings} Servings',
                          color: MobColors.textSecondary,
                        ),
                        const Spacer(),
                        _DifficultyChip(difficulty: recipe.difficulty.label),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Recipe Title
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.w800,
                        color: MobColors.textPrimary,
                        letterSpacing: -0.3,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtitle / Editorial Hook
                    Text(
                      recipe.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.45,
                        fontWeight: FontWeight.w400,
                        color: MobColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Macro Badges
                    MacroBadgeRow(
                      macros: recipe.macros,
                      compact: true,
                    ),

                    // Tags
                    if (recipe.tags.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: recipe.tags.take(3).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
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

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Food Photography with graceful fallback
            if (!_isTestEnvironment && visual.imageUrl != null && visual.imageUrl!.isNotEmpty)
              Image.network(
                visual.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _FallbackHeaderGradient(visual: visual),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _FallbackHeaderGradient(visual: visual);
                },
              )
            else
              _FallbackHeaderGradient(visual: visual),

            // 2. Editorial Vignette Overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    const Color(0xF21A1A1E),
                  ],
                  stops: const [0.0, 0.35, 0.65, 1.0],
                ),
              ),
            ),

            // 3. Top-left: AI / SimmerLink badge
            Positioned(
              left: 14,
              top: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isAi
                      ? const Color(0xFF8E24AA).withValues(alpha: 0.9)
                      : Colors.black.withValues(alpha: 0.65),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isAi
                        ? Colors.purpleAccent.withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isAi ? Icons.auto_awesome : Icons.local_fire_department,
                      size: 13,
                      color: isAi ? Colors.white : MobColors.primaryLight,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      isAi ? 'AI REMIX' : 'SIMMERLINK',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 4. Top-right: Favorite button
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
                      color: Colors.black.withValues(alpha: 0.55),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Icon(
                      recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: recipe.isFavorite ? MobColors.primary : Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // 5. Bottom-left: Culinary craft badge pill
            Positioned(
              left: 14,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: visual.accentColor.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: visual.accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      visual.culinaryBadge,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: visual.accentColor,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FallbackHeaderGradient extends StatelessWidget {
  const _FallbackHeaderGradient({required this.visual});
  final RecipeVisualSpec visual;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: visual.gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          visual.icon,
          size: 48,
          color: visual.accentColor.withValues(alpha: 0.3),
        ),
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
        border: Border.all(color: MobColors.border),
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
