import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobLemonTunaPasta = Recipe(
  id: 'mob_classic_008',
  title: 'Limonlu Sarımsaklı Ton Balıklı Makarna',
  subtitle: 'Dolap malzemesiyle 15 dakikada: ferah, protein dolu ve cebi yormaz.',
  category: RecipeCategory.highProtein,
  prepTimeMinutes: 5,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 640, proteinG: 42, carbsG: 79, fatG: 17),
  tags: ['yüksek protein', '15 dakika', 'dolap yemeği', 'ton balığı', 'bütçe dostu'],
  chefGoldenRules: [
    'Makarna suyundan bir su bardağı ayır: zeytinyağı ile birleşince sosu ipeksi yapan şey budur.',
    'Limon kabuğunu rendele ama beyaz kısmı alma; acı olan beyaz kısım, aroma ise sarı kabuktadır.',
    'Ton balığını ocak kapalıyken ekle; fazla pişerse kuru ve kokulu olur.',
  ],
  storageAndReheatingTip:
      'Buzdolabında 2 gün saklanır, soğuk makarna salatası olarak da yenir. Isıtacaksan tavada 2-3 yemek kaşığı su ile kısık ateşte çok kısa ısıt; fazla ısıtma ton balığını kurutur.',
  ingredients: [
    RecipeIngredient(
      name: 'Spagetti',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Bronz kalıp yazanı seç; yüzeyi pürüzlüdür ve sosu daha iyi tutar.',
      substituteOption: 'Linguine veya kırılmış spagetti.',
    ),
    RecipeIngredient(
      name: 'Ton balığı (zeytinyağlı, konserve)',
      amount: 2,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'yağıyla birlikte, parçalanmış',
      buyingTip: 'Büyük parçalı, "yellowfin" veya "bütün fileto" yazanı al; "ezilmiş (flake)" ton balığı kuru ve toz gibidir. Zeytinyağlı olanın yağını atma, sosa katacağız.',
      substituteOption: 'Sade (suda) ton balığı + 2 yemek kaşığı ekstra zeytinyağı. Ya da konserve somon.',
    ),
    RecipeIngredient(
      name: 'Limon',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'kabuğu rendelenmiş, suyu sıkılmış',
      buyingTip: 'Kabuğunu kullanacağın için mümkünse mumsuz/organik limon seç; değilse sıcak suyla iyice yıka. Ağır ve ince kabuklu olan sulu olur.',
      substituteOption: 'Limon yoksa 2 yemek kaşığı elma sirkesi, ama rendeli kabuk aroması eksik kalır.',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince dilimlenmiş',
      buyingTip: 'Başı sert ve ağır olan, filiz vermemiş sarımsak seç; filizli sarımsak acı olur.',
    ),
    RecipeIngredient(
      name: 'Taze maydanoz',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince kıyılmış',
      buyingTip: 'Yaprakları dik ve koyu yeşil olan demeti seç; sapı sulu ve sert olmalı, sarı lekeli demetten kaçın.',
      substituteOption: 'Dereotu veya roka.',
    ),
    RecipeIngredient(
      name: 'Zeytinyağı',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Bu tarifte son dokunuş olduğu için sızma zeytinyağı kullan; sofraya servis yağı olarak iyisini seç.',
    ),
    RecipeIngredient(
      name: 'Pul biber',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Yağlı ve koyu kırmızı pul biber seç; toz gibi solgun olan eskidir. Acı sevmiyorsan yarım çay kaşığıyla başla.',
    ),
    RecipeIngredient(
      name: 'Kaya tuzu (makarna suyu için)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Karabiber',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Makarnayı haşla',
      instruction:
          'Bol suyu kaynat, kaya tuzunu ekle. Spagettiyi paket süresinden 1 dakika kısa pişir (yaklaşık 8-9 dakika). Süzmeden önce 1 su bardağı makarna suyu ayır.',
      sensoryCue: 'Makarnayı ısırdığında ortasında incecik bir beyaz çizgi kalmalı; su bulanık ve sütlü görünmeli.',
      chefTip: 'Makarna suyundaki nişasta, zeytinyağı ile suyu birleştirip pürüzsüz bir sos yapar. Bu su olmadan makarna kuru ve yağlı olur.',
      timerSeconds: 510,
      mistakeWarning: 'Suyu dökmeden önce mutlaka bir bardak ayır!',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sarımsağı yağda hafifçe ısıt',
      instruction:
          'Makarna pişerken geniş bir tavaya zeytinyağını koy, kısık ateşte sarımsak dilimlerini ve pul biberi ekle; 1-2 dakika ısıt.',
      sensoryCue: 'Sarımsak çok hafif cızırdamalı, kenarları açık altın rengi almalı ve tatlı bir koku gelmeli. Koyu kahverengiye dönerse acıdır.',
      chefTip: 'Neden kısık ateş? Yağı yavaşça sarımsakla ısıtınca aroması yağa geçer (sarımsaklı yağ). Yüksek ateşte sarımsak saniyeler içinde yanar.',
      timerSeconds: 90,
      mistakeWarning: 'Sarımsak yanarsa tavayı temizleyip baştan başla; acı tat tüm yemeği bozar.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Makarnayı sosla birleştir',
      instruction:
          'Süzülmüş makarnayı tavaya al. Limon suyunun yarısını, 4-5 yemek kaşığı makarna suyunu ekle ve ateşi orta yap. 1 dakika, tavayı sallayarak ve karıştırarak pişir.',
      sensoryCue: 'Sıvı yağla birleşip hafif beyazımsı, ipeksi bir sos oluşturmalı ve makarnaya yapışmalı. Tavada serbest su kalmamalı.',
      chefTip: 'Karıştırma hareketi yağı ve suyu emülsiyon haline getirir; bu yüzden sos kaymaklı görünür.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Ton balığı ve limon kabuğu',
      instruction:
          'Ocağı kapat. Ton balığını yağıyla birlikte ekle ve ahşap kaşıkla yavaşça, parçalamadan karıştır. Limon kabuğu, maydanoz ve karabiberi ekle.',
      sensoryCue: 'Ton balığı yumuşak büyük parçalar halinde kalmalı; tavada limon ve taze maydanoz kokusu hâkim olmalı.',
      chefTip: 'Neden ocak kapalı? Konserve ton zaten pişmiş. Tekrar ısıtmak sadece kurutur ve balık kokusunu artırır. Tavanın artık sıcaklığı yeterli.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Tat, ayarla, servis et',
      instruction: 'Tadına bak; ekşilik için kalan limon suyunu, kuruysa 1-2 yemek kaşığı makarna suyu ekle. Hemen servis et.',
      sensoryCue: 'Sos ekşi, tuzlu ve hafif acı dengede olmalı; her lokmada limon hissedilmeli.',
      chefTip: 'Tuzu en sona bırak; ton balığı konservesi ve makarna suyu zaten tuzlu.',
    ),
  ],
);
