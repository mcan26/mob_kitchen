import 'package:flutter/material.dart';

import '../../features/profile/domain/entities/personal_taste_profile.dart';
import '../../features/recipes/domain/entities/recipe.dart';
import '../../features/recipes/domain/entities/recipe_enums.dart';

/// Her tarif ve kategori için iştah açıcı editorial renk paleti, ikonografi ve görsel kimlik.
class RecipeVisualSpec {
  const RecipeVisualSpec({
    required this.gradientColors,
    required this.accentColor,
    required this.dishEmoji,
    required this.culinaryBadge,
    required this.icon,
  });

  final List<Color> gradientColors;
  final Color accentColor;
  final String dishEmoji;
  final String culinaryBadge;
  final IconData icon;
}

abstract final class RecipeVisuals {
  static RecipeVisualSpec forRecipe(Recipe recipe) {
    // Yerleşik 10 Mob Klasiği için özel küratörlü görsel profil
    switch (recipe.id) {
      case 'mob_classic_001':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4A2511), Color(0xFF281815), Color(0xFF15151C)],
          accentColor: Color(0xFFFF8A50),
          dishEmoji: '🍝',
          culinaryBadge: 'KREMALI & SARIMSAKLI',
          icon: Icons.dinner_dining,
        );
      case 'mob_classic_002':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4F3810), Color(0xFF292014), Color(0xFF15151C)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '🧀',
          culinaryBadge: 'ORİJİNAL ROMA USULÜ',
          icon: Icons.restaurant,
        );
      case 'mob_classic_003':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF521E14), Color(0xFF2B1615), Color(0xFF15151C)],
          accentColor: Color(0xFFE84A27),
          dishEmoji: '🍗',
          culinaryBadge: 'ÇİFT KAPLAMA ÇITIR',
          icon: Icons.local_fire_department,
        );
      case 'mob_classic_004':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1E3F29), Color(0xFF172620), Color(0xFF15151C)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🌯',
          culinaryBadge: 'MEAL-PREP KRALI',
          icon: Icons.rice_bowl,
        );
      case 'mob_classic_005':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF541B1B), Color(0xFF2E1719), Color(0xFF15151C)],
          accentColor: Color(0xFFFF5E4D),
          dishEmoji: '🍳',
          culinaryBadge: 'TEK TAVA ŞAKŞUKA',
          icon: Icons.egg_alt,
        );
      case 'mob_classic_006':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF3E1F14), Color(0xFF231618), Color(0xFF15151C)],
          accentColor: Color(0xFFFF9F43),
          dishEmoji: '🥢',
          culinaryBadge: '15 DK ASYA BOWL',
          icon: Icons.ramen_dining,
        );
      case 'mob_classic_007':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF472A14), Color(0xFF261B16), Color(0xFF15151C)],
          accentColor: Color(0xFFF39C12),
          dishEmoji: '🥔',
          culinaryBadge: 'KARAMELİZE TEK TAVA',
          icon: Icons.soup_kitchen,
        );
      case 'mob_classic_008':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1B3B48), Color(0xFF17242E), Color(0xFF15151C)],
          accentColor: Color(0xFF48DBFB),
          dishEmoji: '🍋',
          culinaryBadge: 'KİLERDEN 15 DAKİKA',
          icon: Icons.set_meal,
        );
      case 'mob_classic_009':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF561818), Color(0xFF2B1418), Color(0xFF15151C)],
          accentColor: Color(0xFFFF5252),
          dishEmoji: '🌶️',
          culinaryBadge: 'ÇITIR PANKO DOKULU',
          icon: Icons.whatshot,
        );
      case 'mob_classic_010':
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF4A1F12), Color(0xFF281715), Color(0xFF15151C)],
          accentColor: Color(0xFFFF793F),
          dishEmoji: '🍔',
          culinaryBadge: 'MAILLARD SMASH KABUK',
          icon: Icons.lunch_dining,
        );
    }

    if (!recipe.isBuiltIn) {
      if (recipe.id.startsWith('social_')) {
        return const RecipeVisualSpec(
          gradientColors: [Color(0xFF1B3A4B), Color(0xFF1D2238), Color(0xFF14141C)],
          accentColor: Color(0xFF00D2D3),
          dishEmoji: '📲',
          culinaryBadge: 'SOSYAL MEDYA TARİFİ',
          icon: Icons.bolt_rounded,
        );
      }
      return const RecipeVisualSpec(
        gradientColors: [Color(0xFF3E1E3D), Color(0xFF23182E), Color(0xFF14141C)],
        accentColor: Color(0xFFFF6F43),
        dishEmoji: '✨',
        culinaryBadge: 'AI ÖZEL REÇETE',
        icon: Icons.auto_awesome,
      );
    }

    return switch (recipe.category) {
      RecipeCategory.onePot => const RecipeVisualSpec(
          gradientColors: [Color(0xFF482315), Color(0xFF1E1A24)],
          accentColor: Color(0xFFE84A27),
          dishEmoji: '🥘',
          culinaryBadge: 'TEK TAVA',
          icon: Icons.soup_kitchen,
        ),
      RecipeCategory.pasta => const RecipeVisualSpec(
          gradientColors: [Color(0xFF4D3412), Color(0xFF1E1A24)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '🍝',
          culinaryBadge: 'İTALYAN MAKARNA',
          icon: Icons.dinner_dining,
        ),
      RecipeCategory.crispyChicken => const RecipeVisualSpec(
          gradientColors: [Color(0xFF521E14), Color(0xFF1E1A24)],
          accentColor: Color(0xFFFF6F43),
          dishEmoji: '🍗',
          culinaryBadge: 'ÇITIR TAVUK',
          icon: Icons.local_fire_department,
        ),
      RecipeCategory.bowl => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1E3F29), Color(0xFF1A2026)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🥣',
          culinaryBadge: 'DOYURUCU BOWL',
          icon: Icons.rice_bowl,
        ),
      RecipeCategory.highProtein => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1D3E2A), Color(0xFF1A2026)],
          accentColor: Color(0xFF27AE60),
          dishEmoji: '💪',
          culinaryBadge: 'YÜKSEK PROTEİN',
          icon: Icons.fitness_center,
        ),
      RecipeCategory.quickDinner => const RecipeVisualSpec(
          gradientColors: [Color(0xFF3D2214), Color(0xFF1A1C24)],
          accentColor: Color(0xFFF5A623),
          dishEmoji: '⚡',
          culinaryBadge: 'HIZLI AKŞAM YEMEĞİ',
          icon: Icons.bolt,
        ),
      RecipeCategory.budget => const RecipeVisualSpec(
          gradientColors: [Color(0xFF1F3833), Color(0xFF181C24)],
          accentColor: Color(0xFF2ECC71),
          dishEmoji: '🪙',
          culinaryBadge: 'BÜTÇE DOSTU',
          icon: Icons.savings_outlined,
        ),
    };
  }

  /// Kullanıcının alerjileri veya sevmediği malzemeler tarifte geçiyorsa uyarı listesi döner.
  static List<String> findAllergenOrDislikeWarnings(
    Recipe recipe,
    PersonalTasteProfile profile,
  ) {
    final warnings = <String>[];
    final ingText = recipe.ingredients.map((i) => i.name.toLowerCase()).join(' ');

    for (final allergy in profile.allergies) {
      final token = allergy.trim().toLowerCase();
      if (token.isNotEmpty && ingText.contains(token)) {
        warnings.add('Alerjen Uyarısı: $allergy');
      }
    }
    for (final disliked in profile.dislikedIngredients) {
      final token = disliked.trim().toLowerCase();
      if (token.isNotEmpty && ingText.contains(token)) {
        warnings.add('İstenmeyen Malzeme: $disliked');
      }
    }
    return warnings;
  }
}
