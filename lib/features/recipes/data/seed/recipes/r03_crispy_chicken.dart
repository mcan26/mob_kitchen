import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCrispyChickenHotHoney = Recipe(
  id: 'mob_classic_003',
  title: 'Mısır Gevrekli Çıtır Tavuk + Acılı Bal-Sarımsak Sos',
  subtitle: 'Fırın yok, derin yağ yok. Yoğurtta yumuşar, tavada çıtır olur.',
  category: RecipeCategory.crispyChicken,
  prepTimeMinutes: 25,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 690, proteinG: 54, carbsG: 49, fatG: 29),
  tags: ['çıtır tavuk', 'fırınsız', 'airfryer uyumlu', 'acılı', 'bal'],
  chefGoldenRules: [
    'Tavuğu yoğurtta en az 15 dakika beklet: yoğurtun asidi lifleri yumuşatır, tavuk içte sulu kalır.',
    'Mısır gevreğini iri ez, toz yapma; iri parçalar çıtırlığı verir, ince toz yağı emer.',
    'Kızarmış tavuğu kâğıt havlu üstüne değil, tel ızgaraya (veya ters tabağa) koy; altı buharla yumuşamasın.',
  ],
  storageAndReheatingTip:
      'Buzdolabında 2 gün. Tekrar çıtır yapmak için tavada yağsız, orta ateşte her yüzü 2 dakika ısıt veya airfryer\'da 180°C\'de 4 dakika. Mikrodalgada ısıtma, kaplamayı yumuşatır.',
  ingredients: [
    RecipeIngredient(
      name: 'Kemiksiz derisiz tavuk but',
      amount: 450,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: '4-5 cm\'lik parçalar halinde doğranmış',
      buyingTip: 'Çıtır tavukta but en iyi sonucu verir; yağı sayesinde kızartmada kurumaz. Parçaları eşit boyda kes ki aynı sürede pişsin.',
      substituteOption: 'Tavuk göğsü; parçaları biraz daha kalın kes ve her yüzü 30 saniye kısa pişir.',
    ),
    RecipeIngredient(
      name: 'Sade yoğurt',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Tam yağlı, katkısız, normal kıvamlı yoğurt al; marinasyonda süzme olmayanı daha iyi işler.',
      substituteOption: '120 ml ayran veya kefir.',
    ),
    RecipeIngredient(
      name: 'Şekersiz mısır gevreği (cornflakes)',
      amount: 80,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'iri ezilmiş',
      buyingTip: 'Kahvaltılık reyonunda "sade / şekersiz" yazanı seç; çikolatalı veya ballı çeşitler yanar ve tatlı bir kaplama bırakır.',
      substituteOption: 'Panko galeta (en çıtırı), bulamazsan normal galeta + 1 yemek kaşığı mısır nişastası.',
    ),
    RecipeIngredient(
      name: 'Yumurta',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Normal boy yumurta yeterli; yoğurt fazlasını bağlayıcı yapar.',
    ),
    RecipeIngredient(
      name: 'Buğday unu',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Normal çok amaçlı un yeterli.',
      substituteOption: 'Mısır nişastası (daha çıtır, glütensiz).',
    ),
    RecipeIngredient(
      name: 'Sarımsak tozu',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: '"Granül değil toz" yazanı al; tavuk kaplamasına eşit dağılır.',
      substituteOption: 'Taze rendelenmiş 2 diş sarımsak yoğurda karıştırılabilir.',
    ),
    RecipeIngredient(
      name: 'Füme tatlı toz biber (paprika)',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Smoked paprika yazanı seç; füme aroma çıtır kaplamaya mangal hissi verir.',
      substituteOption: 'Normal tatlı toz biber.',
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Ayçiçek yağı (kızartma için)',
      amount: 150,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Rafine, yüksek ısıya dayanıklı ayçiçek veya mısır özü yağını seç; zeytinyağı bu iş için uygun değil.',
      substituteOption: 'Airfryer için: yağ spreyinden 2-3 sıkım yeterli.',
    ),
    RecipeIngredient(
      name: 'Bal',
      amount: 2,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Akışkan çiçek balı al; kristalleşmiş bal sosta eriyip karışması zor olur.',
      substituteOption: 'Pekmez + 1 çay kaşığı şeker veya akçaağaç şurubu.',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 2,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'rendelenmiş',
      buyingTip: 'Sert ve dolgun başlı sarımsak seç.',
    ),
    RecipeIngredient(
      name: 'Acı sos (sriracha tipi)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'İlk malzemesi biber olan, "acı sos" veya "sriracha" yazanı seç; şeker ilk sırada olanı alma.',
      substituteOption: '1 çay kaşığı pul biber + 1 çay kaşığı domates salçası + 1 çay kaşığı su.',
    ),
    RecipeIngredient(
      name: 'Limon',
      amount: 0.5,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      buyingTip: 'Ağır, ince kabuklu ve parlak limonları seç; hafif olan limon sert ve suyu azdır.',
      substituteOption: '1 yemek kaşığı elma sirkesi.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Yoğurtta marine et',
      instruction:
          'Tavuk parçalarını yoğurt, sarımsak tozu, füme paprika ve tuzla karıştır. Üstünü kapat ve en az 15 dakika (zamanın varsa 1 saat) buzdolabında beklet.',
      sensoryCue: 'Tavuk parçalarının hepsi yoğurtla eşit kaplanmış ve kaseye yapışacak kadar sıvı kıvamda olmalı.',
      chefTip:
          'Neden yoğurt? Yoğurtun hafif asidi, et liflerini gevşetir ve tavuğu içte sulu bırakır; aynı zamanda un-yumurta kaplama yapışmasına yardım eder.',
      timerSeconds: 900,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Kaplamayı hazırla',
      instruction:
          'Mısır gevreğini poşet içinde oklava ile iri parçalar kalacak şekilde ez. Üç ayrı tabak hazırla: un, çırpılmış yumurta, ezilmiş gevrek. Tavuğu fazla yoğurdundan hafifçe silkele; sırasıyla una, yumurtaya ve gevreğe bulayıp bastırarak kapla.',
      sensoryCue: 'Gevrek parçaları bezelye boyutunda iri ve düzensiz olmalı; kaplama tavuğa eşit ve boşluksuz yapışmalı.',
      chefTip:
          'Neden önce un? Un, yumurtanın tutunmasını sağlar; yumurta da gevreği yapıştırır. Bu sıra bozulursa kaplama tavada soyulur.',
      mistakeWarning: 'Gevreği toz haline getirme: ince toz yağı emer ve çıtır değil yağlı bir kabuk oluşturur.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Tavada kızart',
      instruction:
          'Geniş tavada yağı orta-yüksek ateşte ısıt. Tavuğu tek sıra koy ve her yüzünü 3-4 dakika kızart. Tel ızgaraya al. (Airfryer kullanacaksan: yağ spreyi sıkıp 190°C\'de 12 dakika, ortada çevirerek.)',
      sensoryCue:
          'Yağın hazır olduğunu anlamak için bir kırıntı gevrek at: hemen cızırdayıp yüzeye çıkmalı. Tavuk koyu altın rengi almalı, kahverengiye dönmemeli. Bir parçayı kesince et suyu berrak akmalı, pembelik kalmamalı.',
      chefTip:
          'Neden tel ızgara? Kâğıt havlu üstündeki tavuğun altı kendi buharıyla yumuşar. Havanın dolaştığı ızgarada her yüz çıtır kalır.',
      timerSeconds: 210,
      mistakeWarning: 'Yağ çok sıcaksa dışı yanar, içi çiğ kalır. Tavuk koyulaşıyor ama içi pişmemişse ateşi kısıp 2 dakika daha pişir.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Acılı bal sosunu hazırla',
      instruction:
          'Küçük bir kasede bal, rendelenmiş sarımsak, acı sos ve limon suyunu çırp. Sıcak tavuğa dökmeden önce tadına bak; daha acı veya ekşi istersen ayarla.',
      sensoryCue: 'Sos akışkan, parlak ve kaşıktan ince bir ip gibi akmalı. Sarımsak kokusu burnuna net gelmeli.',
      chefTip:
          'Sosu tavuğa servis anında sür: erken sürersen nem kaplamayı yumuşatır. Sosu kenara koyup banmaya da uygundur.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Servis et',
      instruction: 'Tavukları sosla fırçala veya kaseye alıp hafifçe karıştır. Hemen servis et.',
      sensoryCue: 'Kaplama sosu emmeden yüzeyde parlıyor ve ısırınca "çıtır" ses geliyor olmalı.',
      chefTip: 'Yanında marul, limon dilimi veya yoğurt-sarımsak sosu iyi gider.',
    ),
  ],
);
