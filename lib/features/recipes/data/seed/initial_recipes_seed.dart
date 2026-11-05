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

/// Yerleşik "Mob Classics" kataloğunun sürümü.
/// Katalogda herhangi bir tarif değiştirildiğinde bu sayıyı artır; uygulama bir
/// sonraki açılışta yerleşik tarifleri günceller (favoriler korunur).
const int kSeedVersion = 1;

/// Uygulama ilk açıldığında internet olmadan yerel veritabanına yüklenen tarifler.
///
/// Tüm içerik Türkçedir; her tarif altın kurallar, reyon/market ipuçları,
/// alternatif malzemeler ve adım başına duyusal işaret + şef püf noktası içerir.
const List<Recipe> kInitialRecipes = [
  mobCreamyGarlicChickenPasta, // Tek Tava
  mobCarbonara, // Makarna
  mobCrispyChickenHotHoney, // Çıtır Tavuk
  mobBurritoBowl, // Bowl / Yüksek Protein
  mobChickpeaShakshuka, // Bütçe Dostu
  mobSoyGarlicBeefBowl, // 20 Dakikalık Akşam
  mobSausagePotatoHash, // Bütçe Dostu / Tek Tava
  mobLemonTunaPasta, // Yüksek Protein
  mobArrabbiataCrispyBreadcrumb, // Makarna / Bütçe Dostu
  mobSmashBurger, // 20 Dakikalık Akşam
];
