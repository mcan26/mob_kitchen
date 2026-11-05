import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/database/app_database.dart';
import 'package:mob_kitchen/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/data/seed/recipe_seeder.dart';

void main() {
  late AppDatabase db;
  late RecipeRepositoryImpl repo;
  late RecipeSeeder seeder;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = RecipeRepositoryImpl(db);
    seeder = RecipeSeeder(db);
  });

  tearDown(() => db.close());

  test('ilk açılışta tüm yerleşik tarifler eksiksiz yüklenir', () async {
    await seeder.seedIfNeeded();
    final recipes = await repo.watchAll().first;

    expect(recipes.length, kInitialRecipes.length);
    expect(recipes.every((r) => r.isBuiltIn), isTrue);

    // Katalog sırası korunur ve veri kayıpsız gidip gelir.
    for (final (i, seed) in kInitialRecipes.indexed) {
      final loaded = recipes[i];
      expect(loaded.id, seed.id);
      expect(loaded.toJson(), seed.toJson());
    }
  });

  test('ikinci çağrı (aynı sürüm) tekrar yazmaz', () async {
    await seeder.seedIfNeeded();
    await repo.toggleFavorite(kInitialRecipes.first.id);
    await seeder.seedIfNeeded();
    final first = await repo.getById(kInitialRecipes.first.id);
    expect(first!.isFavorite, isTrue);
  });

  test('sürüm artınca favoriler korunur, kullanıcı tarifleri silinmez', () async {
    await seeder.seedIfNeeded();
    await repo.toggleFavorite(kInitialRecipes[2].id);
    final custom = kInitialRecipes.first.copyWith(id: 'ai_test_1', isBuiltIn: false);
    await repo.save(custom);

    await seeder.seedIfNeeded(version: kSeedVersion + 1);

    expect((await repo.getById(kInitialRecipes[2].id))!.isFavorite, isTrue);
    expect(await repo.getById('ai_test_1'), isNotNull);
    expect((await repo.watchAll().first).length, kInitialRecipes.length + 1);
  });

  test('yerleşik tarif silinemez, kullanıcı tarifi silinebilir', () async {
    await seeder.seedIfNeeded();
    await expectLater(repo.delete(kInitialRecipes.first.id), throwsStateError);

    await repo.save(kInitialRecipes.first.copyWith(id: 'ai_test_2', isBuiltIn: false));
    await repo.delete('ai_test_2');
    expect(await repo.getById('ai_test_2'), isNull);

    // Cascade: çocuk satırlar da silinmiş olmalı.
    final orphanSteps =
        await (db.select(db.recipeSteps)..where((t) => t.recipeId.equals('ai_test_2'))).get();
    expect(orphanSteps, isEmpty);
  });
}
