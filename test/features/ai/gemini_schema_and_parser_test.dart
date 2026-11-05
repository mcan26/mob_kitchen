import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mob_kitchen/core/domain/aisle_category.dart';
import 'package:mob_kitchen/core/domain/measurement_unit.dart';
import 'package:mob_kitchen/features/ai/data/api_key_repository.dart';
import 'package:mob_kitchen/features/ai/data/gemini_recipe_service_impl.dart';
import 'package:mob_kitchen/features/ai/data/gemini_schemas.dart';
import 'package:mob_kitchen/features/profile/domain/entities/personal_taste_profile.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe.dart';
import 'package:mob_kitchen/features/recipes/domain/entities/recipe_enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GeminiSchemas', () {
    test('recipeSchema zorunlu alanları eksiksiz barındırır', () {
      final schema = GeminiSchemas.recipeSchema;
      expect(schema.requiredProperties, containsAll([
        'title',
        'subtitle',
        'category',
        'prep_time',
        'cook_time',
        'base_servings',
        'difficulty',
        'macros',
        'tags',
        'chef_golden_rules',
        'storage_and_reheating_tip',
        'ingredients',
        'steps',
      ]));
    });

    test('ingredientSchema ve stepSchema zorunlu alanlara sahiptir', () {
      expect(
        GeminiSchemas.ingredientSchema.requiredProperties,
        containsAll(['name', 'amount', 'unit', 'aisle_category']),
      );
      expect(
        GeminiSchemas.stepSchema.requiredProperties,
        containsAll(['step_number', 'title', 'instruction', 'sensory_cue', 'chef_tip']),
      );
    });
  });

  group('Strict Enum Schema + Safe Fallback Parser', () {
    test('Gemini olası sapma yapsa bile Recipe.fromJson güvenli fallback ile çökmeksizin parse eder', () {
      final faultyJson = {
        'title': 'Test Ai Tarifi',
        'subtitle': 'Hızlı ve pratik',
        'category': 'bilinmeyen_kategori_123', // Tanımsız kategori
        'prep_time': 12,
        'cook_time': 18,
        'base_servings': 2,
        'difficulty': 'ultra_hard_999', // Tanımsız zorluk
        'macros': {'kcal': 600, 'protein': 40, 'carbs': 50, 'fat': 20},
        'tags': ['test', 'hızlı'],
        'chef_golden_rules': ['Tavayı ısıt'],
        'storage_and_reheating_tip': 'Saklama tüyosu',
        'ingredients': [
          {
            'name': 'Garnitür',
            'amount': 2.5,
            'unit': 'bilinmeyen_birim_xyz', // Tanımsız birim
            'aisle_category': 'mars_reyonu', // Tanımsız reyon
          }
        ],
        'steps': [
          {
            'step_number': 1,
            'title': 'Kavur',
            'instruction': 'Tavada pişir.',
            'sensory_cue': 'Altın sarısı olunca al.',
            'chef_tip': 'Yüksek ateş kullan.',
          }
        ],
      };

      final recipe = Recipe.fromJson(faultyJson, id: 'test_ai_fallback');

      expect(recipe.title, 'Test Ai Tarifi');
      // Kategori fallback: quickDinner
      expect(recipe.category, RecipeCategory.quickDinner);
      // Zorluk fallback: medium
      expect(recipe.difficulty, Difficulty.medium);
      // Birim fallback: piece
      expect(recipe.ingredients.first.unit, MeasurementUnit.piece);
      // Reyon fallback: pantry
      expect(recipe.ingredients.first.aisleCategory, AisleCategory.pantry);
    });
  });

  group('GeminiRecipeServiceImpl', () {
    late SharedPreferences prefs;
    late ApiKeyRepository apiKeyRepo;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'gemini_custom_api_key': 'AIzaTestMockKey'});
      prefs = await SharedPreferences.getInstance();
      apiKeyRepo = ApiKeyRepository(prefs);
    });

    test('API anahtarı yoksa StateError fırlatır', () async {
      await apiKeyRepo.clearCustomApiKey();
      final service = GeminiRecipeServiceImpl(
        apiKeyRepository: apiKeyRepo,
        getTasteProfile: () => const PersonalTasteProfile(),
      );

      expect(
        () => service.generateRecipeFromPantry(ingredients: ['tavuk']),
        throwsA(isA<StateError>()),
      );
    });

    test('generateRecipeFromPantry: JSON yanıtını başarıyla Recipe modeline dönüştürür', () async {
      const mockRecipePayload = {
        'title': 'Tavada Çıtır Biberli Tavuk',
        'subtitle': 'Dolaptaki tavuk ve biberle 15 dakikalık ziyafet.',
        'category': 'one_pot',
        'prep_time': 5,
        'cook_time': 15,
        'base_servings': 2,
        'difficulty': 'easy',
        'macros': {'kcal': 550, 'protein': 45, 'carbs': 20, 'fat': 15},
        'tags': ['tavuk', 'tek tava'],
        'chef_golden_rules': ['Tavayı önceden ısıt', 'Tavuğu kurula'],
        'storage_and_reheating_tip': 'Tavada az yağla ısıt.',
        'ingredients': [
          {
            'name': 'Tavuk göğsü',
            'amount': 300,
            'unit': 'g',
            'aisle_category': 'butcher_deli',
            'preparation_note': 'küp doğranmış',
            'buying_tip': 'Taze pembe olanı seç',
            'substitute_option': 'Kemiksiz but'
          }
        ],
        'steps': [
          {
            'step_number': 1,
            'title': 'Tavuğu mühürle',
            'instruction': 'Tavaya at ve 4 dakika dokunma.',
            'sensory_cue': 'Kenarları altın rengi olunca çevir.',
            'chef_tip': 'Kabuk bağlamadan çevirme.',
            'timer_seconds': 240
          }
        ]
      };

      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {'text': jsonEncode(mockRecipePayload)}
                  ]
                }
              }
            ]
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = GeminiRecipeServiceImpl(
        apiKeyRepository: apiKeyRepo,
        getTasteProfile: () => const PersonalTasteProfile(),
        httpClient: mockClient,
      );

      final recipe = await service.generateRecipeFromPantry(ingredients: ['Tavuk', 'Biber']);

      expect(recipe.title, 'Tavada Çıtır Biberli Tavuk');
      expect(recipe.id, startsWith('ai_'));
      expect(recipe.isBuiltIn, isFalse);
      expect(recipe.ingredients.length, 1);
      expect(recipe.ingredients.first.name, 'Tavuk göğsü');
      expect(recipe.ingredients.first.amount, 300.0);
      expect(recipe.ingredients.first.unit, MeasurementUnit.gram);
      expect(recipe.steps.length, 1);
      expect(recipe.steps.first.timerSeconds, 240);
    });

    test('remixRecipe: kaynak tarif id bilgisini koruyarak yeni varyasyon üretir', () async {
      const mockRemixPayload = {
        'title': 'Tavada Fırınsız Carbonara',
        'subtitle': 'Fırınsız ve hafif kremsi dokuda.',
        'category': 'pasta',
        'prep_time': 5,
        'cook_time': 15,
        'base_servings': 2,
        'difficulty': 'medium',
        'macros': {'kcal': 650, 'protein': 35, 'carbs': 60, 'fat': 25},
        'tags': ['makarna'],
        'chef_golden_rules': ['Yumurtayı ocaktan uzakta çırp'],
        'storage_and_reheating_tip': 'Taze tüketilmeli.',
        'ingredients': [
          {
            'name': 'Spagetti',
            'amount': 200,
            'unit': 'g',
            'aisle_category': 'pantry'
          }
        ],
        'steps': [
          {
            'step_number': 1,
            'title': 'Haşla',
            'instruction': 'Makarnayı 8 dk haşla.',
            'sensory_cue': 'Al dente olunca süz.',
            'chef_tip': 'Suyundan 1 bardak ayır.'
          }
        ]
      };

      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {'text': jsonEncode(mockRemixPayload)}
                  ]
                }
              }
            ]
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = GeminiRecipeServiceImpl(
        apiKeyRepository: apiKeyRepo,
        getTasteProfile: () => const PersonalTasteProfile(),
        httpClient: mockClient,
      );

      final source = kInitialRecipes.first;
      final remixed = await service.remixRecipe(
        sourceRecipe: source,
        remixInstruction: 'Fırın kullanmadan tavada yap',
      );

      expect(remixed.title, 'Tavada Fırınsız Carbonara');
      expect(remixed.id, startsWith('remix_'));
      expect(remixed.sourceRecipeId, source.id);
    });

    test('askSousChef: adım bağlamında pratik tavsiye döndürür', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {
                      'text':
                          'Hemen 2 yemek kaşığı soğuk makarna suyu ekleyip hızlıca karıştırın, sos toparlayacaktır.'
                    }
                  ]
                }
              }
            ]
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = GeminiRecipeServiceImpl(
        apiKeyRepository: apiKeyRepo,
        getTasteProfile: () => const PersonalTasteProfile(),
        httpClient: mockClient,
      );

      final advice = await service.askSousChef(
        currentRecipe: kInitialRecipes.first,
        currentStepNumber: 2,
        question: 'Tavuk tavaya yapıştı, ne yapayım?',
      );

      expect(advice, contains('makarna suyu'));
    });

    test('importRecipeFromSocialOrText: sosyal medya linkini yapılandırılmış tarife dönüştürür', () async {
      const mockSocialPayload = {
        'title': 'Viral Feta Makarna',
        'subtitle': 'TikTok viral fırınlanmış beyaz peynirli ve çeri domatesli makarna.',
        'category': 'pasta',
        'prep_time': 5,
        'cook_time': 20,
        'base_servings': 2,
        'difficulty': 'easy',
        'macros': {'kcal': 580, 'protein': 24, 'carbs': 62, 'fat': 22},
        'tags': ['viral', 'makarna'],
        'chef_golden_rules': ['Domatesler patlayana kadar pişir'],
        'storage_and_reheating_tip': 'Buzdolabında 2 gün saklanır.',
        'ingredients': [
          {
            'name': 'Çeri Domates',
            'amount': 300,
            'unit': 'g',
            'aisle_category': 'produce',
          }
        ],
        'steps': [
          {
            'step_number': 1,
            'title': 'Soteleme',
            'instruction': 'Domatesleri zeytinyağında patlayana kadar pişirin.',
            'sensory_cue': 'Kabukları çatlayıp suyunu saldığında.',
            'chef_tip': 'Sarımsakları son 1 dakikada ekleyin.',
          }
        ]
      };

      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode({
            'candidates': [
              {
                'content': {
                  'parts': [
                    {'text': jsonEncode(mockSocialPayload)}
                  ]
                }
              }
            ]
          }),
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final service = GeminiRecipeServiceImpl(
        apiKeyRepository: apiKeyRepo,
        getTasteProfile: () => const PersonalTasteProfile(),
        httpClient: mockClient,
      );

      final imported = await service.importRecipeFromSocialOrText(
        urlOrText: 'https://www.instagram.com/reel/viral-feta-pasta/',
      );

      expect(imported.title, equals('Viral Feta Makarna'));
      expect(imported.id, startsWith('social_'));
      expect(imported.isBuiltIn, isFalse);
    });
  });
}
