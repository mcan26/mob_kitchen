import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../data/repositories/recipe_repository_impl.dart';
import '../data/seed/recipe_seeder.dart';
import '../domain/entities/recipe.dart';
import '../domain/repositories/recipe_repository.dart';

final recipeRepositoryProvider =
    Provider<RecipeRepository>((ref) => RecipeRepositoryImpl(ref.watch(appDatabaseProvider)));

final recipeSeederProvider =
    Provider<RecipeSeeder>((ref) => RecipeSeeder(ref.watch(appDatabaseProvider)));

final allRecipesProvider =
    StreamProvider<List<Recipe>>((ref) => ref.watch(recipeRepositoryProvider).watchAll());

final recipeByIdProvider = StreamProvider.family<Recipe?, String>(
  (ref, id) => ref.watch(recipeRepositoryProvider).watchById(id),
);
