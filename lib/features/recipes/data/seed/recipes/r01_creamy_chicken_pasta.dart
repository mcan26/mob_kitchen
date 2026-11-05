import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCreamyGarlicChickenPasta = Recipe(
  id: 'mob_classic_001',
  title: 'Tek Tava Kremsi Sarımsaklı Tavuklu Makarna',
  subtitle: 'Makarna tavada pişer, bulaşık tek tava. 30 dakikada restoran kıvamında sos.',
  category: RecipeCategory.onePot,
  prepTimeMinutes: 10,
  cookTimeMinutes: 25,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 745, proteinG: 52, carbsG: 72, fatG: 26),
  tags: ['tek tava', 'tavuk', 'makarna', 'kremsi', 'haftaiçi'],
  chefGoldenRules: [
    'Tavuğu tavaya koymadan önce kâğıt havluyla iyice kurula ve tavayı gerçekten ısıt; yoksa tavuk kızarmaz, haşlanır.',
    'Tavanın dibine yapışan kahverengi tortuyu sıvıyla kazı: sosun lezzetinin yarısı orada.',
    'Peyniri ve kremayı ocağı kısıp ekle; kaynayan sosta peynir topaklanır ve yağını ayırır.',
  ],
  storageAndReheatingTip:
      'Buzdolabında kapalı kapta 3 gün durur. Tekrar ısıtırken 2-3 yemek kaşığı süt veya su ekleyip tavada kısık ateşte karıştır; makarna sosu çeker, su eklemezsen kuru kalır. Dondurucuya uygun değildir (krema ayrışır).',
  ingredients: [
    RecipeIngredient(
      name: 'Kemiksiz derisiz tavuk but',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: '2 cm\'lik parçalar halinde doğranmış',
      buyingTip:
          'Göğüs yerine kemiksiz but al: yağ oranı sayesinde yüksek ısıda kurumaz. Paketin dibinde sıvı birikmemiş, rengi pembe-krem olanı seç.',
      substituteOption:
          'Tavuk göğsü de olur ama pişirme süresini kısalt; 6 dakikadan fazla pişirirsen lifli ve kuru olur.',
    ),
    RecipeIngredient(
      name: 'Penne makarna',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip:
          'Paketinde "bronz kalıp" (bronze die) yazanı seç: yüzeyi pürüzlüdür, sos tutar ve nişasta salarak sosu doğal olarak koyulaştırır.',
      substituteOption: 'Fusilli, farfalle veya kırılmış spagetti; pişme süresi için paketi kontrol et.',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince dilimlenmiş',
      buyingTip: 'Başı sert, kabuğu kuru ve ağır hissettireni seç; filizlenmiş sarımsak acı olur.',
      substituteOption: 'Granül sarımsak (1 çay kaşığı) acil durumda iş görür, ama taze kadar aromalı değildir.',
    ),
    RecipeIngredient(
      name: 'Kuru soğan',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince doğranmış',
      buyingTip: 'Sert, boynu kuru ve ince olan soğanı seç; boynu yumuşaksa içi çürümeye başlamıştır.',
      substituteOption: '3-4 dal taze soğan (beyaz kısmı).',
    ),
    RecipeIngredient(
      name: 'Tavuk suyu (az tuzlu)',
      amount: 400,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip:
          'Etikette "az tuzlu / düşük sodyum" yazanı seç; sıvı kısılınca tuzu yoğunlaşır ve kolayca fazla tuzlu olur.',
      substituteOption: '400 ml sıcak su + yarım adet tavuk bulyon küpü.',
    ),
    RecipeIngredient(
      name: 'Mutfak kreması',
      amount: 100,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Sütlü, en az %18-20 yağlı kremayı al; bitkisel yağlı olan kaynayınca daha kolay kesilir.',
      substituteOption: 'Daha hafif: 3 yemek kaşığı labne + 50 ml sıcak makarna sosu suyu (sonda, ocak kapalıyken ekle).',
    ),
    RecipeIngredient(
      name: 'Parmesan veya eski kaşar',
      amount: 40,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'ince rendelenmiş',
      buyingTip:
          'Torbada hazır rendelenmişi değil, blok halinde olanı al: hazırlarda topaklanmayı önleyen nişasta vardır, sosta pürüzsüz erimez.',
      substituteOption: 'Eski kaşar veya çeşni peyniri.',
    ),
    RecipeIngredient(
      name: 'Füme tatlı toz biber (paprika)',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Etikette "smoked paprika / füme" yazanı seç; tavada pişen yemeklere mangal tadı verir.',
      substituteOption: 'Normal tatlı toz biber + bir tutam kimyon.',
    ),
    RecipeIngredient(
      name: 'Zeytinyağı',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Kavurmada riviera veya rafine zeytinyağı kullan; sızma yüksek ısıda acılaşır.',
      substituteOption: 'Ayçiçek yağı.',
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
      buyingTip: 'Bütün taneli, değirmenli olanı al; öğütülmüş karabiber aromasını hızla kaybeder.',
    ),
    RecipeIngredient(
      name: 'Taze maydanoz',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince kıyılmış',
      buyingTip: 'Yaprakları dik, koyu yeşil olanı seç; sarı lekeli veya sarkık demetten uzak dur.',
      substituteOption: 'Dereotu veya 1 çay kaşığı kuru kekik.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Tavuğu kurula ve baharatla',
      instruction:
          'Tavuk parçalarını kâğıt havluyla iyice kurula. Kaseye al; tuz, karabiber ve füme paprikayı ekleyip ellerinle her parçaya yedir.',
      sensoryCue: 'Tavuğun yüzeyi parlak değil mat ve kuru görünmeli; kâğıt havlu artık nem çekmemeli.',
      chefTip:
          'Neden? Yüzeydeki su, tavada buharlaşırken tavayı soğutur ve tavuk kızarmak yerine haşlanır. Kuru yüzey = kahverengi kabuk = lezzet (Maillard tepkimesi).',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Tavuğu mühürle',
      instruction:
          'Geniş ve derin bir tavayı orta-yüksek ateşte 2 dakika önceden ısıt. Zeytinyağını ekle, tavukları tek sıra halinde yay ve 4 dakika dokunmadan pişir. Çevirip diğer yüzünü 1-2 dakika daha pişir, sonra tabağa al.',
      sensoryCue:
          'Tavuğu koyduğunda net bir "cızz" sesi gelmeli. Altı kolayca ayrılıyor ve koyu altın rengindeyse çevirmeye hazırdır; yapışıyorsa daha bekle.',
      chefTip:
          'Neden dokunmuyoruz? Kabuk oluşması için et ile tava arasında kesintisiz temas gerekir. Tavanın dibinde kalan kahverengi tortu (fond) sosun lezzet bankasıdır.',
      timerSeconds: 240,
      mistakeWarning: 'Tavayı kalabalık yapma; tavuk su salar ve kızarmaz. Gerekirse iki seferde pişir.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Soğan, sonra sarımsak',
      instruction:
          'Aynı tavaya soğanı ekle ve orta ateşte 3 dakika, arada karıştırarak yumuşat. Sarımsağı ekle ve sadece 30 saniye karıştır.',
      sensoryCue:
          'Soğan yarı saydam ve kenarları hafif tatlı kokuyor olmalı. Sarımsak açık sarı olup fındık gibi kokunca bitmiştir; kahverengi olmaya başladıysa hemen sonraki adıma geç.',
      chefTip:
          'Sarımsağı soğandan sonra ekliyoruz çünkü 30 saniyede yanar ve yemeği acılaştırır. Soğan ise yumuşamak için dakikalara ihtiyaç duyar.',
      timerSeconds: 180,
      mistakeWarning: 'Sarımsak yanarsa acı verir. Koyulaşmaya başladığında hemen tavuk suyunu ekleyerek pişmeyi durdur.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Sıvıyı ekle ve makarnayı pişir',
      instruction:
          'Tavuk suyunu ve 200 ml sıcak suyu dök; tavanın dibini tahta kaşıkla kazıyarak tortuyu çöz. Kaynayınca makarnayı ekle, kapağı kapat ve orta-kısık ateşte 10-11 dakika pişir; her 3 dakikada bir karıştır.',
      sensoryCue:
          'Sıvının çoğu çekilmiş, makarna al dente olmalı: ısırınca ortasında kıl inceliğinde beyaz bir çizgi görürsün. Sos kaşığın arkasından ağır akıyorsa tamamdır.',
      chefTip:
          'Neden karıştırıyoruz? Makarna tavanın dibine yapışmasın ve nişasta salıp sosu kendi kendine koyulaştırsın diye. Bu yüzden ayrıca un veya mısır nişastası gerekmez.',
      timerSeconds: 600,
      mistakeWarning: 'Sıvı çok çabuk bittiyse ve makarna sertse 50-100 ml sıcak su ekleyip devam et.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Tavuğu geri ekle, krema ve peyniri kat',
      instruction:
          'Ateşi en kısığa çek. Tavukları ve biriken suyunu tavaya geri koy, kremayı ekle ve 1 dakika karıştır. Ocağı kapat, peyniri ekleyip eriyene kadar karıştır.',
      sensoryCue:
          'Sos makarnaya yapışacak kadar parlak ve kremsi görünmeli; tavayı yatırdığında yavaşça kaymalı. Kenarlarda yağ gözleri varsa ısı fazla yüksek demektir.',
      chefTip:
          'Neden ocağı kapatıyoruz? Peynirin proteini 70°C üstünde büzülüp yağını bırakır ve topaklanır. Tavanın artık ısısı peyniri eritmeye yeter.',
      timerSeconds: 90,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Dinlendir ve servis et',
      instruction: 'Kapağı kapat ve 2 dakika dinlendir. Maydanozu serp, taze karabiberle servis et.',
      sensoryCue: 'Dinlenince sos hafifçe koyulaşır ve makarna parlak, "sosa batmış" görünür.',
      chefTip:
          'Neden bekliyoruz? Makarnanın nişastası sosu toparlar. Hemen yersen sos akışkan kalır, 2 dakika sonra tam kıvamını bulur.',
      timerSeconds: 120,
    ),
  ],
);
