// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RecipesTable extends Recipes with TableInfo<$RecipesTable, RecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepTimeMinutesMeta = const VerificationMeta(
    'prepTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> prepTimeMinutes = GeneratedColumn<int>(
    'prep_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseServingsMeta = const VerificationMeta(
    'baseServings',
  );
  @override
  late final GeneratedColumn<int> baseServings = GeneratedColumn<int>(
    'base_servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kcalMeta = const VerificationMeta('kcal');
  @override
  late final GeneratedColumn<int> kcal = GeneratedColumn<int>(
    'kcal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<int> proteinG = GeneratedColumn<int>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<int> carbsG = GeneratedColumn<int>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<int> fatG = GeneratedColumn<int>(
    'fat_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> tags =
      GeneratedColumn<String>(
        'tags',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($RecipesTable.$convertertags);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  chefGoldenRules = GeneratedColumn<String>(
    'chef_golden_rules',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<List<String>>($RecipesTable.$converterchefGoldenRules);
  static const VerificationMeta _storageAndReheatingTipMeta =
      const VerificationMeta('storageAndReheatingTip');
  @override
  late final GeneratedColumn<String> storageAndReheatingTip =
      GeneratedColumn<String>(
        'storage_and_reheating_tip',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isBuiltInMeta = const VerificationMeta(
    'isBuiltIn',
  );
  @override
  late final GeneratedColumn<bool> isBuiltIn = GeneratedColumn<bool>(
    'is_built_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_built_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sourceRecipeIdMeta = const VerificationMeta(
    'sourceRecipeId',
  );
  @override
  late final GeneratedColumn<String> sourceRecipeId = GeneratedColumn<String>(
    'source_recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    subtitle,
    category,
    prepTimeMinutes,
    cookTimeMinutes,
    baseServings,
    difficulty,
    kcal,
    proteinG,
    carbsG,
    fatG,
    tags,
    chefGoldenRules,
    storageAndReheatingTip,
    isBuiltIn,
    isFavorite,
    sourceRecipeId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    } else if (isInserting) {
      context.missing(_subtitleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('prep_time_minutes')) {
      context.handle(
        _prepTimeMinutesMeta,
        prepTimeMinutes.isAcceptableOrUnknown(
          data['prep_time_minutes']!,
          _prepTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prepTimeMinutesMeta);
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cookTimeMinutesMeta);
    }
    if (data.containsKey('base_servings')) {
      context.handle(
        _baseServingsMeta,
        baseServings.isAcceptableOrUnknown(
          data['base_servings']!,
          _baseServingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseServingsMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('kcal')) {
      context.handle(
        _kcalMeta,
        kcal.isAcceptableOrUnknown(data['kcal']!, _kcalMeta),
      );
    } else if (isInserting) {
      context.missing(_kcalMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatGMeta);
    }
    if (data.containsKey('storage_and_reheating_tip')) {
      context.handle(
        _storageAndReheatingTipMeta,
        storageAndReheatingTip.isAcceptableOrUnknown(
          data['storage_and_reheating_tip']!,
          _storageAndReheatingTipMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storageAndReheatingTipMeta);
    }
    if (data.containsKey('is_built_in')) {
      context.handle(
        _isBuiltInMeta,
        isBuiltIn.isAcceptableOrUnknown(data['is_built_in']!, _isBuiltInMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('source_recipe_id')) {
      context.handle(
        _sourceRecipeIdMeta,
        sourceRecipeId.isAcceptableOrUnknown(
          data['source_recipe_id']!,
          _sourceRecipeIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      prepTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_minutes'],
      )!,
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      )!,
      baseServings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}base_servings'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      kcal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kcal'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fat_g'],
      )!,
      tags: $RecipesTable.$convertertags.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tags'],
        )!,
      ),
      chefGoldenRules: $RecipesTable.$converterchefGoldenRules.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}chef_golden_rules'],
        )!,
      ),
      storageAndReheatingTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_and_reheating_tip'],
      )!,
      isBuiltIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_built_in'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      sourceRecipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_recipe_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>, String> $converterchefGoldenRules =
      const StringListConverter();
}

class RecipeRow extends DataClass implements Insertable<RecipeRow> {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int baseServings;
  final String difficulty;
  final int kcal;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final List<String> tags;
  final List<String> chefGoldenRules;
  final String storageAndReheatingTip;
  final bool isBuiltIn;
  final bool isFavorite;
  final String? sourceRecipeId;
  final DateTime createdAt;
  const RecipeRow({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.baseServings,
    required this.difficulty,
    required this.kcal,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.tags,
    required this.chefGoldenRules,
    required this.storageAndReheatingTip,
    required this.isBuiltIn,
    required this.isFavorite,
    this.sourceRecipeId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['subtitle'] = Variable<String>(subtitle);
    map['category'] = Variable<String>(category);
    map['prep_time_minutes'] = Variable<int>(prepTimeMinutes);
    map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    map['base_servings'] = Variable<int>(baseServings);
    map['difficulty'] = Variable<String>(difficulty);
    map['kcal'] = Variable<int>(kcal);
    map['protein_g'] = Variable<int>(proteinG);
    map['carbs_g'] = Variable<int>(carbsG);
    map['fat_g'] = Variable<int>(fatG);
    {
      map['tags'] = Variable<String>($RecipesTable.$convertertags.toSql(tags));
    }
    {
      map['chef_golden_rules'] = Variable<String>(
        $RecipesTable.$converterchefGoldenRules.toSql(chefGoldenRules),
      );
    }
    map['storage_and_reheating_tip'] = Variable<String>(storageAndReheatingTip);
    map['is_built_in'] = Variable<bool>(isBuiltIn);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || sourceRecipeId != null) {
      map['source_recipe_id'] = Variable<String>(sourceRecipeId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      title: Value(title),
      subtitle: Value(subtitle),
      category: Value(category),
      prepTimeMinutes: Value(prepTimeMinutes),
      cookTimeMinutes: Value(cookTimeMinutes),
      baseServings: Value(baseServings),
      difficulty: Value(difficulty),
      kcal: Value(kcal),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      tags: Value(tags),
      chefGoldenRules: Value(chefGoldenRules),
      storageAndReheatingTip: Value(storageAndReheatingTip),
      isBuiltIn: Value(isBuiltIn),
      isFavorite: Value(isFavorite),
      sourceRecipeId: sourceRecipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecipeId),
      createdAt: Value(createdAt),
    );
  }

  factory RecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String>(json['subtitle']),
      category: serializer.fromJson<String>(json['category']),
      prepTimeMinutes: serializer.fromJson<int>(json['prepTimeMinutes']),
      cookTimeMinutes: serializer.fromJson<int>(json['cookTimeMinutes']),
      baseServings: serializer.fromJson<int>(json['baseServings']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      kcal: serializer.fromJson<int>(json['kcal']),
      proteinG: serializer.fromJson<int>(json['proteinG']),
      carbsG: serializer.fromJson<int>(json['carbsG']),
      fatG: serializer.fromJson<int>(json['fatG']),
      tags: serializer.fromJson<List<String>>(json['tags']),
      chefGoldenRules: serializer.fromJson<List<String>>(
        json['chefGoldenRules'],
      ),
      storageAndReheatingTip: serializer.fromJson<String>(
        json['storageAndReheatingTip'],
      ),
      isBuiltIn: serializer.fromJson<bool>(json['isBuiltIn']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      sourceRecipeId: serializer.fromJson<String?>(json['sourceRecipeId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String>(subtitle),
      'category': serializer.toJson<String>(category),
      'prepTimeMinutes': serializer.toJson<int>(prepTimeMinutes),
      'cookTimeMinutes': serializer.toJson<int>(cookTimeMinutes),
      'baseServings': serializer.toJson<int>(baseServings),
      'difficulty': serializer.toJson<String>(difficulty),
      'kcal': serializer.toJson<int>(kcal),
      'proteinG': serializer.toJson<int>(proteinG),
      'carbsG': serializer.toJson<int>(carbsG),
      'fatG': serializer.toJson<int>(fatG),
      'tags': serializer.toJson<List<String>>(tags),
      'chefGoldenRules': serializer.toJson<List<String>>(chefGoldenRules),
      'storageAndReheatingTip': serializer.toJson<String>(
        storageAndReheatingTip,
      ),
      'isBuiltIn': serializer.toJson<bool>(isBuiltIn),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'sourceRecipeId': serializer.toJson<String?>(sourceRecipeId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecipeRow copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? category,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? baseServings,
    String? difficulty,
    int? kcal,
    int? proteinG,
    int? carbsG,
    int? fatG,
    List<String>? tags,
    List<String>? chefGoldenRules,
    String? storageAndReheatingTip,
    bool? isBuiltIn,
    bool? isFavorite,
    Value<String?> sourceRecipeId = const Value.absent(),
    DateTime? createdAt,
  }) => RecipeRow(
    id: id ?? this.id,
    title: title ?? this.title,
    subtitle: subtitle ?? this.subtitle,
    category: category ?? this.category,
    prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
    baseServings: baseServings ?? this.baseServings,
    difficulty: difficulty ?? this.difficulty,
    kcal: kcal ?? this.kcal,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatG: fatG ?? this.fatG,
    tags: tags ?? this.tags,
    chefGoldenRules: chefGoldenRules ?? this.chefGoldenRules,
    storageAndReheatingTip:
        storageAndReheatingTip ?? this.storageAndReheatingTip,
    isBuiltIn: isBuiltIn ?? this.isBuiltIn,
    isFavorite: isFavorite ?? this.isFavorite,
    sourceRecipeId: sourceRecipeId.present
        ? sourceRecipeId.value
        : this.sourceRecipeId,
    createdAt: createdAt ?? this.createdAt,
  );
  RecipeRow copyWithCompanion(RecipesCompanion data) {
    return RecipeRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      category: data.category.present ? data.category.value : this.category,
      prepTimeMinutes: data.prepTimeMinutes.present
          ? data.prepTimeMinutes.value
          : this.prepTimeMinutes,
      cookTimeMinutes: data.cookTimeMinutes.present
          ? data.cookTimeMinutes.value
          : this.cookTimeMinutes,
      baseServings: data.baseServings.present
          ? data.baseServings.value
          : this.baseServings,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      kcal: data.kcal.present ? data.kcal.value : this.kcal,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      tags: data.tags.present ? data.tags.value : this.tags,
      chefGoldenRules: data.chefGoldenRules.present
          ? data.chefGoldenRules.value
          : this.chefGoldenRules,
      storageAndReheatingTip: data.storageAndReheatingTip.present
          ? data.storageAndReheatingTip.value
          : this.storageAndReheatingTip,
      isBuiltIn: data.isBuiltIn.present ? data.isBuiltIn.value : this.isBuiltIn,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      sourceRecipeId: data.sourceRecipeId.present
          ? data.sourceRecipeId.value
          : this.sourceRecipeId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('category: $category, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('baseServings: $baseServings, ')
          ..write('difficulty: $difficulty, ')
          ..write('kcal: $kcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('tags: $tags, ')
          ..write('chefGoldenRules: $chefGoldenRules, ')
          ..write('storageAndReheatingTip: $storageAndReheatingTip, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sourceRecipeId: $sourceRecipeId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    subtitle,
    category,
    prepTimeMinutes,
    cookTimeMinutes,
    baseServings,
    difficulty,
    kcal,
    proteinG,
    carbsG,
    fatG,
    tags,
    chefGoldenRules,
    storageAndReheatingTip,
    isBuiltIn,
    isFavorite,
    sourceRecipeId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.category == this.category &&
          other.prepTimeMinutes == this.prepTimeMinutes &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.baseServings == this.baseServings &&
          other.difficulty == this.difficulty &&
          other.kcal == this.kcal &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.tags == this.tags &&
          other.chefGoldenRules == this.chefGoldenRules &&
          other.storageAndReheatingTip == this.storageAndReheatingTip &&
          other.isBuiltIn == this.isBuiltIn &&
          other.isFavorite == this.isFavorite &&
          other.sourceRecipeId == this.sourceRecipeId &&
          other.createdAt == this.createdAt);
}

class RecipesCompanion extends UpdateCompanion<RecipeRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> subtitle;
  final Value<String> category;
  final Value<int> prepTimeMinutes;
  final Value<int> cookTimeMinutes;
  final Value<int> baseServings;
  final Value<String> difficulty;
  final Value<int> kcal;
  final Value<int> proteinG;
  final Value<int> carbsG;
  final Value<int> fatG;
  final Value<List<String>> tags;
  final Value<List<String>> chefGoldenRules;
  final Value<String> storageAndReheatingTip;
  final Value<bool> isBuiltIn;
  final Value<bool> isFavorite;
  final Value<String?> sourceRecipeId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.category = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.baseServings = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.kcal = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.tags = const Value.absent(),
    this.chefGoldenRules = const Value.absent(),
    this.storageAndReheatingTip = const Value.absent(),
    this.isBuiltIn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.sourceRecipeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipesCompanion.insert({
    required String id,
    required String title,
    required String subtitle,
    required String category,
    required int prepTimeMinutes,
    required int cookTimeMinutes,
    required int baseServings,
    required String difficulty,
    required int kcal,
    required int proteinG,
    required int carbsG,
    required int fatG,
    required List<String> tags,
    required List<String> chefGoldenRules,
    required String storageAndReheatingTip,
    this.isBuiltIn = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.sourceRecipeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       subtitle = Value(subtitle),
       category = Value(category),
       prepTimeMinutes = Value(prepTimeMinutes),
       cookTimeMinutes = Value(cookTimeMinutes),
       baseServings = Value(baseServings),
       difficulty = Value(difficulty),
       kcal = Value(kcal),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatG = Value(fatG),
       tags = Value(tags),
       chefGoldenRules = Value(chefGoldenRules),
       storageAndReheatingTip = Value(storageAndReheatingTip);
  static Insertable<RecipeRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<String>? category,
    Expression<int>? prepTimeMinutes,
    Expression<int>? cookTimeMinutes,
    Expression<int>? baseServings,
    Expression<String>? difficulty,
    Expression<int>? kcal,
    Expression<int>? proteinG,
    Expression<int>? carbsG,
    Expression<int>? fatG,
    Expression<String>? tags,
    Expression<String>? chefGoldenRules,
    Expression<String>? storageAndReheatingTip,
    Expression<bool>? isBuiltIn,
    Expression<bool>? isFavorite,
    Expression<String>? sourceRecipeId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (category != null) 'category': category,
      if (prepTimeMinutes != null) 'prep_time_minutes': prepTimeMinutes,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (baseServings != null) 'base_servings': baseServings,
      if (difficulty != null) 'difficulty': difficulty,
      if (kcal != null) 'kcal': kcal,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (tags != null) 'tags': tags,
      if (chefGoldenRules != null) 'chef_golden_rules': chefGoldenRules,
      if (storageAndReheatingTip != null)
        'storage_and_reheating_tip': storageAndReheatingTip,
      if (isBuiltIn != null) 'is_built_in': isBuiltIn,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (sourceRecipeId != null) 'source_recipe_id': sourceRecipeId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? subtitle,
    Value<String>? category,
    Value<int>? prepTimeMinutes,
    Value<int>? cookTimeMinutes,
    Value<int>? baseServings,
    Value<String>? difficulty,
    Value<int>? kcal,
    Value<int>? proteinG,
    Value<int>? carbsG,
    Value<int>? fatG,
    Value<List<String>>? tags,
    Value<List<String>>? chefGoldenRules,
    Value<String>? storageAndReheatingTip,
    Value<bool>? isBuiltIn,
    Value<bool>? isFavorite,
    Value<String?>? sourceRecipeId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      baseServings: baseServings ?? this.baseServings,
      difficulty: difficulty ?? this.difficulty,
      kcal: kcal ?? this.kcal,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      tags: tags ?? this.tags,
      chefGoldenRules: chefGoldenRules ?? this.chefGoldenRules,
      storageAndReheatingTip:
          storageAndReheatingTip ?? this.storageAndReheatingTip,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      isFavorite: isFavorite ?? this.isFavorite,
      sourceRecipeId: sourceRecipeId ?? this.sourceRecipeId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (prepTimeMinutes.present) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (baseServings.present) {
      map['base_servings'] = Variable<int>(baseServings.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (kcal.present) {
      map['kcal'] = Variable<int>(kcal.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<int>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<int>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<int>(fatG.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(
        $RecipesTable.$convertertags.toSql(tags.value),
      );
    }
    if (chefGoldenRules.present) {
      map['chef_golden_rules'] = Variable<String>(
        $RecipesTable.$converterchefGoldenRules.toSql(chefGoldenRules.value),
      );
    }
    if (storageAndReheatingTip.present) {
      map['storage_and_reheating_tip'] = Variable<String>(
        storageAndReheatingTip.value,
      );
    }
    if (isBuiltIn.present) {
      map['is_built_in'] = Variable<bool>(isBuiltIn.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (sourceRecipeId.present) {
      map['source_recipe_id'] = Variable<String>(sourceRecipeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('category: $category, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('baseServings: $baseServings, ')
          ..write('difficulty: $difficulty, ')
          ..write('kcal: $kcal, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('tags: $tags, ')
          ..write('chefGoldenRules: $chefGoldenRules, ')
          ..write('storageAndReheatingTip: $storageAndReheatingTip, ')
          ..write('isBuiltIn: $isBuiltIn, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('sourceRecipeId: $sourceRecipeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredientRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aisleCategoryMeta = const VerificationMeta(
    'aisleCategory',
  );
  @override
  late final GeneratedColumn<String> aisleCategory = GeneratedColumn<String>(
    'aisle_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _preparationNoteMeta = const VerificationMeta(
    'preparationNote',
  );
  @override
  late final GeneratedColumn<String> preparationNote = GeneratedColumn<String>(
    'preparation_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _buyingTipMeta = const VerificationMeta(
    'buyingTip',
  );
  @override
  late final GeneratedColumn<String> buyingTip = GeneratedColumn<String>(
    'buying_tip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _substituteOptionMeta = const VerificationMeta(
    'substituteOption',
  );
  @override
  late final GeneratedColumn<String> substituteOption = GeneratedColumn<String>(
    'substitute_option',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    position,
    name,
    amount,
    unit,
    aisleCategory,
    preparationNote,
    buyingTip,
    substituteOption,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredientRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('aisle_category')) {
      context.handle(
        _aisleCategoryMeta,
        aisleCategory.isAcceptableOrUnknown(
          data['aisle_category']!,
          _aisleCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aisleCategoryMeta);
    }
    if (data.containsKey('preparation_note')) {
      context.handle(
        _preparationNoteMeta,
        preparationNote.isAcceptableOrUnknown(
          data['preparation_note']!,
          _preparationNoteMeta,
        ),
      );
    }
    if (data.containsKey('buying_tip')) {
      context.handle(
        _buyingTipMeta,
        buyingTip.isAcceptableOrUnknown(data['buying_tip']!, _buyingTipMeta),
      );
    }
    if (data.containsKey('substitute_option')) {
      context.handle(
        _substituteOptionMeta,
        substituteOption.isAcceptableOrUnknown(
          data['substitute_option']!,
          _substituteOptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeIngredientRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredientRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      aisleCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aisle_category'],
      )!,
      preparationNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preparation_note'],
      ),
      buyingTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buying_tip'],
      ),
      substituteOption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substitute_option'],
      ),
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredientRow extends DataClass
    implements Insertable<RecipeIngredientRow> {
  final int id;
  final String recipeId;

  /// Tarif içindeki gösterim sırası.
  final int position;
  final String name;
  final double amount;
  final String unit;
  final String aisleCategory;
  final String? preparationNote;
  final String? buyingTip;
  final String? substituteOption;
  const RecipeIngredientRow({
    required this.id,
    required this.recipeId,
    required this.position,
    required this.name,
    required this.amount,
    required this.unit,
    required this.aisleCategory,
    this.preparationNote,
    this.buyingTip,
    this.substituteOption,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['position'] = Variable<int>(position);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['unit'] = Variable<String>(unit);
    map['aisle_category'] = Variable<String>(aisleCategory);
    if (!nullToAbsent || preparationNote != null) {
      map['preparation_note'] = Variable<String>(preparationNote);
    }
    if (!nullToAbsent || buyingTip != null) {
      map['buying_tip'] = Variable<String>(buyingTip);
    }
    if (!nullToAbsent || substituteOption != null) {
      map['substitute_option'] = Variable<String>(substituteOption);
    }
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      position: Value(position),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      aisleCategory: Value(aisleCategory),
      preparationNote: preparationNote == null && nullToAbsent
          ? const Value.absent()
          : Value(preparationNote),
      buyingTip: buyingTip == null && nullToAbsent
          ? const Value.absent()
          : Value(buyingTip),
      substituteOption: substituteOption == null && nullToAbsent
          ? const Value.absent()
          : Value(substituteOption),
    );
  }

  factory RecipeIngredientRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredientRow(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      position: serializer.fromJson<int>(json['position']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      aisleCategory: serializer.fromJson<String>(json['aisleCategory']),
      preparationNote: serializer.fromJson<String?>(json['preparationNote']),
      buyingTip: serializer.fromJson<String?>(json['buyingTip']),
      substituteOption: serializer.fromJson<String?>(json['substituteOption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'position': serializer.toJson<int>(position),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'unit': serializer.toJson<String>(unit),
      'aisleCategory': serializer.toJson<String>(aisleCategory),
      'preparationNote': serializer.toJson<String?>(preparationNote),
      'buyingTip': serializer.toJson<String?>(buyingTip),
      'substituteOption': serializer.toJson<String?>(substituteOption),
    };
  }

  RecipeIngredientRow copyWith({
    int? id,
    String? recipeId,
    int? position,
    String? name,
    double? amount,
    String? unit,
    String? aisleCategory,
    Value<String?> preparationNote = const Value.absent(),
    Value<String?> buyingTip = const Value.absent(),
    Value<String?> substituteOption = const Value.absent(),
  }) => RecipeIngredientRow(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    position: position ?? this.position,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    aisleCategory: aisleCategory ?? this.aisleCategory,
    preparationNote: preparationNote.present
        ? preparationNote.value
        : this.preparationNote,
    buyingTip: buyingTip.present ? buyingTip.value : this.buyingTip,
    substituteOption: substituteOption.present
        ? substituteOption.value
        : this.substituteOption,
  );
  RecipeIngredientRow copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredientRow(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      position: data.position.present ? data.position.value : this.position,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      aisleCategory: data.aisleCategory.present
          ? data.aisleCategory.value
          : this.aisleCategory,
      preparationNote: data.preparationNote.present
          ? data.preparationNote.value
          : this.preparationNote,
      buyingTip: data.buyingTip.present ? data.buyingTip.value : this.buyingTip,
      substituteOption: data.substituteOption.present
          ? data.substituteOption.value
          : this.substituteOption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientRow(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('aisleCategory: $aisleCategory, ')
          ..write('preparationNote: $preparationNote, ')
          ..write('buyingTip: $buyingTip, ')
          ..write('substituteOption: $substituteOption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    position,
    name,
    amount,
    unit,
    aisleCategory,
    preparationNote,
    buyingTip,
    substituteOption,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredientRow &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.position == this.position &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.aisleCategory == this.aisleCategory &&
          other.preparationNote == this.preparationNote &&
          other.buyingTip == this.buyingTip &&
          other.substituteOption == this.substituteOption);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredientRow> {
  final Value<int> id;
  final Value<String> recipeId;
  final Value<int> position;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> unit;
  final Value<String> aisleCategory;
  final Value<String?> preparationNote;
  final Value<String?> buyingTip;
  final Value<String?> substituteOption;
  const RecipeIngredientsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.position = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.aisleCategory = const Value.absent(),
    this.preparationNote = const Value.absent(),
    this.buyingTip = const Value.absent(),
    this.substituteOption = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String recipeId,
    required int position,
    required String name,
    required double amount,
    required String unit,
    required String aisleCategory,
    this.preparationNote = const Value.absent(),
    this.buyingTip = const Value.absent(),
    this.substituteOption = const Value.absent(),
  }) : recipeId = Value(recipeId),
       position = Value(position),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit),
       aisleCategory = Value(aisleCategory);
  static Insertable<RecipeIngredientRow> custom({
    Expression<int>? id,
    Expression<String>? recipeId,
    Expression<int>? position,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? unit,
    Expression<String>? aisleCategory,
    Expression<String>? preparationNote,
    Expression<String>? buyingTip,
    Expression<String>? substituteOption,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (position != null) 'position': position,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (aisleCategory != null) 'aisle_category': aisleCategory,
      if (preparationNote != null) 'preparation_note': preparationNote,
      if (buyingTip != null) 'buying_tip': buyingTip,
      if (substituteOption != null) 'substitute_option': substituteOption,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? recipeId,
    Value<int>? position,
    Value<String>? name,
    Value<double>? amount,
    Value<String>? unit,
    Value<String>? aisleCategory,
    Value<String?>? preparationNote,
    Value<String?>? buyingTip,
    Value<String?>? substituteOption,
  }) {
    return RecipeIngredientsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      position: position ?? this.position,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      aisleCategory: aisleCategory ?? this.aisleCategory,
      preparationNote: preparationNote ?? this.preparationNote,
      buyingTip: buyingTip ?? this.buyingTip,
      substituteOption: substituteOption ?? this.substituteOption,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (aisleCategory.present) {
      map['aisle_category'] = Variable<String>(aisleCategory.value);
    }
    if (preparationNote.present) {
      map['preparation_note'] = Variable<String>(preparationNote.value);
    }
    if (buyingTip.present) {
      map['buying_tip'] = Variable<String>(buyingTip.value);
    }
    if (substituteOption.present) {
      map['substitute_option'] = Variable<String>(substituteOption.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('position: $position, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('aisleCategory: $aisleCategory, ')
          ..write('preparationNote: $preparationNote, ')
          ..write('buyingTip: $buyingTip, ')
          ..write('substituteOption: $substituteOption')
          ..write(')'))
        .toString();
  }
}

class $RecipeStepsTable extends RecipeSteps
    with TableInfo<$RecipeStepsTable, RecipeStepRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepNumberMeta = const VerificationMeta(
    'stepNumber',
  );
  @override
  late final GeneratedColumn<int> stepNumber = GeneratedColumn<int>(
    'step_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionMeta = const VerificationMeta(
    'instruction',
  );
  @override
  late final GeneratedColumn<String> instruction = GeneratedColumn<String>(
    'instruction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sensoryCueMeta = const VerificationMeta(
    'sensoryCue',
  );
  @override
  late final GeneratedColumn<String> sensoryCue = GeneratedColumn<String>(
    'sensory_cue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chefTipMeta = const VerificationMeta(
    'chefTip',
  );
  @override
  late final GeneratedColumn<String> chefTip = GeneratedColumn<String>(
    'chef_tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timerSecondsMeta = const VerificationMeta(
    'timerSeconds',
  );
  @override
  late final GeneratedColumn<int> timerSeconds = GeneratedColumn<int>(
    'timer_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mistakeWarningMeta = const VerificationMeta(
    'mistakeWarning',
  );
  @override
  late final GeneratedColumn<String> mistakeWarning = GeneratedColumn<String>(
    'mistake_warning',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    stepNumber,
    title,
    instruction,
    sensoryCue,
    chefTip,
    timerSeconds,
    mistakeWarning,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeStepRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('step_number')) {
      context.handle(
        _stepNumberMeta,
        stepNumber.isAcceptableOrUnknown(data['step_number']!, _stepNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_stepNumberMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('instruction')) {
      context.handle(
        _instructionMeta,
        instruction.isAcceptableOrUnknown(
          data['instruction']!,
          _instructionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionMeta);
    }
    if (data.containsKey('sensory_cue')) {
      context.handle(
        _sensoryCueMeta,
        sensoryCue.isAcceptableOrUnknown(data['sensory_cue']!, _sensoryCueMeta),
      );
    } else if (isInserting) {
      context.missing(_sensoryCueMeta);
    }
    if (data.containsKey('chef_tip')) {
      context.handle(
        _chefTipMeta,
        chefTip.isAcceptableOrUnknown(data['chef_tip']!, _chefTipMeta),
      );
    } else if (isInserting) {
      context.missing(_chefTipMeta);
    }
    if (data.containsKey('timer_seconds')) {
      context.handle(
        _timerSecondsMeta,
        timerSeconds.isAcceptableOrUnknown(
          data['timer_seconds']!,
          _timerSecondsMeta,
        ),
      );
    }
    if (data.containsKey('mistake_warning')) {
      context.handle(
        _mistakeWarningMeta,
        mistakeWarning.isAcceptableOrUnknown(
          data['mistake_warning']!,
          _mistakeWarningMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeStepRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeStepRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      stepNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_number'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      instruction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instruction'],
      )!,
      sensoryCue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_cue'],
      )!,
      chefTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chef_tip'],
      )!,
      timerSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timer_seconds'],
      ),
      mistakeWarning: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mistake_warning'],
      ),
    );
  }

  @override
  $RecipeStepsTable createAlias(String alias) {
    return $RecipeStepsTable(attachedDatabase, alias);
  }
}

class RecipeStepRow extends DataClass implements Insertable<RecipeStepRow> {
  final int id;
  final String recipeId;
  final int stepNumber;
  final String title;
  final String instruction;
  final String sensoryCue;
  final String chefTip;
  final int? timerSeconds;
  final String? mistakeWarning;
  const RecipeStepRow({
    required this.id,
    required this.recipeId,
    required this.stepNumber,
    required this.title,
    required this.instruction,
    required this.sensoryCue,
    required this.chefTip,
    this.timerSeconds,
    this.mistakeWarning,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['step_number'] = Variable<int>(stepNumber);
    map['title'] = Variable<String>(title);
    map['instruction'] = Variable<String>(instruction);
    map['sensory_cue'] = Variable<String>(sensoryCue);
    map['chef_tip'] = Variable<String>(chefTip);
    if (!nullToAbsent || timerSeconds != null) {
      map['timer_seconds'] = Variable<int>(timerSeconds);
    }
    if (!nullToAbsent || mistakeWarning != null) {
      map['mistake_warning'] = Variable<String>(mistakeWarning);
    }
    return map;
  }

  RecipeStepsCompanion toCompanion(bool nullToAbsent) {
    return RecipeStepsCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      stepNumber: Value(stepNumber),
      title: Value(title),
      instruction: Value(instruction),
      sensoryCue: Value(sensoryCue),
      chefTip: Value(chefTip),
      timerSeconds: timerSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(timerSeconds),
      mistakeWarning: mistakeWarning == null && nullToAbsent
          ? const Value.absent()
          : Value(mistakeWarning),
    );
  }

  factory RecipeStepRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeStepRow(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      stepNumber: serializer.fromJson<int>(json['stepNumber']),
      title: serializer.fromJson<String>(json['title']),
      instruction: serializer.fromJson<String>(json['instruction']),
      sensoryCue: serializer.fromJson<String>(json['sensoryCue']),
      chefTip: serializer.fromJson<String>(json['chefTip']),
      timerSeconds: serializer.fromJson<int?>(json['timerSeconds']),
      mistakeWarning: serializer.fromJson<String?>(json['mistakeWarning']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'stepNumber': serializer.toJson<int>(stepNumber),
      'title': serializer.toJson<String>(title),
      'instruction': serializer.toJson<String>(instruction),
      'sensoryCue': serializer.toJson<String>(sensoryCue),
      'chefTip': serializer.toJson<String>(chefTip),
      'timerSeconds': serializer.toJson<int?>(timerSeconds),
      'mistakeWarning': serializer.toJson<String?>(mistakeWarning),
    };
  }

  RecipeStepRow copyWith({
    int? id,
    String? recipeId,
    int? stepNumber,
    String? title,
    String? instruction,
    String? sensoryCue,
    String? chefTip,
    Value<int?> timerSeconds = const Value.absent(),
    Value<String?> mistakeWarning = const Value.absent(),
  }) => RecipeStepRow(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    stepNumber: stepNumber ?? this.stepNumber,
    title: title ?? this.title,
    instruction: instruction ?? this.instruction,
    sensoryCue: sensoryCue ?? this.sensoryCue,
    chefTip: chefTip ?? this.chefTip,
    timerSeconds: timerSeconds.present ? timerSeconds.value : this.timerSeconds,
    mistakeWarning: mistakeWarning.present
        ? mistakeWarning.value
        : this.mistakeWarning,
  );
  RecipeStepRow copyWithCompanion(RecipeStepsCompanion data) {
    return RecipeStepRow(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      stepNumber: data.stepNumber.present
          ? data.stepNumber.value
          : this.stepNumber,
      title: data.title.present ? data.title.value : this.title,
      instruction: data.instruction.present
          ? data.instruction.value
          : this.instruction,
      sensoryCue: data.sensoryCue.present
          ? data.sensoryCue.value
          : this.sensoryCue,
      chefTip: data.chefTip.present ? data.chefTip.value : this.chefTip,
      timerSeconds: data.timerSeconds.present
          ? data.timerSeconds.value
          : this.timerSeconds,
      mistakeWarning: data.mistakeWarning.present
          ? data.mistakeWarning.value
          : this.mistakeWarning,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepRow(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('title: $title, ')
          ..write('instruction: $instruction, ')
          ..write('sensoryCue: $sensoryCue, ')
          ..write('chefTip: $chefTip, ')
          ..write('timerSeconds: $timerSeconds, ')
          ..write('mistakeWarning: $mistakeWarning')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    stepNumber,
    title,
    instruction,
    sensoryCue,
    chefTip,
    timerSeconds,
    mistakeWarning,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeStepRow &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.stepNumber == this.stepNumber &&
          other.title == this.title &&
          other.instruction == this.instruction &&
          other.sensoryCue == this.sensoryCue &&
          other.chefTip == this.chefTip &&
          other.timerSeconds == this.timerSeconds &&
          other.mistakeWarning == this.mistakeWarning);
}

class RecipeStepsCompanion extends UpdateCompanion<RecipeStepRow> {
  final Value<int> id;
  final Value<String> recipeId;
  final Value<int> stepNumber;
  final Value<String> title;
  final Value<String> instruction;
  final Value<String> sensoryCue;
  final Value<String> chefTip;
  final Value<int?> timerSeconds;
  final Value<String?> mistakeWarning;
  const RecipeStepsCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.stepNumber = const Value.absent(),
    this.title = const Value.absent(),
    this.instruction = const Value.absent(),
    this.sensoryCue = const Value.absent(),
    this.chefTip = const Value.absent(),
    this.timerSeconds = const Value.absent(),
    this.mistakeWarning = const Value.absent(),
  });
  RecipeStepsCompanion.insert({
    this.id = const Value.absent(),
    required String recipeId,
    required int stepNumber,
    required String title,
    required String instruction,
    required String sensoryCue,
    required String chefTip,
    this.timerSeconds = const Value.absent(),
    this.mistakeWarning = const Value.absent(),
  }) : recipeId = Value(recipeId),
       stepNumber = Value(stepNumber),
       title = Value(title),
       instruction = Value(instruction),
       sensoryCue = Value(sensoryCue),
       chefTip = Value(chefTip);
  static Insertable<RecipeStepRow> custom({
    Expression<int>? id,
    Expression<String>? recipeId,
    Expression<int>? stepNumber,
    Expression<String>? title,
    Expression<String>? instruction,
    Expression<String>? sensoryCue,
    Expression<String>? chefTip,
    Expression<int>? timerSeconds,
    Expression<String>? mistakeWarning,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (stepNumber != null) 'step_number': stepNumber,
      if (title != null) 'title': title,
      if (instruction != null) 'instruction': instruction,
      if (sensoryCue != null) 'sensory_cue': sensoryCue,
      if (chefTip != null) 'chef_tip': chefTip,
      if (timerSeconds != null) 'timer_seconds': timerSeconds,
      if (mistakeWarning != null) 'mistake_warning': mistakeWarning,
    });
  }

  RecipeStepsCompanion copyWith({
    Value<int>? id,
    Value<String>? recipeId,
    Value<int>? stepNumber,
    Value<String>? title,
    Value<String>? instruction,
    Value<String>? sensoryCue,
    Value<String>? chefTip,
    Value<int?>? timerSeconds,
    Value<String?>? mistakeWarning,
  }) {
    return RecipeStepsCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      stepNumber: stepNumber ?? this.stepNumber,
      title: title ?? this.title,
      instruction: instruction ?? this.instruction,
      sensoryCue: sensoryCue ?? this.sensoryCue,
      chefTip: chefTip ?? this.chefTip,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      mistakeWarning: mistakeWarning ?? this.mistakeWarning,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (stepNumber.present) {
      map['step_number'] = Variable<int>(stepNumber.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (instruction.present) {
      map['instruction'] = Variable<String>(instruction.value);
    }
    if (sensoryCue.present) {
      map['sensory_cue'] = Variable<String>(sensoryCue.value);
    }
    if (chefTip.present) {
      map['chef_tip'] = Variable<String>(chefTip.value);
    }
    if (timerSeconds.present) {
      map['timer_seconds'] = Variable<int>(timerSeconds.value);
    }
    if (mistakeWarning.present) {
      map['mistake_warning'] = Variable<String>(mistakeWarning.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeStepsCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNumber: $stepNumber, ')
          ..write('title: $title, ')
          ..write('instruction: $instruction, ')
          ..write('sensoryCue: $sensoryCue, ')
          ..write('chefTip: $chefTip, ')
          ..write('timerSeconds: $timerSeconds, ')
          ..write('mistakeWarning: $mistakeWarning')
          ..write(')'))
        .toString();
  }
}

class $ShoppingListItemsTable extends ShoppingListItems
    with TableInfo<$ShoppingListItemsTable, ShoppingListItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingListItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aggregatedAmountMeta = const VerificationMeta(
    'aggregatedAmount',
  );
  @override
  late final GeneratedColumn<double> aggregatedAmount = GeneratedColumn<double>(
    'aggregated_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aisleCategoryMeta = const VerificationMeta(
    'aisleCategory',
  );
  @override
  late final GeneratedColumn<String> aisleCategory = GeneratedColumn<String>(
    'aisle_category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buyingTipMeta = const VerificationMeta(
    'buyingTip',
  );
  @override
  late final GeneratedColumn<String> buyingTip = GeneratedColumn<String>(
    'buying_tip',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _substituteOptionMeta = const VerificationMeta(
    'substituteOption',
  );
  @override
  late final GeneratedColumn<String> substituteOption = GeneratedColumn<String>(
    'substitute_option',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  sourceRecipeTitles =
      GeneratedColumn<String>(
        'source_recipe_titles',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>(
        $ShoppingListItemsTable.$convertersourceRecipeTitles,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    aggregatedAmount,
    unit,
    aisleCategory,
    buyingTip,
    substituteOption,
    isChecked,
    sourceRecipeTitles,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_list_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingListItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('aggregated_amount')) {
      context.handle(
        _aggregatedAmountMeta,
        aggregatedAmount.isAcceptableOrUnknown(
          data['aggregated_amount']!,
          _aggregatedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aggregatedAmountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('aisle_category')) {
      context.handle(
        _aisleCategoryMeta,
        aisleCategory.isAcceptableOrUnknown(
          data['aisle_category']!,
          _aisleCategoryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_aisleCategoryMeta);
    }
    if (data.containsKey('buying_tip')) {
      context.handle(
        _buyingTipMeta,
        buyingTip.isAcceptableOrUnknown(data['buying_tip']!, _buyingTipMeta),
      );
    }
    if (data.containsKey('substitute_option')) {
      context.handle(
        _substituteOptionMeta,
        substituteOption.isAcceptableOrUnknown(
          data['substitute_option']!,
          _substituteOptionMeta,
        ),
      );
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShoppingListItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingListItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      aggregatedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}aggregated_amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      aisleCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}aisle_category'],
      )!,
      buyingTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}buying_tip'],
      ),
      substituteOption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}substitute_option'],
      ),
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
      sourceRecipeTitles: $ShoppingListItemsTable.$convertersourceRecipeTitles
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}source_recipe_titles'],
            )!,
          ),
    );
  }

  @override
  $ShoppingListItemsTable createAlias(String alias) {
    return $ShoppingListItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertersourceRecipeTitles =
      const StringListConverter();
}

class ShoppingListItemRow extends DataClass
    implements Insertable<ShoppingListItemRow> {
  final String id;
  final String name;
  final double aggregatedAmount;
  final String unit;
  final String aisleCategory;
  final String? buyingTip;
  final String? substituteOption;
  final bool isChecked;
  final List<String> sourceRecipeTitles;
  const ShoppingListItemRow({
    required this.id,
    required this.name,
    required this.aggregatedAmount,
    required this.unit,
    required this.aisleCategory,
    this.buyingTip,
    this.substituteOption,
    required this.isChecked,
    required this.sourceRecipeTitles,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['aggregated_amount'] = Variable<double>(aggregatedAmount);
    map['unit'] = Variable<String>(unit);
    map['aisle_category'] = Variable<String>(aisleCategory);
    if (!nullToAbsent || buyingTip != null) {
      map['buying_tip'] = Variable<String>(buyingTip);
    }
    if (!nullToAbsent || substituteOption != null) {
      map['substitute_option'] = Variable<String>(substituteOption);
    }
    map['is_checked'] = Variable<bool>(isChecked);
    {
      map['source_recipe_titles'] = Variable<String>(
        $ShoppingListItemsTable.$convertersourceRecipeTitles.toSql(
          sourceRecipeTitles,
        ),
      );
    }
    return map;
  }

  ShoppingListItemsCompanion toCompanion(bool nullToAbsent) {
    return ShoppingListItemsCompanion(
      id: Value(id),
      name: Value(name),
      aggregatedAmount: Value(aggregatedAmount),
      unit: Value(unit),
      aisleCategory: Value(aisleCategory),
      buyingTip: buyingTip == null && nullToAbsent
          ? const Value.absent()
          : Value(buyingTip),
      substituteOption: substituteOption == null && nullToAbsent
          ? const Value.absent()
          : Value(substituteOption),
      isChecked: Value(isChecked),
      sourceRecipeTitles: Value(sourceRecipeTitles),
    );
  }

  factory ShoppingListItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingListItemRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      aggregatedAmount: serializer.fromJson<double>(json['aggregatedAmount']),
      unit: serializer.fromJson<String>(json['unit']),
      aisleCategory: serializer.fromJson<String>(json['aisleCategory']),
      buyingTip: serializer.fromJson<String?>(json['buyingTip']),
      substituteOption: serializer.fromJson<String?>(json['substituteOption']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      sourceRecipeTitles: serializer.fromJson<List<String>>(
        json['sourceRecipeTitles'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'aggregatedAmount': serializer.toJson<double>(aggregatedAmount),
      'unit': serializer.toJson<String>(unit),
      'aisleCategory': serializer.toJson<String>(aisleCategory),
      'buyingTip': serializer.toJson<String?>(buyingTip),
      'substituteOption': serializer.toJson<String?>(substituteOption),
      'isChecked': serializer.toJson<bool>(isChecked),
      'sourceRecipeTitles': serializer.toJson<List<String>>(sourceRecipeTitles),
    };
  }

  ShoppingListItemRow copyWith({
    String? id,
    String? name,
    double? aggregatedAmount,
    String? unit,
    String? aisleCategory,
    Value<String?> buyingTip = const Value.absent(),
    Value<String?> substituteOption = const Value.absent(),
    bool? isChecked,
    List<String>? sourceRecipeTitles,
  }) => ShoppingListItemRow(
    id: id ?? this.id,
    name: name ?? this.name,
    aggregatedAmount: aggregatedAmount ?? this.aggregatedAmount,
    unit: unit ?? this.unit,
    aisleCategory: aisleCategory ?? this.aisleCategory,
    buyingTip: buyingTip.present ? buyingTip.value : this.buyingTip,
    substituteOption: substituteOption.present
        ? substituteOption.value
        : this.substituteOption,
    isChecked: isChecked ?? this.isChecked,
    sourceRecipeTitles: sourceRecipeTitles ?? this.sourceRecipeTitles,
  );
  ShoppingListItemRow copyWithCompanion(ShoppingListItemsCompanion data) {
    return ShoppingListItemRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      aggregatedAmount: data.aggregatedAmount.present
          ? data.aggregatedAmount.value
          : this.aggregatedAmount,
      unit: data.unit.present ? data.unit.value : this.unit,
      aisleCategory: data.aisleCategory.present
          ? data.aisleCategory.value
          : this.aisleCategory,
      buyingTip: data.buyingTip.present ? data.buyingTip.value : this.buyingTip,
      substituteOption: data.substituteOption.present
          ? data.substituteOption.value
          : this.substituteOption,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      sourceRecipeTitles: data.sourceRecipeTitles.present
          ? data.sourceRecipeTitles.value
          : this.sourceRecipeTitles,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aggregatedAmount: $aggregatedAmount, ')
          ..write('unit: $unit, ')
          ..write('aisleCategory: $aisleCategory, ')
          ..write('buyingTip: $buyingTip, ')
          ..write('substituteOption: $substituteOption, ')
          ..write('isChecked: $isChecked, ')
          ..write('sourceRecipeTitles: $sourceRecipeTitles')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    aggregatedAmount,
    unit,
    aisleCategory,
    buyingTip,
    substituteOption,
    isChecked,
    sourceRecipeTitles,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingListItemRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.aggregatedAmount == this.aggregatedAmount &&
          other.unit == this.unit &&
          other.aisleCategory == this.aisleCategory &&
          other.buyingTip == this.buyingTip &&
          other.substituteOption == this.substituteOption &&
          other.isChecked == this.isChecked &&
          other.sourceRecipeTitles == this.sourceRecipeTitles);
}

class ShoppingListItemsCompanion extends UpdateCompanion<ShoppingListItemRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<double> aggregatedAmount;
  final Value<String> unit;
  final Value<String> aisleCategory;
  final Value<String?> buyingTip;
  final Value<String?> substituteOption;
  final Value<bool> isChecked;
  final Value<List<String>> sourceRecipeTitles;
  final Value<int> rowid;
  const ShoppingListItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.aggregatedAmount = const Value.absent(),
    this.unit = const Value.absent(),
    this.aisleCategory = const Value.absent(),
    this.buyingTip = const Value.absent(),
    this.substituteOption = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.sourceRecipeTitles = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShoppingListItemsCompanion.insert({
    required String id,
    required String name,
    required double aggregatedAmount,
    required String unit,
    required String aisleCategory,
    this.buyingTip = const Value.absent(),
    this.substituteOption = const Value.absent(),
    this.isChecked = const Value.absent(),
    required List<String> sourceRecipeTitles,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       aggregatedAmount = Value(aggregatedAmount),
       unit = Value(unit),
       aisleCategory = Value(aisleCategory),
       sourceRecipeTitles = Value(sourceRecipeTitles);
  static Insertable<ShoppingListItemRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<double>? aggregatedAmount,
    Expression<String>? unit,
    Expression<String>? aisleCategory,
    Expression<String>? buyingTip,
    Expression<String>? substituteOption,
    Expression<bool>? isChecked,
    Expression<String>? sourceRecipeTitles,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (aggregatedAmount != null) 'aggregated_amount': aggregatedAmount,
      if (unit != null) 'unit': unit,
      if (aisleCategory != null) 'aisle_category': aisleCategory,
      if (buyingTip != null) 'buying_tip': buyingTip,
      if (substituteOption != null) 'substitute_option': substituteOption,
      if (isChecked != null) 'is_checked': isChecked,
      if (sourceRecipeTitles != null)
        'source_recipe_titles': sourceRecipeTitles,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShoppingListItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<double>? aggregatedAmount,
    Value<String>? unit,
    Value<String>? aisleCategory,
    Value<String?>? buyingTip,
    Value<String?>? substituteOption,
    Value<bool>? isChecked,
    Value<List<String>>? sourceRecipeTitles,
    Value<int>? rowid,
  }) {
    return ShoppingListItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      aggregatedAmount: aggregatedAmount ?? this.aggregatedAmount,
      unit: unit ?? this.unit,
      aisleCategory: aisleCategory ?? this.aisleCategory,
      buyingTip: buyingTip ?? this.buyingTip,
      substituteOption: substituteOption ?? this.substituteOption,
      isChecked: isChecked ?? this.isChecked,
      sourceRecipeTitles: sourceRecipeTitles ?? this.sourceRecipeTitles,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (aggregatedAmount.present) {
      map['aggregated_amount'] = Variable<double>(aggregatedAmount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (aisleCategory.present) {
      map['aisle_category'] = Variable<String>(aisleCategory.value);
    }
    if (buyingTip.present) {
      map['buying_tip'] = Variable<String>(buyingTip.value);
    }
    if (substituteOption.present) {
      map['substitute_option'] = Variable<String>(substituteOption.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (sourceRecipeTitles.present) {
      map['source_recipe_titles'] = Variable<String>(
        $ShoppingListItemsTable.$convertersourceRecipeTitles.toSql(
          sourceRecipeTitles.value,
        ),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingListItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('aggregatedAmount: $aggregatedAmount, ')
          ..write('unit: $unit, ')
          ..write('aisleCategory: $aisleCategory, ')
          ..write('buyingTip: $buyingTip, ')
          ..write('substituteOption: $substituteOption, ')
          ..write('isChecked: $isChecked, ')
          ..write('sourceRecipeTitles: $sourceRecipeTitles, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShoppingPlanRecipesTable extends ShoppingPlanRecipes
    with TableInfo<$ShoppingPlanRecipesTable, ShoppingPlanRecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShoppingPlanRecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [recipeId, servings];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shopping_plan_recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShoppingPlanRecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    } else if (isInserting) {
      context.missing(_servingsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId};
  @override
  ShoppingPlanRecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShoppingPlanRecipeRow(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      )!,
    );
  }

  @override
  $ShoppingPlanRecipesTable createAlias(String alias) {
    return $ShoppingPlanRecipesTable(attachedDatabase, alias);
  }
}

class ShoppingPlanRecipeRow extends DataClass
    implements Insertable<ShoppingPlanRecipeRow> {
  final String recipeId;
  final int servings;
  const ShoppingPlanRecipeRow({required this.recipeId, required this.servings});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<String>(recipeId);
    map['servings'] = Variable<int>(servings);
    return map;
  }

  ShoppingPlanRecipesCompanion toCompanion(bool nullToAbsent) {
    return ShoppingPlanRecipesCompanion(
      recipeId: Value(recipeId),
      servings: Value(servings),
    );
  }

  factory ShoppingPlanRecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShoppingPlanRecipeRow(
      recipeId: serializer.fromJson<String>(json['recipeId']),
      servings: serializer.fromJson<int>(json['servings']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<String>(recipeId),
      'servings': serializer.toJson<int>(servings),
    };
  }

  ShoppingPlanRecipeRow copyWith({String? recipeId, int? servings}) =>
      ShoppingPlanRecipeRow(
        recipeId: recipeId ?? this.recipeId,
        servings: servings ?? this.servings,
      );
  ShoppingPlanRecipeRow copyWithCompanion(ShoppingPlanRecipesCompanion data) {
    return ShoppingPlanRecipeRow(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      servings: data.servings.present ? data.servings.value : this.servings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingPlanRecipeRow(')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeId, servings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShoppingPlanRecipeRow &&
          other.recipeId == this.recipeId &&
          other.servings == this.servings);
}

class ShoppingPlanRecipesCompanion
    extends UpdateCompanion<ShoppingPlanRecipeRow> {
  final Value<String> recipeId;
  final Value<int> servings;
  final Value<int> rowid;
  const ShoppingPlanRecipesCompanion({
    this.recipeId = const Value.absent(),
    this.servings = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShoppingPlanRecipesCompanion.insert({
    required String recipeId,
    required int servings,
    this.rowid = const Value.absent(),
  }) : recipeId = Value(recipeId),
       servings = Value(servings);
  static Insertable<ShoppingPlanRecipeRow> custom({
    Expression<String>? recipeId,
    Expression<int>? servings,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (servings != null) 'servings': servings,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShoppingPlanRecipesCompanion copyWith({
    Value<String>? recipeId,
    Value<int>? servings,
    Value<int>? rowid,
  }) {
    return ShoppingPlanRecipesCompanion(
      recipeId: recipeId ?? this.recipeId,
      servings: servings ?? this.servings,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShoppingPlanRecipesCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('servings: $servings, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetaTable extends AppMeta with TableInfo<$AppMetaTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppMetaTable createAlias(String alias) {
    return $AppMetaTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String key;
  final String value;
  const AppMetaRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppMetaCompanion toCompanion(bool nullToAbsent) {
    return AppMetaCompanion(key: Value(key), value: Value(value));
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppMetaRow copyWith({String? key, String? value}) =>
      AppMetaRow(key: key ?? this.key, value: value ?? this.value);
  AppMetaRow copyWithCompanion(AppMetaCompanion data) {
    return AppMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.key == this.key &&
          other.value == this.value);
}

class AppMetaCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetaCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  late final $RecipeStepsTable recipeSteps = $RecipeStepsTable(this);
  late final $ShoppingListItemsTable shoppingListItems =
      $ShoppingListItemsTable(this);
  late final $ShoppingPlanRecipesTable shoppingPlanRecipes =
      $ShoppingPlanRecipesTable(this);
  late final $AppMetaTable appMeta = $AppMetaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recipes,
    recipeIngredients,
    recipeSteps,
    shoppingListItems,
    shoppingPlanRecipes,
    appMeta,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('shopping_plan_recipes', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      required String id,
      required String title,
      required String subtitle,
      required String category,
      required int prepTimeMinutes,
      required int cookTimeMinutes,
      required int baseServings,
      required String difficulty,
      required int kcal,
      required int proteinG,
      required int carbsG,
      required int fatG,
      required List<String> tags,
      required List<String> chefGoldenRules,
      required String storageAndReheatingTip,
      Value<bool> isBuiltIn,
      Value<bool> isFavorite,
      Value<String?> sourceRecipeId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> subtitle,
      Value<String> category,
      Value<int> prepTimeMinutes,
      Value<int> cookTimeMinutes,
      Value<int> baseServings,
      Value<String> difficulty,
      Value<int> kcal,
      Value<int> proteinG,
      Value<int> carbsG,
      Value<int> fatG,
      Value<List<String>> tags,
      Value<List<String>> chefGoldenRules,
      Value<String> storageAndReheatingTip,
      Value<bool> isBuiltIn,
      Value<bool> isFavorite,
      Value<String?> sourceRecipeId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, RecipeRow> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredientRow>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: $_aliasNameGenerator(
          db.recipes.id,
          db.recipeIngredients.recipeId,
        ),
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RecipeStepsTable, List<RecipeStepRow>>
  _recipeStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeSteps,
    aliasName: $_aliasNameGenerator(db.recipes.id, db.recipeSteps.recipeId),
  );

  $$RecipeStepsTableProcessedTableManager get recipeStepsRefs {
    final manager = $$RecipeStepsTableTableManager(
      $_db,
      $_db.recipeSteps,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ShoppingPlanRecipesTable,
    List<ShoppingPlanRecipeRow>
  >
  _shoppingPlanRecipesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.shoppingPlanRecipes,
        aliasName: $_aliasNameGenerator(
          db.recipes.id,
          db.shoppingPlanRecipes.recipeId,
        ),
      );

  $$ShoppingPlanRecipesTableProcessedTableManager get shoppingPlanRecipesRefs {
    final manager = $$ShoppingPlanRecipesTableTableManager(
      $_db,
      $_db.shoppingPlanRecipes,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _shoppingPlanRecipesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get baseServings => $composableBuilder(
    column: $table.baseServings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String> get tags =>
      $composableBuilder(
        column: $table.tags,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get chefGoldenRules => $composableBuilder(
    column: $table.chefGoldenRules,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get storageAndReheatingTip => $composableBuilder(
    column: $table.storageAndReheatingTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceRecipeId => $composableBuilder(
    column: $table.sourceRecipeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recipeStepsRefs(
    Expression<bool> Function($$RecipeStepsTableFilterComposer f) f,
  ) {
    final $$RecipeStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableFilterComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shoppingPlanRecipesRefs(
    Expression<bool> Function($$ShoppingPlanRecipesTableFilterComposer f) f,
  ) {
    final $$ShoppingPlanRecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shoppingPlanRecipes,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShoppingPlanRecipesTableFilterComposer(
            $db: $db,
            $table: $db.shoppingPlanRecipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get baseServings => $composableBuilder(
    column: $table.baseServings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kcal => $composableBuilder(
    column: $table.kcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chefGoldenRules => $composableBuilder(
    column: $table.chefGoldenRules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageAndReheatingTip => $composableBuilder(
    column: $table.storageAndReheatingTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuiltIn => $composableBuilder(
    column: $table.isBuiltIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRecipeId => $composableBuilder(
    column: $table.sourceRecipeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get baseServings => $composableBuilder(
    column: $table.baseServings,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kcal =>
      $composableBuilder(column: $table.kcal, builder: (column) => column);

  GeneratedColumn<int> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<int> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<int> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get chefGoldenRules =>
      $composableBuilder(
        column: $table.chefGoldenRules,
        builder: (column) => column,
      );

  GeneratedColumn<String> get storageAndReheatingTip => $composableBuilder(
    column: $table.storageAndReheatingTip,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBuiltIn =>
      $composableBuilder(column: $table.isBuiltIn, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceRecipeId => $composableBuilder(
    column: $table.sourceRecipeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recipeStepsRefs<T extends Object>(
    Expression<T> Function($$RecipeStepsTableAnnotationComposer a) f,
  ) {
    final $$RecipeStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeSteps,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shoppingPlanRecipesRefs<T extends Object>(
    Expression<T> Function($$ShoppingPlanRecipesTableAnnotationComposer a) f,
  ) {
    final $$ShoppingPlanRecipesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.shoppingPlanRecipes,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ShoppingPlanRecipesTableAnnotationComposer(
                $db: $db,
                $table: $db.shoppingPlanRecipes,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          RecipeRow,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (RecipeRow, $$RecipesTableReferences),
          RecipeRow,
          PrefetchHooks Function({
            bool recipeIngredientsRefs,
            bool recipeStepsRefs,
            bool shoppingPlanRecipesRefs,
          })
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> subtitle = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> prepTimeMinutes = const Value.absent(),
                Value<int> cookTimeMinutes = const Value.absent(),
                Value<int> baseServings = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<int> kcal = const Value.absent(),
                Value<int> proteinG = const Value.absent(),
                Value<int> carbsG = const Value.absent(),
                Value<int> fatG = const Value.absent(),
                Value<List<String>> tags = const Value.absent(),
                Value<List<String>> chefGoldenRules = const Value.absent(),
                Value<String> storageAndReheatingTip = const Value.absent(),
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> sourceRecipeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                title: title,
                subtitle: subtitle,
                category: category,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                baseServings: baseServings,
                difficulty: difficulty,
                kcal: kcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                tags: tags,
                chefGoldenRules: chefGoldenRules,
                storageAndReheatingTip: storageAndReheatingTip,
                isBuiltIn: isBuiltIn,
                isFavorite: isFavorite,
                sourceRecipeId: sourceRecipeId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String subtitle,
                required String category,
                required int prepTimeMinutes,
                required int cookTimeMinutes,
                required int baseServings,
                required String difficulty,
                required int kcal,
                required int proteinG,
                required int carbsG,
                required int fatG,
                required List<String> tags,
                required List<String> chefGoldenRules,
                required String storageAndReheatingTip,
                Value<bool> isBuiltIn = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<String?> sourceRecipeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                title: title,
                subtitle: subtitle,
                category: category,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                baseServings: baseServings,
                difficulty: difficulty,
                kcal: kcal,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                tags: tags,
                chefGoldenRules: chefGoldenRules,
                storageAndReheatingTip: storageAndReheatingTip,
                isBuiltIn: isBuiltIn,
                isFavorite: isFavorite,
                sourceRecipeId: sourceRecipeId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recipeIngredientsRefs = false,
                recipeStepsRefs = false,
                shoppingPlanRecipesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                    if (recipeStepsRefs) db.recipeSteps,
                    if (shoppingPlanRecipesRefs) db.shoppingPlanRecipes,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipesTable,
                          RecipeIngredientRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recipeStepsRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipesTable,
                          RecipeStepRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (shoppingPlanRecipesRefs)
                        await $_getPrefetchedData<
                          RecipeRow,
                          $RecipesTable,
                          ShoppingPlanRecipeRow
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._shoppingPlanRecipesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).shoppingPlanRecipesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      RecipeRow,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (RecipeRow, $$RecipesTableReferences),
      RecipeRow,
      PrefetchHooks Function({
        bool recipeIngredientsRefs,
        bool recipeStepsRefs,
        bool shoppingPlanRecipesRefs,
      })
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      required String recipeId,
      required int position,
      required String name,
      required double amount,
      required String unit,
      required String aisleCategory,
      Value<String?> preparationNote,
      Value<String?> buyingTip,
      Value<String?> substituteOption,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> id,
      Value<String> recipeId,
      Value<int> position,
      Value<String> name,
      Value<double> amount,
      Value<String> unit,
      Value<String> aisleCategory,
      Value<String?> preparationNote,
      Value<String?> buyingTip,
      Value<String?> substituteOption,
    });

final class $$RecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredientRow
        > {
  $$RecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias(
        $_aliasNameGenerator(db.recipeIngredients.recipeId, db.recipes.id),
      );

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preparationNote => $composableBuilder(
    column: $table.preparationNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyingTip => $composableBuilder(
    column: $table.buyingTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preparationNote => $composableBuilder(
    column: $table.preparationNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyingTip => $composableBuilder(
    column: $table.buyingTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preparationNote => $composableBuilder(
    column: $table.preparationNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyingTip =>
      $composableBuilder(column: $table.buyingTip, builder: (column) => column);

  GeneratedColumn<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => column,
  );

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredientRow,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (RecipeIngredientRow, $$RecipeIngredientsTableReferences),
          RecipeIngredientRow,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> aisleCategory = const Value.absent(),
                Value<String?> preparationNote = const Value.absent(),
                Value<String?> buyingTip = const Value.absent(),
                Value<String?> substituteOption = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                id: id,
                recipeId: recipeId,
                position: position,
                name: name,
                amount: amount,
                unit: unit,
                aisleCategory: aisleCategory,
                preparationNote: preparationNote,
                buyingTip: buyingTip,
                substituteOption: substituteOption,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipeId,
                required int position,
                required String name,
                required double amount,
                required String unit,
                required String aisleCategory,
                Value<String?> preparationNote = const Value.absent(),
                Value<String?> buyingTip = const Value.absent(),
                Value<String?> substituteOption = const Value.absent(),
              }) => RecipeIngredientsCompanion.insert(
                id: id,
                recipeId: recipeId,
                position: position,
                name: name,
                amount: amount,
                unit: unit,
                aisleCategory: aisleCategory,
                preparationNote: preparationNote,
                buyingTip: buyingTip,
                substituteOption: substituteOption,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$RecipeIngredientsTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$RecipeIngredientsTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredientRow,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (RecipeIngredientRow, $$RecipeIngredientsTableReferences),
      RecipeIngredientRow,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$RecipeStepsTableCreateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      required String recipeId,
      required int stepNumber,
      required String title,
      required String instruction,
      required String sensoryCue,
      required String chefTip,
      Value<int?> timerSeconds,
      Value<String?> mistakeWarning,
    });
typedef $$RecipeStepsTableUpdateCompanionBuilder =
    RecipeStepsCompanion Function({
      Value<int> id,
      Value<String> recipeId,
      Value<int> stepNumber,
      Value<String> title,
      Value<String> instruction,
      Value<String> sensoryCue,
      Value<String> chefTip,
      Value<int?> timerSeconds,
      Value<String?> mistakeWarning,
    });

final class $$RecipeStepsTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeStepsTable, RecipeStepRow> {
  $$RecipeStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias(
        $_aliasNameGenerator(db.recipeSteps.recipeId, db.recipes.id),
      );

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeStepsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instruction => $composableBuilder(
    column: $table.instruction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryCue => $composableBuilder(
    column: $table.sensoryCue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chefTip => $composableBuilder(
    column: $table.chefTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timerSeconds => $composableBuilder(
    column: $table.timerSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mistakeWarning => $composableBuilder(
    column: $table.mistakeWarning,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instruction => $composableBuilder(
    column: $table.instruction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryCue => $composableBuilder(
    column: $table.sensoryCue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chefTip => $composableBuilder(
    column: $table.chefTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timerSeconds => $composableBuilder(
    column: $table.timerSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mistakeWarning => $composableBuilder(
    column: $table.mistakeWarning,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeStepsTable> {
  $$RecipeStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepNumber => $composableBuilder(
    column: $table.stepNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get instruction => $composableBuilder(
    column: $table.instruction,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sensoryCue => $composableBuilder(
    column: $table.sensoryCue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chefTip =>
      $composableBuilder(column: $table.chefTip, builder: (column) => column);

  GeneratedColumn<int> get timerSeconds => $composableBuilder(
    column: $table.timerSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mistakeWarning => $composableBuilder(
    column: $table.mistakeWarning,
    builder: (column) => column,
  );

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeStepsTable,
          RecipeStepRow,
          $$RecipeStepsTableFilterComposer,
          $$RecipeStepsTableOrderingComposer,
          $$RecipeStepsTableAnnotationComposer,
          $$RecipeStepsTableCreateCompanionBuilder,
          $$RecipeStepsTableUpdateCompanionBuilder,
          (RecipeStepRow, $$RecipeStepsTableReferences),
          RecipeStepRow,
          PrefetchHooks Function({bool recipeId})
        > {
  $$RecipeStepsTableTableManager(_$AppDatabase db, $RecipeStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> stepNumber = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> instruction = const Value.absent(),
                Value<String> sensoryCue = const Value.absent(),
                Value<String> chefTip = const Value.absent(),
                Value<int?> timerSeconds = const Value.absent(),
                Value<String?> mistakeWarning = const Value.absent(),
              }) => RecipeStepsCompanion(
                id: id,
                recipeId: recipeId,
                stepNumber: stepNumber,
                title: title,
                instruction: instruction,
                sensoryCue: sensoryCue,
                chefTip: chefTip,
                timerSeconds: timerSeconds,
                mistakeWarning: mistakeWarning,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recipeId,
                required int stepNumber,
                required String title,
                required String instruction,
                required String sensoryCue,
                required String chefTip,
                Value<int?> timerSeconds = const Value.absent(),
                Value<String?> mistakeWarning = const Value.absent(),
              }) => RecipeStepsCompanion.insert(
                id: id,
                recipeId: recipeId,
                stepNumber: stepNumber,
                title: title,
                instruction: instruction,
                sensoryCue: sensoryCue,
                chefTip: chefTip,
                timerSeconds: timerSeconds,
                mistakeWarning: mistakeWarning,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipeStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable: $$RecipeStepsTableReferences
                                    ._recipeIdTable(db),
                                referencedColumn: $$RecipeStepsTableReferences
                                    ._recipeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeStepsTable,
      RecipeStepRow,
      $$RecipeStepsTableFilterComposer,
      $$RecipeStepsTableOrderingComposer,
      $$RecipeStepsTableAnnotationComposer,
      $$RecipeStepsTableCreateCompanionBuilder,
      $$RecipeStepsTableUpdateCompanionBuilder,
      (RecipeStepRow, $$RecipeStepsTableReferences),
      RecipeStepRow,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$ShoppingListItemsTableCreateCompanionBuilder =
    ShoppingListItemsCompanion Function({
      required String id,
      required String name,
      required double aggregatedAmount,
      required String unit,
      required String aisleCategory,
      Value<String?> buyingTip,
      Value<String?> substituteOption,
      Value<bool> isChecked,
      required List<String> sourceRecipeTitles,
      Value<int> rowid,
    });
typedef $$ShoppingListItemsTableUpdateCompanionBuilder =
    ShoppingListItemsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<double> aggregatedAmount,
      Value<String> unit,
      Value<String> aisleCategory,
      Value<String?> buyingTip,
      Value<String?> substituteOption,
      Value<bool> isChecked,
      Value<List<String>> sourceRecipeTitles,
      Value<int> rowid,
    });

class $$ShoppingListItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get aggregatedAmount => $composableBuilder(
    column: $table.aggregatedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buyingTip => $composableBuilder(
    column: $table.buyingTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get sourceRecipeTitles => $composableBuilder(
    column: $table.sourceRecipeTitles,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ShoppingListItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get aggregatedAmount => $composableBuilder(
    column: $table.aggregatedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buyingTip => $composableBuilder(
    column: $table.buyingTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceRecipeTitles => $composableBuilder(
    column: $table.sourceRecipeTitles,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShoppingListItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingListItemsTable> {
  $$ShoppingListItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get aggregatedAmount => $composableBuilder(
    column: $table.aggregatedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get aisleCategory => $composableBuilder(
    column: $table.aisleCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get buyingTip =>
      $composableBuilder(column: $table.buyingTip, builder: (column) => column);

  GeneratedColumn<String> get substituteOption => $composableBuilder(
    column: $table.substituteOption,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String>
  get sourceRecipeTitles => $composableBuilder(
    column: $table.sourceRecipeTitles,
    builder: (column) => column,
  );
}

class $$ShoppingListItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingListItemsTable,
          ShoppingListItemRow,
          $$ShoppingListItemsTableFilterComposer,
          $$ShoppingListItemsTableOrderingComposer,
          $$ShoppingListItemsTableAnnotationComposer,
          $$ShoppingListItemsTableCreateCompanionBuilder,
          $$ShoppingListItemsTableUpdateCompanionBuilder,
          (
            ShoppingListItemRow,
            BaseReferences<
              _$AppDatabase,
              $ShoppingListItemsTable,
              ShoppingListItemRow
            >,
          ),
          ShoppingListItemRow,
          PrefetchHooks Function()
        > {
  $$ShoppingListItemsTableTableManager(
    _$AppDatabase db,
    $ShoppingListItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingListItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingListItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShoppingListItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> aggregatedAmount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> aisleCategory = const Value.absent(),
                Value<String?> buyingTip = const Value.absent(),
                Value<String?> substituteOption = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<List<String>> sourceRecipeTitles = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShoppingListItemsCompanion(
                id: id,
                name: name,
                aggregatedAmount: aggregatedAmount,
                unit: unit,
                aisleCategory: aisleCategory,
                buyingTip: buyingTip,
                substituteOption: substituteOption,
                isChecked: isChecked,
                sourceRecipeTitles: sourceRecipeTitles,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required double aggregatedAmount,
                required String unit,
                required String aisleCategory,
                Value<String?> buyingTip = const Value.absent(),
                Value<String?> substituteOption = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                required List<String> sourceRecipeTitles,
                Value<int> rowid = const Value.absent(),
              }) => ShoppingListItemsCompanion.insert(
                id: id,
                name: name,
                aggregatedAmount: aggregatedAmount,
                unit: unit,
                aisleCategory: aisleCategory,
                buyingTip: buyingTip,
                substituteOption: substituteOption,
                isChecked: isChecked,
                sourceRecipeTitles: sourceRecipeTitles,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShoppingListItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingListItemsTable,
      ShoppingListItemRow,
      $$ShoppingListItemsTableFilterComposer,
      $$ShoppingListItemsTableOrderingComposer,
      $$ShoppingListItemsTableAnnotationComposer,
      $$ShoppingListItemsTableCreateCompanionBuilder,
      $$ShoppingListItemsTableUpdateCompanionBuilder,
      (
        ShoppingListItemRow,
        BaseReferences<
          _$AppDatabase,
          $ShoppingListItemsTable,
          ShoppingListItemRow
        >,
      ),
      ShoppingListItemRow,
      PrefetchHooks Function()
    >;
typedef $$ShoppingPlanRecipesTableCreateCompanionBuilder =
    ShoppingPlanRecipesCompanion Function({
      required String recipeId,
      required int servings,
      Value<int> rowid,
    });
typedef $$ShoppingPlanRecipesTableUpdateCompanionBuilder =
    ShoppingPlanRecipesCompanion Function({
      Value<String> recipeId,
      Value<int> servings,
      Value<int> rowid,
    });

final class $$ShoppingPlanRecipesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ShoppingPlanRecipesTable,
          ShoppingPlanRecipeRow
        > {
  $$ShoppingPlanRecipesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias(
        $_aliasNameGenerator(db.shoppingPlanRecipes.recipeId, db.recipes.id),
      );

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShoppingPlanRecipesTableFilterComposer
    extends Composer<_$AppDatabase, $ShoppingPlanRecipesTable> {
  $$ShoppingPlanRecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingPlanRecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShoppingPlanRecipesTable> {
  $$ShoppingPlanRecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingPlanRecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShoppingPlanRecipesTable> {
  $$ShoppingPlanRecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShoppingPlanRecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShoppingPlanRecipesTable,
          ShoppingPlanRecipeRow,
          $$ShoppingPlanRecipesTableFilterComposer,
          $$ShoppingPlanRecipesTableOrderingComposer,
          $$ShoppingPlanRecipesTableAnnotationComposer,
          $$ShoppingPlanRecipesTableCreateCompanionBuilder,
          $$ShoppingPlanRecipesTableUpdateCompanionBuilder,
          (ShoppingPlanRecipeRow, $$ShoppingPlanRecipesTableReferences),
          ShoppingPlanRecipeRow,
          PrefetchHooks Function({bool recipeId})
        > {
  $$ShoppingPlanRecipesTableTableManager(
    _$AppDatabase db,
    $ShoppingPlanRecipesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShoppingPlanRecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShoppingPlanRecipesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ShoppingPlanRecipesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> recipeId = const Value.absent(),
                Value<int> servings = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShoppingPlanRecipesCompanion(
                recipeId: recipeId,
                servings: servings,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String recipeId,
                required int servings,
                Value<int> rowid = const Value.absent(),
              }) => ShoppingPlanRecipesCompanion.insert(
                recipeId: recipeId,
                servings: servings,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShoppingPlanRecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$ShoppingPlanRecipesTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$ShoppingPlanRecipesTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShoppingPlanRecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShoppingPlanRecipesTable,
      ShoppingPlanRecipeRow,
      $$ShoppingPlanRecipesTableFilterComposer,
      $$ShoppingPlanRecipesTableOrderingComposer,
      $$ShoppingPlanRecipesTableAnnotationComposer,
      $$ShoppingPlanRecipesTableCreateCompanionBuilder,
      $$ShoppingPlanRecipesTableUpdateCompanionBuilder,
      (ShoppingPlanRecipeRow, $$ShoppingPlanRecipesTableReferences),
      ShoppingPlanRecipeRow,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$AppMetaTableCreateCompanionBuilder =
    AppMetaCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppMetaTableUpdateCompanionBuilder =
    AppMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppMetaTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetaTable> {
  $$AppMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetaTable,
          AppMetaRow,
          $$AppMetaTableFilterComposer,
          $$AppMetaTableOrderingComposer,
          $$AppMetaTableAnnotationComposer,
          $$AppMetaTableCreateCompanionBuilder,
          $$AppMetaTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetaTableTableManager(_$AppDatabase db, $AppMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetaCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) =>
                  AppMetaCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetaTable,
      AppMetaRow,
      $$AppMetaTableFilterComposer,
      $$AppMetaTableOrderingComposer,
      $$AppMetaTableAnnotationComposer,
      $$AppMetaTableCreateCompanionBuilder,
      $$AppMetaTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetaTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
  $$RecipeStepsTableTableManager get recipeSteps =>
      $$RecipeStepsTableTableManager(_db, _db.recipeSteps);
  $$ShoppingListItemsTableTableManager get shoppingListItems =>
      $$ShoppingListItemsTableTableManager(_db, _db.shoppingListItems);
  $$ShoppingPlanRecipesTableTableManager get shoppingPlanRecipes =>
      $$ShoppingPlanRecipesTableTableManager(_db, _db.shoppingPlanRecipes);
  $$AppMetaTableTableManager get appMeta =>
      $$AppMetaTableTableManager(_db, _db.appMeta);
}
