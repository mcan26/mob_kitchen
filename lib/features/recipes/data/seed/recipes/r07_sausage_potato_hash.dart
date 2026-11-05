import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSausagePotatoHash = Recipe(
  id: 'mob_classic_007',
  title: 'Sucuklu Çıtır Patates Hash + Yumurta',
  subtitle: 'Tek tavada çıtır patates, sucuk yağında kavrulmuş soğan ve peynir. Kahvaltı da olur, akşam yemeği de.',
  category: RecipeCategory.budget,
  prepTimeMinutes: 10,
  cookTimeMinutes: 25,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 780, proteinG: 33, carbsG: 62, fatG: 44),
  tags: ['bütçe dostu', 'tek tava', 'sucuk', 'patates', 'brunch'],
  chefGoldenRules: [
    'Patatesi önce kapalı kapakla buharda yumuşat, sonra kapağı aç ve çıtırlaştır: içi pamuk, dışı çıtır olur.',
    'Patatesleri tavada çok sık karıştırma; her yüzü 3-4 dakika dokunulmadan kalmalı ki altın kabuk bağlasın.',
    'Sucuğun yağını atma; patatesi sucuk yağında pişirmek tek başına yeterli lezzet bombası.',
  ],
  storageAndReheatingTip:
      'Buzdolabında 3 gün saklanır. Tekrar çıtır yapmak için kuru tavada orta-yüksek ateşte 4-5 dakika, ara sıra çevirerek ısıt; mikrodalga çıtırlığı öldürür. Yumurtayı her zaman taze pişir.',
  ingredients: [
    RecipeIngredient(
      name: 'Patates',
      amount: 500,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.produce,
      preparationNote: '1,5 cm\'lik küpler halinde (kabuklu)',
      buyingTip: 'Sert, pürüzsüz, filiz ve yeşil lekesi olmayan patates seç; yeşil kısım acı ve zehirlidir. Mumsu (sarı etli) patates dağılmadan çıtırlaşır.',
      substituteOption: 'Tatlı patates da olur ama biraz daha kısa pişer.',
    ),
    RecipeIngredient(
      name: 'Dana sucuk',
      amount: 120,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'yarım ay dilimler halinde',
      buyingTip: 'Etiketinde "%100 dana" ve katkısız yazanı al; yüzeyi parlak ve kızıl yağlı, içi koyu kırmızı olmalı. Kuru ve ince olan değil, hafif yumuşak sucuk iyi yağ verir.',
      substituteOption: 'Pastırma küpleri, füme hindi veya sosis (yağ azsa 1 yemek kaşığı ayçiçek yağı ekle).',
    ),
    RecipeIngredient(
      name: 'Kuru soğan',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'yarım ay doğranmış',
      buyingTip: 'Sert ve kuru boyunlu soğan seç.',
    ),
    RecipeIngredient(
      name: 'Yeşil dolmalık biber',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'küp doğranmış',
      buyingTip: 'Etli, parlak ve sert dolmalık biber seç; hafif olanlar genelde içi boştur.',
      substituteOption: 'Çarliston biber (daha ince ve acı) veya kırmızı biber.',
    ),
    RecipeIngredient(
      name: 'Yumurta',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Kabuğu çatlaksız, serbest dolaşan tavuk yumurtası (kod 0-1) seç; kutudaki tarih en az 10 gün ileride olsun.',
    ),
    RecipeIngredient(
      name: 'Kaşar peyniri',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'rendelenmiş',
      buyingTip: 'Dilimli yerine blok kaşar al ve kendin rendele; eski kaşar çok daha aromalıdır.',
      substituteOption: 'Cheddar veya mozzarella.',
    ),
    RecipeIngredient(
      name: 'Pul biber',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Yağlı, koyu kırmızı ve kokulu pul biberi seç; solgun ve tozlu olan eskidir.',
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Ayçiçek yağı',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Sucuğu kavur',
      instruction:
          'Geniş, kalın tabanlı bir tavayı orta ateşte ısıt. Sucuk dilimlerini ekle ve 3-4 dakika, yağını salıp kenarları çıtırlaşana kadar kavur. Sucukları kevgirle alıp tabağa koy; yağı tavada bırak.',
      sensoryCue: 'Tavada kızıl, aromalı bir yağ gölü oluşmalı. Sucuğun kenarları hafif çıtır, kokusu baharatlı ve dumanlı olmalı.',
      chefTip: 'Neden sucuğu çıkarıyoruz? Patates için kızgın yağ lazım ama sucuk uzun süre pişerse kurur ve sertleşir. Yağı kullanıp sucuğu sona saklıyoruz.',
      timerSeconds: 210,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Patatesi buharda yumuşat',
      instruction:
          'Patates küplerini ve gerekirse 1 yemek kaşığı yağı ekle, tuzla ve kapağı kapat. Orta ateşte 8-10 dakika, 3 dakikada bir karıştırarak pişir.',
      sensoryCue: 'Çatalla patatese bastırdığında az direnç gösterip içine girmeli; kenarlarda ilk altın lekeler görünmeli.',
      chefTip:
          'Neden kapak? Kapalı tavada oluşan buhar patatesin içini pişirir. Sonra kapağı açıp nemi buharlaştırınca dış yüzey çıtırlaşır; hepsini açık tavada yapsan dışı yanar, içi çiğ kalır.',
      timerSeconds: 540,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Kapağı aç, çıtırlaştır',
      instruction:
          'Kapağı aç, ateşi orta-yüksek yap. Soğan ve biberi ekle; patateslerin her yüzü altın rengine dönene kadar 6-8 dakika, nadiren karıştırarak pişir.',
      sensoryCue:
          'Patates parçaları altın-kahverengi kabuk bağlamış ve kaşıkla çevirdiğinde "çıtır" bir ses çıkarıyor olmalı. Soğan hafif karamelize ve tatlı kokuyor.',
      chefTip: 'Neden nadiren karıştırıyoruz? Çıtır kabuk için patatesin tavayla kesintisiz temas etmesi gerekir; sürekli karıştırırsan kabuk oluşmaz.',
      timerSeconds: 420,
      mistakeWarning: 'Tavaya yapışıyorsa biraz daha bekle: kabuk bağlayınca kendiliğinden kalkar. Zorlarsan parçalanır.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Sucuk ve yumurtalar',
      instruction:
          'Sucukları tavaya geri ekle, pul biberi serp. Kaşıkla 4 çukur aç, yumurtaları kır. Üzerine kaşar serp, kapağı kapat ve kısık ateşte 3-4 dakika pişir.',
      sensoryCue: 'Yumurta akları tamamen beyazlamış, sarıları parlak ve hafifçe titrek olmalı. Peynir kenarlarda eriyip patatese yapışmış.',
      chefTip: 'Yumurta sarısı kesilince patatesin üstüne dökülür ve kendi sosunu oluşturur; bu yüzden sarıyı akışkan bırakıyoruz.',
      timerSeconds: 210,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Servis et',
      instruction: 'Tavayı doğrudan masaya getir. İstersen üzerine ekstra pul biber ve taze maydanoz serp.',
      sensoryCue: 'Tavanın dibi hâlâ hafifçe cızırdıyor ve peynir uzayan teller yapıyor olmalı.',
      chefTip: 'Yanında turşu veya ayran gider; yağlı lezzeti dengeler.',
    ),
  ],
);
