import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/domain/aisle_category.dart';
import '../../../core/theme/mob_colors.dart';
import '../../recipes/domain/services/portion_scaler.dart';
import '../../wireless/presentation/smart_kitchen_hub_screen.dart';
import '../../wireless/providers/wireless_providers.dart';
import '../domain/entities/shopping_list_item.dart';
import '../providers/shopping_providers.dart';

/// Mob Kitchen Süpermarket Modu: Reyon bazlı gruplanmış, akıllı birleştirilmiş,
/// açılıp kapanabilir (collapsible) reyonlar, market tüyoları ve alternatif malzemelerle donatılmış alışveriş listesi.
class SupermarketScreen extends ConsumerStatefulWidget {
  const SupermarketScreen({super.key});

  @override
  ConsumerState<SupermarketScreen> createState() => _SupermarketScreenState();
}

class _SupermarketScreenState extends ConsumerState<SupermarketScreen> {
  final Set<AisleCategory> _collapsedAisles = {};

  void _toggleAisle(AisleCategory aisle) {
    setState(() {
      if (_collapsedAisles.contains(aisle)) {
        _collapsedAisles.remove(aisle);
      } else {
        _collapsedAisles.add(aisle);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(shoppingListItemsProvider);
    final planAsync = ref.watch(shoppingPlanProvider);

    return Scaffold(
      backgroundColor: MobColors.background,
      appBar: AppBar(
        backgroundColor: MobColors.surface,
        title: const Text(
          'Supermarket Mode',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MobColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            tooltip: 'Wi-Fi Co-Op Sync',
            icon: const Icon(Icons.wifi_tethering, color: MobColors.green, size: 20),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SmartKitchenHubScreen(
                    initialTab: WirelessHubTab.coop,
                  ),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Copy List to Clipboard',
            icon: const Icon(Icons.copy_all_outlined, color: MobColors.primaryLight, size: 20),
            onPressed: () {
              final items = itemsAsync.valueOrNull ?? const [];
              if (items.isEmpty) return;
              final buffer = StringBuffer('🛒 SimmerLink Grocery List\n\n');
              for (final item in items) {
                final check = item.isChecked ? '✅' : '⬜';
                final amt = PortionScaler.formatAmount(item.aggregatedAmount, item.unit);
                final unit = item.unit.label;
                buffer.writeln('$check ${item.name} — ${unit.isEmpty ? amt : '$amt $unit'} (${item.aisleCategory.label})');
              }
              Clipboard.setData(ClipboardData(text: buffer.toString()));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Grocery list copied to clipboard! You can paste it into WhatsApp or Notes.'),
                  backgroundColor: MobColors.green,
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: MobColors.textPrimary),
            color: MobColors.card,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            onSelected: (val) async {
              final repo = ref.read(shoppingRepositoryProvider);
              if (val == 'clear_checked') {
                await repo.clearCheckedItems();
              } else if (val == 'clear_all') {
                await repo.clearPlan();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'clear_checked',
                child: Row(
                  children: [
                    Icon(Icons.remove_done, size: 18, color: MobColors.textSecondary),
                    SizedBox(width: 10),
                    Text('Clear Checked', style: TextStyle(color: MobColors.textPrimary)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Row(
                  children: [
                    Icon(Icons.delete_sweep_outlined, size: 18, color: MobColors.red),
                    SizedBox(width: 10),
                    Text('Reset Entire List', style: TextStyle(color: MobColors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: itemsAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MobColors.primary),
        ),
        error: (err, _) => Center(
          child: Text('Failed to load list: $err', style: const TextStyle(color: MobColors.red)),
        ),
        data: (items) {
          if (items.isEmpty) {
            return _buildEmptyState(context);
          }

          final checkedCount = items.where((i) => i.isChecked).length;
          final totalCount = items.length;
          final progress = totalCount > 0 ? checkedCount / totalCount : 0.0;

          // Group by aisle in shopping order
          final grouped = <AisleCategory, List<ShoppingListItem>>{};
          for (final item in items) {
            grouped.putIfAbsent(item.aisleCategory, () => []).add(item);
          }

          final sortedAisles = grouped.keys.toList()
            ..sort((a, b) => a.shoppingOrder.compareTo(b.shoppingOrder));

          return CustomScrollView(
            slivers: [
              // 1. Progress and plan summary bar
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: MobColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MobColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart_outlined, color: MobColors.primaryLight, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                '$checkedCount / $totalCount Items in Cart',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: MobColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '%${(progress * 100).toInt()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: MobColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: MobColors.card,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            progress == 1.0 ? MobColors.green : MobColors.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                      // Planned recipe tags
                      planAsync.when(
                        data: (plans) {
                          if (plans.isEmpty) return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: plans.map((p) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: MobColors.card,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: MobColors.border),
                                  ),
                                  child: Text(
                                    '${p.recipe.title} (${p.servings} servings)',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: MobColors.textSecondary,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, stack) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Reyon Grupları (Açılıp Kapanabilir - Collapsible)
              for (final aisle in sortedAisles) ...[
                _buildAisleHeaderSliver(aisle, grouped[aisle]!),
                if (!_collapsedAisles.contains(aisle)) ...[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final item = grouped[aisle]![index];
                          return _ShoppingItemTile(item: item);
                        },
                        childCount: grouped[aisle]!.length,
                      ),
                    ),
                  ),
                ],
              ],
              const SliverToBoxAdapter(child: SizedBox(height: 60)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAisleHeaderSliver(AisleCategory aisle, List<ShoppingListItem> items) {
    final isCollapsed = _collapsedAisles.contains(aisle);
    final checkedInAisle = items.where((i) => i.isChecked).length;
    final allDone = checkedInAisle == items.length && items.isNotEmpty;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _toggleAisle(aisle),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
              child: Row(
                children: [
                  _buildAisleBadge(aisle),
                  const SizedBox(width: 8),
                  Text(
                    aisle.label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: allDone ? MobColors.textMuted : MobColors.textPrimary,
                      letterSpacing: -0.2,
                      decoration: allDone && isCollapsed ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '($checkedInAisle/${items.length})',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: allDone ? MobColors.green : MobColors.textMuted,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    isCollapsed ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down,
                    size: 20,
                    color: MobColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAisleBadge(AisleCategory aisle) {
    final (icon, color) = switch (aisle) {
      AisleCategory.produce => (Icons.eco, MobColors.green),
      AisleCategory.butcherDeli => (Icons.restaurant, MobColors.red),
      AisleCategory.dairy => (Icons.egg, MobColors.gold),
      AisleCategory.bakery => (Icons.bakery_dining, const Color(0xFFD39E82)),
      AisleCategory.pantry => (Icons.kitchen, const Color(0xFF78909C)),
      AisleCategory.spices => (Icons.local_fire_department, MobColors.primaryLight),
    };

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 16, color: color),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.shopping_basket_outlined,
              size: 64,
              color: MobColors.textMuted,
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Grocery List is Empty',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: MobColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore recipes and add them to your plan to automatically aggregate and organize ingredients by supermarket aisle.',
              style: TextStyle(
                fontSize: 13.5,
                color: MobColors.textSecondary,
                height: 1.45,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: MobColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.explore_outlined, size: 18),
              label: const Text('Explore Recipes', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingItemTile extends ConsumerWidget {
  const _ShoppingItemTile({required this.item});

  final ShoppingListItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = item.isChecked;
    final amountStr = PortionScaler.formatAmount(item.aggregatedAmount, item.unit);
    final unitStr = item.unit.label;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isChecked ? MobColors.surface.withValues(alpha: 0.5) : MobColors.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isChecked ? MobColors.border.withValues(alpha: 0.5) : MobColors.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            ref.read(shoppingRepositoryProvider).toggleItemChecked(item.id);
            ref.read(smartKitchenHubProvider.notifier).broadcastCoOpEvent(
                  'shopping_item_toggle',
                  '${!isChecked ? "✅ Added to cart" : "⬜ Removed from cart"}: ${item.name}',
                  payload: {
                    'itemId': item.id,
                    'name': item.name,
                    'checked': !isChecked,
                  },
                );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Checkbox
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isChecked ? MobColors.green : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isChecked ? MobColors.green : MobColors.textMuted,
                          width: 2,
                        ),
                      ),
                      child: isChecked
                          ? const Icon(Icons.check, size: 16, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    // Malzeme Adı
                    Expanded(
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: isChecked ? MobColors.textMuted : MobColors.textPrimary,
                          decoration: isChecked ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Birleştirilmiş Miktar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isChecked ? MobColors.surface : MobColors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        unitStr.isEmpty ? amountStr : '$amountStr $unitStr',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: isChecked ? MobColors.textMuted : MobColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),

                // Kaynak Tarifler
                if (item.sourceRecipeTitles.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Text(
                      'For: ${item.sourceRecipeTitles.join(', ')}',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: isChecked ? MobColors.textMuted.withValues(alpha: 0.6) : MobColors.textSecondary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],

                // Market Tüyosu veya Alternatif
                if (!isChecked &&
                    ((item.buyingTip != null && item.buyingTip!.trim().isNotEmpty) ||
                        (item.substituteOption != null && item.substituteOption!.trim().isNotEmpty))) ...[
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.buyingTip != null && item.buyingTip!.trim().isNotEmpty)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.storefront_outlined, size: 14, color: MobColors.gold),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  item.buyingTip!,
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    height: 1.3,
                                    color: MobColors.gold,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (item.substituteOption != null && item.substituteOption!.trim().isNotEmpty) ...[
                          if (item.buyingTip != null) const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.swap_horiz, size: 14, color: MobColors.green),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Substitute: ${item.substituteOption!}',
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    height: 1.3,
                                    color: MobColors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
