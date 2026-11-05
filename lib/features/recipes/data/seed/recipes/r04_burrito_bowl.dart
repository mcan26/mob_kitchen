import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobBurritoBowl = Recipe(
  id: 'mob_classic_004',
  title: 'Yüksek Proteinli Tavuklu Burrito Bowl',
  subtitle: 'Baharatlı tavuk, fasulye, limonlu pirinç ve yoğurtlu sos. Tek tavada, 30 dakikada.',
  category: RecipeCategory.bowl,
  prepTimeMinutes: 15,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 710, proteinG: 55, carbsG: 78, fatG: 17),
  tags: ['bowl', 'yüksek protein', 'meal prep', 'fırınsız', 'tex-mex'],
  chefGoldenRules: [
    'Pirinci pişirmeden önce soğuk suyla yıka; fazla nişasta gider ve taneler birbirine yapışmaz.',
    'Baharatı tavukla değil yağla kavur; yağda çözünen aroma bileşenleri açığa çıkar.',
    'Taze malzemeleri (avokado, domates, soğan) en sona bırak ve tuzla; böylece tazeliği ve rengi bozulmaz.',
  ],
  storageAndReheatingTip:
      'Haftalık hazırlık için: tavuk ve pirinç kapalı kapta 4 gün saklanır; taze malzemeleri ve sosu ayrı kapta tut. Isıtırken tavuk-pirinci mikrodalgada 2 dakika, 1 yemek kaşığı su serperek ısıt. Avokadoyu servis anında doğra.',
  ingredients: [
    RecipeIngredient(
      name: 'Kemiksiz derisiz tavuk but',
      amount: 350,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'ince şeritler halinde doğranmış',
      buyingTip: 'Ince şeritler halinde kesilince çabuk pişer; rengi pembe-krem, kokusuz olanı seç.',
      substituteOption: 'Tavuk göğsü (ince dilimle, süreyi kısalt) veya dana kıyma.',
    ),
    RecipeIngredient(
      name: 'Basmati pirinç',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Uzun taneli, kırığı az basmati seç; "yaşlandırılmış (aged)" yazanı daha dağınık pişer.',
      substituteOption: 'Normal uzun taneli pirinç veya bulgur (pişme süresini kontrol et).',
    ),
    RecipeIngredient(
      name: 'Kırmızı fasulye (konserve)',
      amount: 1,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'süzülmüş ve durulanmış',
      buyingTip: 'İçeriğinde sadece fasulye, su ve tuz olanı al; şekerli veya sosla gelen çeşitten uzak dur. Süzüp bol suyla durula.',
      substituteOption: 'Siyah fasulye, nohut veya kuru fasulyeyi önceden haşlayıp kullan.',
    ),
    RecipeIngredient(
      name: 'Avokado',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'dilimlenmiş',
      buyingTip: 'Parmakla hafifçe bastırınca azıcık içe giren (ama ezilmeyen) avokado olgundur; sapının altı yeşilse içi de yeşildir.',
      substituteOption: 'Pahalıysa: 2 yemek kaşığı zeytinyağlı humus veya bir avuç salatalık küpü.',
    ),
    RecipeIngredient(
      name: 'Domates',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'küp doğranmış',
      buyingTip: 'Sap kısmı yeşil, kokulu ve tam kırmızı domatesi seç; buzdolabına koyma, aroması gider.',
      substituteOption: 'Kirazlı (çeri) domates.',
    ),
    RecipeIngredient(
      name: 'Kırmızı soğan',
      amount: 0.5,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince doğranmış',
      buyingTip: 'Kabuğu parlak ve kuru, yüzeyi sert soğan seç.',
      substituteOption: 'Taze soğan.',
    ),
    RecipeIngredient(
      name: 'Limon',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      buyingTip: 'Ağır ve ince kabuklu limon daha sulu olur.',
      substituteOption: '2 yemek kaşığı elma sirkesi.',
    ),
    RecipeIngredient(
      name: 'Sade yoğurt',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Yüksek proteinli sos için süzme yoğurt (Yunan tipi) seç; tam yağlı olan en kremsi sonucu verir.',
      substituteOption: 'Labne veya ekşi krema.',
    ),
    RecipeIngredient(
      name: 'Kimyon',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Tane kimyonu alıp hemen öğütmek en iyisi; hazır toz kimyonun üretim tarihine bak.',
    ),
    RecipeIngredient(
      name: 'Füme tatlı toz biber (paprika)',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Smoked paprika yazanı al.',
      substituteOption: 'Normal tatlı toz biber + bir tutam pul biber.',
    ),
    RecipeIngredient(
      name: 'Sarımsak tozu',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      substituteOption: '2 diş taze sarımsak, rendelenmiş.',
    ),
    RecipeIngredient(
      name: 'Zeytinyağı',
      amount: 2,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      substituteOption: 'Ayçiçek yağı.',
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 1.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Pirinci yıka ve pişir',
      instruction:
          'Pirinci süzgeçte soğuk suyla, su berraklaşana kadar yıka. Küçük bir tencerede 1 su bardağı pirinç için 1,5 su bardağı su, yarım çay kaşığı tuz ve yarım limonun suyuyla kaynat. Kapağı kapat, en kısık ateşte 12 dakika pişir; ocağı kapat ve 5 dakika dinlendir.',
      sensoryCue: 'Tencerede su kalmamış ve yüzeyde küçük buhar delikleri oluşmuş olmalı. Kapağı açınca taneler ayrık ve parlak görünür.',
      chefTip:
          'Neden yıkıyoruz? Pirincin yüzeyindeki serbest nişasta, pişerken yapışkan bir bulamaç oluşturur. Neden dinlendiriyoruz? Kalan buhar taneleri eşit pişirir.',
      timerSeconds: 720,
      mistakeWarning: 'Pişerken kapağı açma; buhar kaçarsa pirinç düzensiz pişer.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Baharatları yağda uyandır',
      instruction:
          'Geniş bir tavada zeytinyağını orta ateşte ısıt. Kimyon, füme paprika, sarımsak tozunu ekle ve 20 saniye, karıştırarak kavur.',
      sensoryCue: 'Baharatlar yağda hafifçe köpürmeli ve odaya sıcak, dumanlı bir koku yayılmalı. Koyu kahverengi olmadan hemen tavuğu ekle.',
      chefTip:
          'Neden baharatı önce yağda kavuruyoruz? Aroma bileşenlerinin çoğu yağda çözünür; kuru olarak eklenirse tat yüzeyde kalır. Yağda 20 saniye bekleyince tüm yemeğe dağılır.',
      timerSeconds: 20,
      mistakeWarning: 'Baharatlar çabuk yanar. Koyu kahverengiye döndüyse acı olur; ateşi kıs ve tavuğu hemen ekle.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Tavuğu pişir',
      instruction:
          'Tavuk şeritlerini tuzla ve baharatlı yağın içine ekle. Orta-yüksek ateşte, ilk 2 dakika dokunmadan, sonra çevirerek toplam 6-7 dakika pişir.',
      sensoryCue:
          'Tavuğun dışı koyu altın kahve ve kenarları hafif çıtır olmalı. En kalın parçayı kesince et suyu berrak akmalı, pembelik kalmamalı.',
      chefTip:
          'Neden ilk dakikalarda dokunmuyoruz? Altın kabuk oluşması için et ile tavanın kesintisiz temas etmesi gerekir; sürekli karıştırırsan tavuk su salar ve haşlanır.',
      timerSeconds: 390,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Fasulyeyi ısıt, sosu hazırla',
      instruction:
          'Tavuğun yanına süzülmüş fasulyeyi ekle ve 2 dakika ısıt. Bu sırada yoğurdu kalan limonun suyu ve bir tutam tuzla çırp.',
      sensoryCue: 'Fasulyeler sıcak ve baharata bulanmış, hafifçe parlak olmalı. Sos kaşıkta yoğurt kıvamında, akıcı ama sulu değil.',
      chefTip: 'Yoğurdu ısıtma; sıcaklık kesilmesine yol açar. Sosu soğuk bırak: sıcak tavuk-pirinç ile serinletici bir tezat oluşturur.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Kasenin içini kur',
      instruction:
          'Kaselerin tabanına pirinci yay; üzerine tavuk-fasulye karışımını, doğranmış domates, kırmızı soğan ve avokado dilimlerini diz. Yoğurt sosunu üzerine gezdir.',
      sensoryCue: 'Her bileşen ayrı bir renk veriyor olmalı: kahverengi tavuk, kırmızı domates, yeşil avokado, beyaz sos.',
      chefTip: 'Domates ve soğanı serpiştirmeden önce bir tutam tuzla; suyunu hafif salar ve bowl\'a doğal bir sos olur.',
    ),
  ],
);
