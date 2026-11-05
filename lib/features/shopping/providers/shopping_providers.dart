import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../../recipes/providers/recipe_providers.dart';
import '../data/repositories/shopping_repository_impl.dart';
import '../domain/entities/shopping_list_item.dart';
import '../domain/repositories/shopping_repository.dart';
import '../domain/services/smart_shopping_aggregator.dart';

final shoppingRepositoryProvider = Provider<ShoppingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final recipeRepo = ref.watch(recipeRepositoryProvider);
  return ShoppingRepositoryImpl(db: db, recipeRepo: recipeRepo);
});

final shoppingPlanProvider = StreamProvider<List<ShoppingPlanEntry>>((ref) {
  return ref.watch(shoppingRepositoryProvider).watchPlan();
});

final shoppingListItemsProvider = StreamProvider<List<ShoppingListItem>>((ref) {
  return ref.watch(shoppingRepositoryProvider).watchItems();
});
