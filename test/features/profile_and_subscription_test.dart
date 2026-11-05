import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mob_kitchen/core/providers/core_providers.dart';
import 'package:mob_kitchen/core/theme/recipe_visuals.dart';
import 'package:mob_kitchen/features/profile/data/profile_repository.dart';
import 'package:mob_kitchen/features/profile/domain/entities/personal_taste_profile.dart';
import 'package:mob_kitchen/features/profile/presentation/taste_profile_screen.dart';
import 'package:mob_kitchen/features/recipes/data/seed/initial_recipes_seed.dart';
import 'package:mob_kitchen/features/subscription/domain/subscription_state.dart';
import 'package:mob_kitchen/features/subscription/presentation/chef_pro_paywall_sheet.dart';
import 'package:mob_kitchen/features/subscription/providers/subscription_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SubscriptionNotifier & ChefProPaywallSheet Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('başlangıçta 3 ücretsiz AI hakkı vardır ve kullanıldıkça azalır', () async {
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);

      expect(container.read(subscriptionProvider).freeAiCreditsRemaining, equals(3));
      expect(container.read(subscriptionProvider).isChefPro, isFalse);

      // 3 hakkı tüket
      expect(await container.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded(), isTrue);
      expect(await container.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded(), isTrue);
      expect(await container.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded(), isTrue);
      expect(container.read(subscriptionProvider).freeAiCreditsRemaining, equals(0));

      // 4. deneme ücretsiz kullanıcı için false döner (Paywall tetikler)
      expect(await container.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded(), isFalse);

      // Chef Pro aktif edildiğinde sınırsız izin verir
      await container.read(subscriptionProvider.notifier).activateChefPro(SubscriptionPlan.annual);
      expect(container.read(subscriptionProvider).isChefPro, isTrue);
      expect(await container.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded(), isTrue);
    });

    testWidgets('ChefProPaywallSheet planları ve satın alımları geri yükle butonunu gösterir', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: const MaterialApp(
            home: Scaffold(
              body: ChefProPaywallSheet(triggerFeatureName: 'AI Remix'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('SIMMERLINK CHEF PRO'), findsOneWidget);
      expect(find.textContaining('Unlock Limits for AI Remix'), findsOneWidget);
      expect(find.text('Chef Pro Annual'), findsOneWidget);
      expect(find.text('Chef Pro Monthly'), findsOneWidget);
      expect(find.text('Restore Purchases'), findsOneWidget);
    });
  });

  group('TasteProfileScreen & Allergen Safety Tests', () {
    test('findAllergenOrDislikeWarnings alerjen ve istenmeyen malzemeleri tespit eder', () {
      final recipe = kInitialRecipes.first; // Garlic and Chicken
      const profile = PersonalTasteProfile(
        allergies: ['Garlic'],
        dislikedIngredients: ['Mushroom'],
      );

      final warnings = RecipeVisuals.findAllergenOrDislikeWarnings(recipe, profile);
      expect(warnings, isNotEmpty);
      expect(warnings.first, contains('Garlic'));
    });

    testWidgets('TasteProfileScreen ekipmanları, alerjileri ve fırınsız mod bilgisini gösterir', (tester) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
          child: const MaterialApp(
            home: TasteProfileScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('My Kitchen Profile & Settings'), findsOneWidget);
      expect(find.text('My Kitchen Equipment'), findsOneWidget);
      expect(find.textContaining('Ovenless Mode Active'), findsOneWidget);
      expect(find.text('Allergies & Vital Restrictions'), findsOneWidget);

      // Gluten alerjisi seç ve kaydet
      await tester.ensureVisible(find.text('Gluten'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gluten'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      final saved = ProfileRepository(prefs).load();
      expect(saved.allergies, contains('Gluten'));
    });
  });
}
