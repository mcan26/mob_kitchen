import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/mob_colors.dart';
import '../../../core/theme/recipe_visuals.dart';
import '../../ai/presentation/ai_remix_bottom_sheet.dart';
import '../../profile/providers/profile_providers.dart';
import '../../shopping/providers/shopping_providers.dart';
import '../domain/entities/recipe.dart';
import '../providers/recipe_providers.dart';
import 'widgets/golden_rules_card.dart';
import 'widgets/ingredient_tile.dart';
import 'widgets/macro_badge_row.dart';
import 'widgets/portion_selector_bar.dart';
import 'widgets/step_tile.dart';

class RecipeDetailScreen extends ConsumerStatefulWidget {
  const RecipeDetailScreen({
    super.key,
    required this.recipeId,
  });

  final String recipeId;

  @override
  ConsumerState<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends ConsumerState<RecipeDetailScreen> {
  int? _servings;

  @override
  Widget build(BuildContext context) {
    final recipeAsync = ref.watch(recipeByIdProvider(widget.recipeId));
    final profile = ref.watch(personalTasteProfileProvider);

    return Scaffold(
      backgroundColor: MobColors.background,
      body: recipeAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MobColors.primary),
        ),
        error: (err, _) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'Failed to load recipe: $err',
              style: const TextStyle(color: MobColors.red),
            ),
          ),
        ),
        data: (recipe) {
          if (recipe == null) {
            return const Center(
              child: Text(
                'Recipe not found.',
                style: TextStyle(color: MobColors.textSecondary),
              ),
            );
          }

          final currentServings = _servings ?? recipe.baseServings;
          final allergenWarnings = RecipeVisuals.findAllergenOrDislikeWarnings(recipe, profile);

          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  // 1. Zengin Başlık & Hero Banner (SliverAppBar)
                  _buildSliverAppBar(context, recipe),

                  // 2. İçerik Gövdesi
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Başlık & Alt Başlık
                          Text(
                            recipe.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: MobColors.textPrimary,
                              letterSpacing: -0.5,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            recipe.subtitle,
                            style: const TextStyle(
                              fontSize: 14.5,
                              height: 1.45,
                              color: MobColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Allergen or Disliked Ingredient Warning
                          if (allergenWarnings.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: MobColors.redSurface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: MobColors.red.withValues(alpha: 0.6)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded, color: MobColors.red, size: 22),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      '${allergenWarnings.join(" · ")}. Tap AI Remix to customize this recipe for your dietary needs.',
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w700,
                                        color: MobColors.textPrimary,
                                        height: 1.35,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],

                          // Macro Badges
                          MacroBadgeRow(macros: recipe.macros),
                          const SizedBox(height: 20),

                          // Chef's Golden Rules
                          if (recipe.chefGoldenRules.isNotEmpty) ...[
                            GoldenRulesCard(rules: recipe.chefGoldenRules),
                            const SizedBox(height: 20),
                          ],

                          // Portion Selector Bar
                          PortionSelectorBar(
                            currentServings: currentServings,
                            onChanged: (newCount) => setState(() => _servings = newCount),
                          ),
                          const SizedBox(height: 24),

                          // Ingredients Header & Add to Shopping List
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.restaurant_menu,
                                    size: 18,
                                    color: MobColors.primaryLight,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Ingredients',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: MobColors.textPrimary,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: MobColors.surface,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${recipe.ingredients.length}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: MobColors.primaryLight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton.icon(
                                onPressed: () => _addToShoppingList(recipe, currentServings),
                                style: TextButton.styleFrom(
                                  foregroundColor: MobColors.primaryLight,
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                ),
                                icon: const Icon(Icons.add_shopping_cart, size: 16),
                                label: const Text(
                                  'Add to List',
                                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Ingredient Rows (PortionScaler Integrated)
                          for (final ingredient in recipe.ingredients)
                            IngredientTile(
                              key: ValueKey(ingredient.name),
                              ingredient: ingredient,
                              originalServings: recipe.baseServings,
                              targetServings: currentServings,
                            ),

                          const SizedBox(height: 28),

                          // Preparation & Cooking Steps Header
                          Row(
                            children: [
                              const Icon(
                                Icons.format_list_numbered,
                                size: 18,
                                color: MobColors.primaryLight,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Preparation & Cooking Steps',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: MobColors.textPrimary,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: MobColors.surface,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '${recipe.steps.length}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    color: MobColors.primaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),

                          // Step Cards
                          for (final step in recipe.steps)
                            StepTile(
                              key: ValueKey(step.stepNumber),
                              step: step,
                            ),

                          // Storage & Reheating Tip
                          if (recipe.storageAndReheatingTip.isNotEmpty) ...[
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: MobColors.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: MobColors.border),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.inventory_2_outlined,
                                    size: 18,
                                    color: MobColors.textSecondary,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Storage & Reheating Tip',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w800,
                                            color: MobColors.textPrimary,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          recipe.storageAndReheatingTip,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            height: 1.4,
                                            color: MobColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // 3. Alt Sabit Aksiyon Barı (Persistent Bottom Bar)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  decoration: BoxDecoration(
                    color: MobColors.surface.withValues(alpha: 0.95),
                    border: const Border(top: BorderSide(color: MobColors.border)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // AI Remix Butonu
                      IconButton.outlined(
                        tooltip: 'AI Remix',
                        onPressed: () => _openRemixSheet(recipe),
                        style: IconButton.styleFrom(
                          side: const BorderSide(color: MobColors.primaryLight, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.all(12),
                        ),
                        icon: const Icon(Icons.auto_awesome, color: MobColors.primaryLight, size: 20),
                      ),
                      const SizedBox(width: 8),
                      // Add to Shopping List Button
                      IconButton.filledTonal(
                        tooltip: 'Add $currentServings Servings to List',
                        onPressed: () => _addToShoppingList(recipe, currentServings),
                        style: IconButton.styleFrom(
                          backgroundColor: MobColors.card,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.all(12),
                        ),
                        icon: const Icon(Icons.shopping_bag_outlined, color: MobColors.textPrimary, size: 20),
                      ),
                      const SizedBox(width: 10),
                      // Start Cooking Button (Hands-Free Cook Mode)
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => context.push('/cook/${recipe.id}?servings=$currentServings'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MobColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          icon: const Icon(Icons.local_fire_department, size: 20),
                          label: const Text(
                            'Start Cooking',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Recipe recipe) {
    final visual = RecipeVisuals.forRecipe(recipe);
    final isTest = Platform.environment.containsKey('FLUTTER_TEST');

    return SliverAppBar(
      expandedHeight: 210,
      pinned: true,
      backgroundColor: MobColors.background,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.6),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
        ),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: recipe.isFavorite ? MobColors.primary : Colors.white,
              size: 20,
            ),
          ),
          onPressed: () {
            ref.read(recipeRepositoryProvider).toggleFavorite(recipe.id);
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // 1. High-resolution culinary photography with graceful fallback
            if (!isTest && visual.imageUrl != null && visual.imageUrl!.isNotEmpty)
              Image.network(
                visual.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: visual.gradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: visual.gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

            // 2. Editorial Double Vignette (Top for controls, Bottom blending into background)
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                    Colors.transparent,
                    MobColors.background.withValues(alpha: 0.95),
                    MobColors.background,
                  ],
                  stops: const [0.0, 0.25, 0.55, 0.9, 1.0],
                ),
              ),
            ),

            // 3. Bottom Editorial Badges
            Positioned(
              left: 20,
              bottom: 16,
              right: 20,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: MobColors.primary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      recipe.category.label,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: visual.accentColor.withValues(alpha: 0.4),
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
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: visual.accentColor,
                            letterSpacing: 0.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.timer_outlined, size: 13, color: MobColors.gold),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.totalTimeMinutes} min',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: MobColors.gold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addToShoppingList(Recipe recipe, int servings) async {
    try {
      final shoppingRepo = ref.read(shoppingRepositoryProvider);
      await shoppingRepo.addOrUpdateRecipeInPlan(recipe.id, servings);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${recipe.title} ($servings servings) added to your shopping list!',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: MobColors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding to shopping list: $e'),
            backgroundColor: MobColors.red,
          ),
        );
      }
    }
  }

  Future<void> _openRemixSheet(Recipe recipe) async {
    final updated = await AiRemixBottomSheet.show(context, recipe);
    if (!mounted || updated == null) return;
    if (updated.id != recipe.id) {
      context.push('/recipe/${updated.id}');
    }
  }
}
