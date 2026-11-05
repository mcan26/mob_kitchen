import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/providers/core_providers.dart';
import 'features/recipes/providers/recipe_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );

  // Offline-first: yerleşik "Mob Classics" kataloğunu ilk açılışta yükle.
  // Sürüm değişmediyse anında döner.
  await container.read(recipeSeederProvider).seedIfNeeded();

  runApp(UncontrolledProviderScope(container: container, child: const MobKitchenApp()));
}
