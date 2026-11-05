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
  all('Tümü'),
  onePot('Tek Tava'),
  quick('Hızlı (≤ 25 dk)'),
  highProtein('Yüksek Protein'),
  budget('Bütçe Dostu'),
  aiGenerated('AI ile Üretilenler'),
  favorites('Favorilerim');

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
                'Katalog yüklenirken hata oluştu: $err',
                style: const TextStyle(color: MobColors.red),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          data: (allRecipes) {
            final filtered = _filterRecipes(allRecipes);

            return CustomScrollView(
              slivers: [
                // 1. Profil & Karşılama Başlığı
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
                                      width: 42,
                                      height: 42,
                                      decoration: BoxDecoration(
                                        color: MobColors.primary.withValues(alpha: 0.15),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: MobColors.primaryLight.withValues(alpha: 0.3),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text('👨‍🍳', style: TextStyle(fontSize: 20)),
                                    ),
                                    const SizedBox(width: 10),
                                    const Flexible(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'MOB KITCHEN',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w900,
                                              color: MobColors.primary,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          Text(
                                            'Kişisel Mutfak Rehberi',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              color: MobColors.textPrimary,
                                              letterSpacing: -0.3,
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
                                // Bluetooth (BLE) & Wi-Fi Co-Op Akıllı Mutfak Hub Butonu
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Bluetooth (BLE) & Wi-Fi Akıllı Mutfak Hub',
                                  onPressed: () => context.push(AppRoutes.wirelessHub),
                                  icon: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: MobColors.greenSurface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.greenBorder),
                                    ),
                                    child: const Icon(
                                      Icons.bluetooth_connected,
                                      color: MobColors.green,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                // Sosyal Medya (Reels/TikTok) Tarif Aktar Hızlı Butonu
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Reels / TikTok Linkinden Tarif Aktar',
                                  onPressed: () => context.push('${AppRoutes.pantryGenerator}?mode=social'),
                                  icon: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: MobColors.goldSurface,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: MobColors.goldBorder),
                                    ),
                                    child: const Icon(
                                      Icons.bolt_rounded,
                                      color: MobColors.gold,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                // Süpermarket Modu Butonu
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Süpermarket Modu',
                                  onPressed: () => context.push(AppRoutes.supermarket),
                                  icon: Container(
                                    padding: const EdgeInsets.all(7),
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
                                // Mutfak Profili & Ayarlar Butonu
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  tooltip: 'Mutfak Profilim & Ayarlar',
                                  onPressed: () => context.push(AppRoutes.profile),
                                  icon: Container(
                                    padding: const EdgeInsets.all(7),
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
                        // Arama Çubuğu
                        Container(
                          decoration: BoxDecoration(
                            color: MobColors.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: MobColors.border),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: MobColors.textPrimary, fontSize: 14),
                            onChanged: (val) => setState(() => _searchQuery = val),
                            decoration: InputDecoration(
                              hintText: 'Tarif veya malzeme ara (örn: Guanciale, Tavuk)...',
                              hintStyle: const TextStyle(color: MobColors.textMuted, fontSize: 13),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: MobColors.textSecondary,
                                size: 20,
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
                              'Aradığın kriterlere uygun tarif bulunamadı',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: MobColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Farklı bir arama yapabilir veya dolabındaki malzemelerle Gemini AI\'a özel bir tarif ürettirebilirsin.',
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
                                'Dolaptan Tarif Üret',
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
          'Dolaptan Üret',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.2),
        ),
      ),
    );
  }
}
