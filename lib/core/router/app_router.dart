import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai/presentation/pantry_generator_screen.dart';
import '../../features/cooking/presentation/cook_mode_screen.dart';
import '../../features/profile/presentation/taste_profile_screen.dart';
import '../../features/recipes/presentation/discovery_feed_screen.dart';
import '../../features/recipes/presentation/recipe_create_screen.dart';
import '../../features/recipes/presentation/recipe_detail_screen.dart';
import '../../features/shopping/presentation/supermarket_screen.dart';
import '../../features/wireless/presentation/smart_kitchen_hub_screen.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const recipeDetail = '/recipe/:id';
  static const createRecipe = '/create-recipe';
  static const pantryGenerator = '/pantry';
  static const cookMode = '/cook/:id';
  static const supermarket = '/shopping';
  static const profile = '/profile';
  static const wirelessHub = '/wireless';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const DiscoveryFeedScreen(),
      ),
      GoRoute(
        path: AppRoutes.recipeDetail,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return RecipeDetailScreen(recipeId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.createRecipe,
        builder: (context, state) {
          final editId = state.uri.queryParameters['editId'];
          return RecipeCreateScreen(editRecipeId: editId);
        },
      ),
      GoRoute(
        path: AppRoutes.pantryGenerator,
        builder: (context, state) {
          final modeParam = state.uri.queryParameters['mode'];
          final mode = modeParam == 'social'
              ? AiCreationMode.socialImport
              : AiCreationMode.pantryAndPhoto;
          return PantryGeneratorScreen(initialMode: mode);
        },
      ),
      GoRoute(
        path: AppRoutes.cookMode,
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          final servingsParam = int.tryParse(state.uri.queryParameters['servings'] ?? '');
          return CookModeScreen(
            recipeId: id,
            targetServings: servingsParam,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.supermarket,
        builder: (context, state) => const SupermarketScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const TasteProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.wirelessHub,
        builder: (context, state) {
          final tabParam = state.uri.queryParameters['tab'];
          final initialTab = switch (tabParam) {
            'telemetry' => WirelessHubTab.telemetry,
            'coop' => WirelessHubTab.coop,
            _ => WirelessHubTab.radar,
          };
          return SmartKitchenHubScreen(initialTab: initialTab);
        },
      ),
    ],
  );
});
