import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/mob_colors.dart';
import '../domain/entities/recipe.dart';
import '../domain/entities/recipe_enums.dart';
import '../providers/recipe_providers.dart';
import 'widgets/recipe_card.dart';

enum RecipeFilter {
  all('All'),
  onePot('One-Pan'),
  quick('Quick (≤ 25 min)'),
  highProtein('High Protein'),
  budget('Budget Friendly'),
  aiGenerated('AI Recipes'),
  favorites('My Favorites');

  const RecipeFilter(this.label);
  final String label;
}

class DiscoveryFeedScreen extends ConsumerStatefulWidget {
  const DiscoveryFeedScreen({super.key});

  @override
  ConsumerState<DiscoveryFeedScreen> createState() => _DiscoveryFeedScreenState();
}

class _DiscoveryFeedScreenState extends ConsumerState<DiscoveryFeedScreen> {
  String _searchQuery = '';
  RecipeFilter _selectedFilter = RecipeFilter.all;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Recipe> _filterRecipes(List<Recipe> all) {
    var list = all;

    // Filtre çipi
    switch (_selectedFilter) {
      case RecipeFilter.all:
        break;
      case RecipeFilter.onePot:
        list = list.where((r) => r.category == RecipeCategory.onePot).toList();
      case RecipeFilter.quick:
        list = list.where((r) => r.totalTimeMinutes <= 25).toList();
      case RecipeFilter.highProtein:
        list = list.where((r) => r.macros.proteinG >= 30).toList();
      case RecipeFilter.budget:
        list = list.where((r) => r.category == RecipeCategory.budget).toList();
      case RecipeFilter.aiGenerated:
        list = list.where((r) => !r.isBuiltIn).toList();
      case RecipeFilter.favorites:
        list = list.where((r) => r.isFavorite).toList();
    }

    // Arama sorgusu (başlık veya malzeme)
    if (_searchQuery.trim().isNotEmpty) {
      final query = _searchQuery.trim().toLowerCase();
      list = list.where((r) {
        final matchesTitle = r.title.toLowerCase().contains(query);
        final matchesSubtitle = r.subtitle.toLowerCase().contains(query);
        final matchesIngredient = r.ingredients.any((i) => i.name.toLowerCase().contains(query));
        final matchesTag = r.tags.any((t) => t.toLowerCase().contains(query));
        return matchesTitle || matchesSubtitle || matchesIngredient || matchesTag;
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final recipesAsync = ref.watch(allRecipesProvider);

    return Scaffold(
      backgroundColor: MobColors.background,
      body: SafeArea(
        child: recipesAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: MobColors.primary),
          ),
          error: (err, stack) => Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Error loading catalog: $err',
                style: const TextStyle(color: MobColors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (allRecipes) {
            final filtered = _filterRecipes(allRecipes);

            return CustomScrollView(
              slivers: [
                // 1. Profile & Welcome Header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(24),
                                onTap: () => context.push(AppRoutes.profile),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [MobColors.primary, Color(0xFFC0391B)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: MobColors.primary.withValues(alpha: 0.35),
                                            blurRadius: 10,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'SIMMERLINK',
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w900,
                                              color: MobColors.primaryLight,
                                              letterSpacing: 2.0,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Text(
                                            'Editorial Kitchen & Hub',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16.5,
                                              fontWeight: FontWeight.w800,
                                              color: MobColors.textPrimary,
                                              letterSpacing: -0.4,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Bluetooth (BLE) & Wi-Fi Co-Op Smart Hub Button
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Bluetooth (BLE) & Wi-Fi Smart Kitchen Hub',
                                  onPressed: () => context.push(AppRoutes.wirelessHub),
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: MobColors.surface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.green.withValues(alpha: 0.4)),
                                    ),
                                    child: const Icon(
                                      Icons.bluetooth_connected_rounded,
                                      color: MobColors.green,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                // Social Media (Reels/TikTok) Recipe Import Button
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Import Recipe from Reels / TikTok',
                                  onPressed: () => context.push('${AppRoutes.pantryGenerator}?mode=social'),
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: MobColors.surface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.gold.withValues(alpha: 0.4)),
                                    ),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      color: MobColors.gold,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                // Supermarket Mode Button
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Supermarket Mode',
                                  onPressed: () => context.push(AppRoutes.supermarket),
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: MobColors.surface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.border),
                                    ),
                                    child: const Icon(
                                      Icons.shopping_cart_outlined,
                                      color: MobColors.textPrimary,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                // Profile & Settings Button
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Taste Profile & Settings',
                                  onPressed: () => context.push(AppRoutes.profile),
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: MobColors.surface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.border),
                                    ),
                                    child: const Icon(
                                      Icons.tune_rounded,
                                      color: MobColors.primaryLight,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Search Bar
                        Container(
                          decoration: BoxDecoration(
                            color: MobColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: MobColors.border),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: MobColors.textPrimary, fontSize: 14),
                            onChanged: (val) => setState(() => _searchQuery = val),
                            decoration: InputDecoration(
                              hintText: 'Search recipes, ingredients or tags...',
                              hintStyle: const TextStyle(color: MobColors.textMuted, fontSize: 13),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: MobColors.textSecondary,
                                size: 21,
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.close, size: 18, color: MobColors.textMuted),
                                      onPressed: () {
                                        _searchController.clear();
                                        setState(() => _searchQuery = '');
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // 2. Kategori Çipleri (Yatay Liste)
                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: Row(
                      children: RecipeFilter.values.map((filter) {
                        final isSelected = _selectedFilter == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () => setState(() => _selectedFilter = filter),
                            borderRadius: BorderRadius.circular(20),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? MobColors.primary : MobColors.card,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? MobColors.primary : MobColors.border,
                                ),
                              ),
                              child: Text(
                                filter.label,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? Colors.white : MobColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // 3. Tarif Sayacı & Başlık
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Row(
                      children: [
                        Text(
                          _selectedFilter.label,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: MobColors.textPrimary,
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
                            '${filtered.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: MobColors.primaryLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 8)),

                // 4. Tarif Listesi ya da Boş Durum
                if (filtered.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.search_off_rounded,
                              size: 56,
                              color: MobColors.textMuted,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No recipes found matching your criteria',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MobColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Try a different search or use Gemini AI to generate a custom recipe from your fridge ingredients.',
                              style: TextStyle(
                                fontSize: 13,
                                color: MobColors.textSecondary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              onPressed: () => context.push(AppRoutes.pantryGenerator),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: MobColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              ),
                              icon: const Icon(Icons.auto_awesome, size: 18),
                              label: const Text(
                                'Generate from Fridge',
                                style: TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final recipe = filtered[index];
                          return RecipeCard(
                            key: ValueKey(recipe.id),
                            recipe: recipe,
                            onTap: () => context.push('/recipe/${recipe.id}'),
                            onFavoriteToggle: () {
                              ref.read(recipeRepositoryProvider).toggleFavorite(recipe.id);
                            },
                          );
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: MobColors.primary,
        foregroundColor: Colors.white,
        elevation: 6,
        onPressed: () => context.push(AppRoutes.pantryGenerator),
        icon: const Icon(Icons.auto_awesome, size: 20),
        label: const Text(
          'AI Pantry Chef',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2),
        ),
      ),
    );
  }
}
