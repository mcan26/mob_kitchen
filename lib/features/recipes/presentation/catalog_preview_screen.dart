import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/recipe_providers.dart';

/// FAZ 1 doğrulama ekranı: yerel kataloğun veritabanından okunduğunu gösterir.
/// FAZ 3'te "Keşfet" sayfasıyla değiştirilecek.
class CatalogPreviewScreen extends ConsumerWidget {
  const CatalogPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(allRecipesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mob Kitchen · Katalog')),
      body: recipes.when(
        data: (list) => ListView.separated(
          itemCount: list.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, i) {
            final r = list[i];
            return ListTile(
              title: Text(r.title),
              subtitle: Text(
                '${r.category.label} · ${r.totalTimeMinutes} dk · ${r.macros.proteinG} g protein · '
                '${r.ingredients.length} malzeme · ${r.steps.length} adım',
              ),
              trailing: IconButton(
                icon: Icon(r.isFavorite ? Icons.favorite : Icons.favorite_border),
                onPressed: () => ref.read(recipeRepositoryProvider).toggleFavorite(r.id),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Hata: $e')),
      ),
    );
  }
}
