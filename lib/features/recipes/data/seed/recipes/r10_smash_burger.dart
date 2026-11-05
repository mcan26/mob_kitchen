import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSmashBurger = Recipe(
  id: 'mob_classic_010',
  title: 'Tavada Smash Burger + Mob Sosu',
  subtitle: 'Fırın yok, ızgara yok. Dökme demir tavada ezilen, kenarları dantel gibi çıtır burger.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 10,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 820, proteinG: 48, carbsG: 52, fatG: 46),
  tags: ['burger', '20 dakika', 'tavada', 'kıyma', 'hafta sonu'],
  chefGoldenRules: [
    'Tavayı gerçekten kızdır: dumanı çıkana kadar bekle. Smash burger yüksek ısı ve sert bir ezmeyle çıtır "dantel" kenar yapar.',
    'Kıymayı top yapıp tavaya koyduktan hemen sonra ez ve bir daha dokunma; sadece 1 kez çevir.',
    'Kıymayı sıkıp yoğurma; soğuk ve gevşek tut. Fazla yoğrulursa burger sert ve lastik gibi olur.',
  ],
  storageAndReheatingTip:
      'Smash burger taze yenir. Artarsa köfteleri buzdolabında 2 gün saklayabilirsin; kuru tavada 1 dakika her yüzünü ısıt. Sosu kapalı kapta 5 gün saklayabilirsin.',
  ingredients: [
    RecipeIngredient(
      name: 'Dana kıyma (%20 yağlı)',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: '4 eşit toplara bölünmüş (75 g)',
      buyingTip: 'Smash burger için yağlı kıyma şart: kasaptan "%20 yağlı, kıyma (burger için)" iste; az yağlı kıyma kuru ve lezzetsiz olur. Kıymanın tek çekim ve soğuk olması önemli.',
      substituteOption: 'Az yağlı kıyma kullanacaksan 1 yemek kaşığı tereyağını soğuk küp olarak kıymaya karıştır.',
    ),
    RecipeIngredient(
      name: 'Hamburger ekmeği',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.bakery,
      buyingTip: 'Yumuşak, hafif tatlı (brioche tarzı) ve susamlı ekmek en iyisidir; sert veya kalın kabuklu ekmek kıymanın çıtırlığını yener.',
      substituteOption: 'Yumuşak yuvarlak ekmek veya kare tost ekmeği.',
    ),
    RecipeIngredient(
      name: 'Cheddar peyniri (dilim)',
      amount: 4,
      unit: MeasurementUnit.slice,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Eriyen, "burger peyniri" veya "cheddar dilim" yazanı seç; sert kaşar dilimi burger üstünde güzel erimez.',
      substituteOption: 'Taze kaşar dilimi veya eritme peynir.',
    ),
    RecipeIngredient(
      name: 'Kuru soğan',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'çok ince halkalar halinde',
      buyingTip: 'Sert ve kuru boyunlu bir soğan seç.',
    ),
    RecipeIngredient(
      name: 'Turşu (salatalık)',
      amount: 4,
      unit: MeasurementUnit.slice,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'ince dilimlenmiş',
      buyingTip: 'Kornişon veya dilimlenmiş hamburger turşusu al; sirkeli ve tatlı olanı sosa uyum sağlar.',
      substituteOption: 'Normal salatalık turşusu.',
    ),
    RecipeIngredient(
      name: 'Marul (göbek)',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'yaprak',
      buyingTip: 'Sert, gevrek göbek marul veya iceberg seç; yaprakları kıvrık ve kenarı kahverengi olmasın.',
      substituteOption: 'Roka veya yeşil marul.',
    ),
    RecipeIngredient(
      name: 'Mayonez',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Şişenin kendi içeriğine bak: yumurta ve yağ ilk sırada olmalı. Tam yağlı mayonez daha iyi sos yapar.',
      substituteOption: 'Süzme yoğurt (daha hafif ve ekşi).',
    ),
    RecipeIngredient(
      name: 'Ketçap',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Hardal',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Klasik sarı veya Dijon hardal; ikisi de olur.',
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Karabiber',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Tereyağı',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Ekmeği kızartmak için; katkısız tereyağı seç.',
      substituteOption: 'Zeytinyağı.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Sosu ve malzemeleri hazırla',
      instruction:
          'Mayonez, ketçap, hardal ve 1 yemek kaşığı turşu suyunu karıştır. Soğanı çok ince doğra, turşuyu dilimle, marulu hazırla. Kıymayı 4 eşit parçaya bölüp gevşek toplar yap, tuzlama; buzdolabında beklet.',
      sensoryCue: 'Sos pembe-turuncu, pürüzsüz ve kaşıktan akıcı kıvamda olmalı. Kıyma topları soğuk ve gevşek, sıkıştırılmamış olmalı.',
      chefTip: 'Neden tuzlamıyoruz? Tuz kıymadaki proteini çözer ve dokuyu sıkılaştırır; tuzu sadece pişirirken, tavada ezdikten sonra serpiyoruz.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Ekmekleri kızart',
      instruction: 'Tavada tereyağını orta ateşte erit, ekmeklerin iç kısmını 1 dakika, altın rengi olana kadar kızart. Tabağa al ve tavayı silmeden hemen sıcak bırak.',
      sensoryCue: 'İç yüzeyi altın-kahverengi ve hafif çıtır olmalı; tereyağı kokusu odaya yayılır.',
      chefTip: 'Neden kızartıyoruz? Kızarmış yüzey, sosun ve kıyma suyunun ekmeği ıslatmasını engeller; ekmek dağılmaz.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Tavayı kızdır',
      instruction: 'Dökme demir veya kalın tabanlı tavayı en yüksek ateşte 3-4 dakika, hafif duman çıkana kadar ısıt. Yağ ekleme.',
      sensoryCue: 'Tavanın yüzeyinden ince bir duman yükselmeli; üstüne su damlatınca anında buharlaşıp yok olur.',
      chefTip: 'Neden yağsız ve bu kadar sıcak? Kıymanın kendi yağı yeterli. Aşırı sıcak tava, kıymayı saniyeler içinde mühürler ve çıtır "dantel" kenar oluşturur.',
      timerSeconds: 210,
      mistakeWarning: 'Tava yeterince sıcak değilse köfte kendi suyunda haşlanır ve gri olur.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Ez ve kızart',
      instruction:
          'İki kıyma topunu tavaya koy; üstlerine birer parça yağlı kâğıt serip metal spatula veya sağlam bir kaşıkla tüm ağırlığınla 10 saniye ezerek incecik yap, kâğıdı çıkar. Tuz ve karabiber serp. 1,5-2 dakika dokunmadan pişir.',
      sensoryCue:
          'Kenarları koyu kahverengi, dantel gibi çıtır görünmeli; yüzeyde küçük nem damlacıkları belirmeli ve alttan "cızz" sesi gelmeli.',
      chefTip: 'Neden ezmek? İnce yüzey kıymanın tavayla maksimum temas etmesini sağlar; bu da hızlı kahverengileşme (Maillard) ve yoğun et aroması demektir.',
      timerSeconds: 100,
      mistakeWarning: 'Ezdikten sonra tekrar bastırma; etin suyu kaçar ve burger kuru olur.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Çevir, peyniri erit',
      instruction:
          'Sert spatulayla köfteyi tek hamlede, tavadan kazıyarak çevir. Hemen üstüne peynir dilimi koy ve 30-45 saniye pişir. Aynı işlemi diğer köfteler için tekrarla.',
      sensoryCue: 'Köftenin alt yüzü koyu kahve, çıtır ve tavadan kolayca ayrılıyor olmalı. Peynir kenarlardan eriyip köfteyi sarmalamalı.',
      chefTip: 'Peyniri çevirdikten sonra koyuyoruz: sıcak köfteden gelen buhar peyniri hemen eritir, kapağa gerek kalmaz.',
      timerSeconds: 45,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Burgeri birleştir',
      instruction:
          'Alt ekmeğe sos sür, marul, soğan, turşu ve çift köfteyi koy. Üst ekmeğe sos sürüp kapat. Hemen servis et.',
      sensoryCue: 'Burger elinde sıcak ve kenarlarından peynir sarkıyor olmalı; ilk ısırıkta çıtır kenar sesi duyulmalı.',
      chefTip: 'Marulu köftelerin altına koy: sıcaklık ve sos marulu buruşturmaz, ekmeği de ıslatmaz.',
    ),
  ],
);
