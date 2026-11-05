import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobChickpeaShakshuka = Recipe(
  id: 'mob_classic_005',
  title: 'Nohutlu Şakşuka (Tek Tava Yumurtalı Domates)',
  subtitle: 'Cebi yormayan tek tava: nohut doyurur, yumurta protein ekler, ekmek sosa banılır.',
  category: RecipeCategory.budget,
  prepTimeMinutes: 10,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 520, proteinG: 28, carbsG: 48, fatG: 24),
  tags: ['bütçe dostu', 'tek tava', 'vejetaryen', 'yumurtalı', 'nohut'],
  chefGoldenRules: [
    'Domates sosunu yumurtaları kırmadan önce yağı ayırıp koyulaşana kadar pişir; sulu sosta yumurta pişmez, haşlanır.',
    'Salçayı yağda 1 dakika kavur; çiğ salça tadı gider, tatlı ve derin bir domates aroması gelir.',
    'Yumurtayı kapak altında pişir, beyazı donunca sarısı akışkan kalacak şekilde ocaktan al; tavada bekledikçe pişmeye devam eder.',
  ],
  storageAndReheatingTip:
      'Yumurtasız sos (nohut + domates) buzdolabında 4 gün saklanır ve ikinci gün daha lezzetli olur. Isıtıp yeni yumurta kırarak servis et. Yumurtalı hali saklamayı önermem.',
  ingredients: [
    RecipeIngredient(
      name: 'Nohut (konserve)',
      amount: 1,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'süzülmüş ve durulanmış',
      buyingTip: 'İçeriğinde sadece nohut, su ve tuz olanı al. Kutu bombeliyse veya sıvı bulanıksa alma.',
      substituteOption: 'Kuru nohutu bir gece ıslatıp haşlarsan çok daha ucuza gelir (1 su bardağı kuru ≈ 1 kutu).',
    ),
    RecipeIngredient(
      name: 'Domates (rendelenmiş / konserve)',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Rendelenmiş veya bütün soyulmuş konserve domatesi seç; içeriği sadece domates olanı al, ilave şeker/koyulaştırıcı olmasın.',
      substituteOption: 'Mevsimindeyse 5 olgun domatesi rendele; sezon dışıysa konserve daha lezzetli olur.',
    ),
    RecipeIngredient(
      name: 'Yumurta',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Çatlak olmayan, serbest dolaşan tavuk yumurtalarını seç; kutudaki son kullanma tarihine bak.',
    ),
    RecipeIngredient(
      name: 'Kuru soğan',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince doğranmış',
      buyingTip: 'Sert ve kuru boyunlu soğan seç.',
    ),
    RecipeIngredient(
      name: 'Kırmızı kapya biber',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'küp doğranmış',
      buyingTip: 'Parlak, sert ve kabuğu buruşmamış biber seç.',
      substituteOption: 'Dolmalık biber veya 2 yemek kaşığı közlenmiş biber (kavanoz).',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince kıyılmış',
    ),
    RecipeIngredient(
      name: 'Domates salçası',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Cam kavanozdaki, ilk malzemesi sadece domates olan salçayı al.',
      substituteOption: 'Biber salçası (ekstra acı ve derinlik katar).',
    ),
    RecipeIngredient(
      name: 'Kimyon',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Pul biber',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Yağlı, koyu kırmızı ve kokulu pul biber al; toz gibi olanlar genelde eskidir.',
    ),
    RecipeIngredient(
      name: 'Beyaz peynir',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'ufalanmış',
      buyingTip: 'Tam yağlı ve tuzu çok olmayan beyaz peynir seç; çok tuzluysa 15 dakika suda beklet.',
      substituteOption: 'Lor peyniri veya çökelek.',
    ),
    RecipeIngredient(
      name: 'Zeytinyağı',
      amount: 2,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Köy ekmeği',
      amount: 4,
      unit: MeasurementUnit.slice,
      aisleCategory: AisleCategory.bakery,
      buyingTip: 'Ekşi mayalı veya taş fırın ekmeği al; sosa banınca dağılmaz. Dünden kalan ekmek bile tavada kızartınca mükemmeldir.',
      substituteOption: 'Pide dilimi veya tost ekmeği.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Soğan ve biberi yumuşat',
      instruction:
          'Geniş ve derin bir tavada zeytinyağını orta ateşte ısıt. Soğan ve kapya biberi 5 dakika, ara sıra karıştırarak kavur.',
      sensoryCue: 'Soğan şeffaflaşmış ve kenarları hafif altın rengi almış olmalı. Biber yumuşak ve parlak görünmeli.',
      chefTip: 'Neden acele etmiyoruz? Soğan yumuşadıkça şekeri salar ve sosa doğal tatlılık verir; çiğ soğan kokusu kalmaz.',
      timerSeconds: 300,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sarımsak, salça ve baharatlar',
      instruction:
          'Sarımsağı ekle ve 30 saniye karıştır. Sonra salça, kimyon, pul biberi ilave edip 1 dakika kavur.',
      sensoryCue: 'Salça koyulaşıp tavanın dibinde hafifçe tutunmaya başlamalı; tatlı, derin bir domates kokusu yayılmalı.',
      chefTip: 'Neden salçayı kavuruyoruz? Çiğ salçanın ekşi ve metalimsi tadı yağda pişince karamelize olur. Bu 1 dakika sosun lezzetini ikiye katlar.',
      timerSeconds: 60,
      mistakeWarning: 'Salça yanarsa acı olur. Yapışıyorsa 2 yemek kaşığı su ekle.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Domates ve nohutu kaynat',
      instruction:
          'Domatesleri, nohutu ve tuzu ekle. Orta ateşte, ara sıra karıştırarak 10-12 dakika, sos koyulaşana kadar pişir.',
      sensoryCue:
          'Kaşıkla tavanın dibini sıyırınca, sos birkaç saniye açık iz bırakmalı. Yüzeyde yağ gözleri belirmeli ve sos kıvamlanmış olmalı.',
      chefTip:
          'Neden koyulaştırıyoruz? Su buharlaşmazsa yumurtalar sosun içine dağılır ve haşlanır. Koyu sos yumurtayı "tutar".',
      timerSeconds: 660,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Yumurtaları kır',
      instruction:
          'Kaşıkla sosta 4 çukur aç ve yumurtaları dikkatle içine kır. Kapağı kapat; kısık ateşte 4-6 dakika pişir.',
      sensoryCue:
          'Yumurta akı tamamen beyazlaşmış, sarısı hâlâ hafifçe titrer ve parlak olmalı. Tavayı hafifçe salladığında sarı akışkan hareket ediyor olmalı.',
      chefTip:
          'Neden kapak? Üstteki buhar, akı üstten de pişirir; yumurtayı çevirmeye gerek kalmaz. Sarısı akışkan istiyorsan 4 dakikada kontrol et, tava sıcaklığıyla pişmeye devam edeceğini unutma.',
      timerSeconds: 300,
      mistakeWarning: 'Kapağı sık sık açma, buhar kaçar ve yumurta üstten pişmez.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Servis et',
      instruction: 'Üzerine ufalanmış beyaz peyniri serp. Ekmeği kızartıp tavanın yanında servis et.',
      sensoryCue: 'Peynir sosun sıcaklığıyla hafifçe yumuşamalı ama tamamen erimemeli.',
      chefTip: 'Ekmeğin bir yüzünü kuru tavada ya da tost makinesinde kızartırsan sosa banınca dağılmaz.',
    ),
  ],
);
