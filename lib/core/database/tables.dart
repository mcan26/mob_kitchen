import 'package:drift/drift.dart';

import 'converters.dart';

/// Tarif ana tablosu. Makrolar (porsiyon başına) düz sütunlardır.
/// Enum alanları (category, difficulty) JSON değerleriyle metin olarak saklanır.
@DataClassName('RecipeRow')
class Recipes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get category => text()();
  IntColumn get prepTimeMinutes => integer()();
  IntColumn get cookTimeMinutes => integer()();
  IntColumn get baseServings => integer()();
  TextColumn get difficulty => text()();
  IntColumn get kcal => integer()();
  IntColumn get proteinG => integer()();
  IntColumn get carbsG => integer()();
  IntColumn get fatG => integer()();
  TextColumn get tags => text().map(const StringListConverter())();
  TextColumn get chefGoldenRules => text().map(const StringListConverter())();
  TextColumn get storageAndReheatingTip => text()();
  BoolColumn get isBuiltIn => boolean().withDefault(const Constant(false))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  TextColumn get sourceRecipeId => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RecipeIngredientRow')
class RecipeIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();

  /// Tarif içindeki gösterim sırası.
  IntColumn get position => integer()();
  TextColumn get name => text()();
  RealColumn get amount => real()();
  TextColumn get unit => text()();
  TextColumn get aisleCategory => text()();
  TextColumn get preparationNote => text().nullable()();
  TextColumn get buyingTip => text().nullable()();
  TextColumn get substituteOption => text().nullable()();
}

@DataClassName('RecipeStepRow')
class RecipeSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get stepNumber => integer()();
  TextColumn get title => text()();
  TextColumn get instruction => text()();
  TextColumn get sensoryCue => text()();
  TextColumn get chefTip => text()();
  IntColumn get timerSeconds => integer().nullable()();
  TextColumn get mistakeWarning => text().nullable()();
}

/// Alışveriş listesinin birleştirilmiş (aggregate) satırları.
@DataClassName('ShoppingListItemRow')
class ShoppingListItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  RealColumn get aggregatedAmount => real()();
  TextColumn get unit => text()();
  TextColumn get aisleCategory => text()();
  TextColumn get buyingTip => text().nullable()();
  TextColumn get substituteOption => text().nullable()();
  BoolColumn get isChecked => boolean().withDefault(const Constant(false))();
  TextColumn get sourceRecipeTitles => text().map(const StringListConverter())();

  @override
  Set<Column> get primaryKey => {id};
}

/// Alışveriş listesine eklenen tarifler ve seçilen porsiyon sayıları.
/// FAZ 2'deki `SmartShoppingAggregator` listeyi bu tablodan yeniden hesaplar.
@DataClassName('ShoppingPlanRecipeRow')
class ShoppingPlanRecipes extends Table {
  TextColumn get recipeId =>
      text().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get servings => integer()();

  @override
  Set<Column> get primaryKey => {recipeId};
}

/// Küçük anahtar-değer tablosu (örn. `seed_version`).
@DataClassName('AppMetaRow')
class AppMeta extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}
