import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'converters.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Recipes,
    RecipeIngredients,
    RecipeSteps,
    ShoppingListItems,
    ShoppingPlanRecipes,
    AppMeta,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'mob_kitchen'));

  /// Testler için (örn. `NativeDatabase.memory()`).
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        beforeOpen: (details) async {
          // ON DELETE CASCADE için gerekli.
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
