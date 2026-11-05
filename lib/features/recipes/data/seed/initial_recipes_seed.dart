import '../../domain/entities/recipe.dart';
import 'recipes/r01_creamy_chicken_pasta.dart';
import 'recipes/r02_carbonara.dart';
import 'recipes/r03_crispy_chicken.dart';
import 'recipes/r04_burrito_bowl.dart';
import 'recipes/r05_chickpea_shakshuka.dart';
import 'recipes/r06_soy_beef_bowl.dart';
import 'recipes/r07_sausage_potato_hash.dart';
import 'recipes/r08_lemon_tuna_pasta.dart';
import 'recipes/r09_arrabbiata_breadcrumb.dart';
import 'recipes/r10_smash_burger.dart';
import 'recipes/r11_thai_basil_chicken.dart';
import 'recipes/r12_wild_mushroom_risotto.dart';
import 'recipes/r13_crispy_salmon.dart';
import 'recipes/r14_coconut_chickpea_curry.dart';
import 'recipes/r15_korean_beef_bulgogi.dart';
import 'recipes/r16_butter_chicken_rice.dart';

/// Version number for the built-in SimmerLink offline recipe catalog.
/// Bump this integer whenever recipes are added or modified; the app will
/// automatically refresh built-in recipes in the local Drift SQLite database on next boot.
const int kSeedVersion = 2;

/// Offline-first seed recipes loaded into the local database on launch without network.
///
/// 100% English catalog: each recipe includes chef golden rules, supermarket aisle buying tips,
/// ingredient substitutes, step sensory cues, and wall-clock smart timers.
const List<Recipe> kInitialRecipes = [
  mobCreamyGarlicChickenPasta, // One-Pan / Pasta
  mobCarbonara, // Pasta
  mobCrispyChickenHotHoney, // Crispy Chicken
  mobBurritoBowl, // Bowl / High-Protein
  mobChickpeaShakshuka, // Budget-Friendly / One-Pan
  mobSoyGarlicBeefBowl, // 20-Minute Dinner / Rice Bowl
  mobSausagePotatoHash, // Budget-Friendly / One-Pan
  mobLemonTunaPasta, // High-Protein / Pasta
  mobArrabbiataCrispyBreadcrumb, // Pasta / Budget-Friendly
  mobSmashBurger, // 20-Minute Dinner
  mobThaiBasilChicken, // 20-Minute Dinner / High-Protein
  mobWildMushroomRisotto, // One-Pan / Vegetarian
  mobCrispySalmon, // High-Protein / Seafood
  mobCoconutChickpeaCurry, // Budget-Friendly / Plant-Based
  mobKoreanBeefBulgogi, // 20-Minute Dinner / High-Protein
  mobButterChickenRice, // Crispy Chicken / Comfort Food
];
