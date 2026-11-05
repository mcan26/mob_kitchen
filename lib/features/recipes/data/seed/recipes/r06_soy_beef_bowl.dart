import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSoyGarlicBeefBowl = Recipe(
  id: 'mob_classic_006',
  title: 'Soya-Sarımsaklı Kıymalı Pirinç Bowl + Yumurta',
  subtitle: 'Tatlı-tuzlu kıyma, çıtır kenarlı yumurta ve ferah salatalık. 15 dakikalık akşam yemeği.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 5,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 735, proteinG: 46, carbsG: 74, fatG: 28),
  tags: ['15 dakika', 'kıyma', 'asya', 'bowl', 'pratik'],
  chefGoldenRules: [
    'Kıymayı tavaya koyduktan sonra ilk 2 dakika dokunma; kıyma suyunu salmadan önce kızarıp kabuk bağlasın.',
    'Soya sosu zaten tuzludur; önce sosu ekle, sonra tadına bak, en son tuz gerekirse ilave et.',
    'Pirinci önceden pişir ya da dünden kalan pirinci kullan: soğumuş pirinç bowl\'da daha dağınık ve lezzetli kalır.',
  ],
  storageAndReheatingTip:
      'Kıymalı karışım buzdolabında kapalı kapta 4 gün, dondurucuda 2 ay saklanır. Isıtırken tavada 1-2 yemek kaşığı su ile kısık ateşte, ya da mikrodalgada 2 dakika. Yumurtayı her seferinde taze pişir.',
  ingredients: [
    RecipeIngredient(
      name: 'Dana kıyma (az yağlı)',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      buyingTip: 'Kasaptan "sade, az yağlı (%10-15)" iste ve gözünün önünde çektir; paketlenmiş kıymada yüzey grileşmişse sakın alma.',
      substituteOption: 'Tavuk veya hindi kıyma; yağ az olduğundan 1 yemek kaşığı ekstra yağ ekle.',
    ),
    RecipeIngredient(
      name: 'Pilav pirinci',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Orta taneli (baldo veya osmancık) pirinç seç; Asya yemeklerinde hafif yapışkan doku iyi gider.',
      substituteOption: 'Basmati veya bulgur pilavı.',
    ),
    RecipeIngredient(
      name: 'Light soya sosu',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Koyu (dark) değil, düşük sodyumlu "light" soya sosunu al; koyu soya renk içindir ve tadı çok yoğundur. İçeriğinde sadece soya, buğday, su, tuz yazanı seç.',
      substituteOption: 'Tamari (glütensiz) veya 2 yemek kaşığı Worcestershire sosu + 1 yemek kaşığı su.',
    ),
    RecipeIngredient(
      name: 'Bal',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Süzme çiçek balı yeter; şeker şurubu karıştırılmış "bal ürünü" yazanlardan kaçın, sos karamelize olmaz.',
      substituteOption: 'Esmer şeker (1 yemek kaşığı) veya pekmez.',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince kıyılmış',
    ),
    RecipeIngredient(
      name: 'Taze zencefil',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'rendelenmiş',
      buyingTip: 'Kabuğu pürüzsüz, sert ve parlak olanı seç; buruşuksa kurumuştur. Küçük bir parça yeter, kalanını dondurucuya at.',
      substituteOption: '¼ çay kaşığı zencefil tozu.',
    ),
    RecipeIngredient(
      name: 'Taze soğan',
      amount: 3,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince halkalar halinde, beyaz ve yeşil kısımları ayrı',
      buyingTip: 'Yeşil kısımları dik ve canlı, beyaz kısmı sert olanı seç.',
    ),
    RecipeIngredient(
      name: 'Salatalık',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince dilimlenmiş',
      buyingTip: 'Sert, ince kabuklu, ucu yumuşamamış salatalık seç.',
    ),
    RecipeIngredient(
      name: 'Yumurta',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
    ),
    RecipeIngredient(
      name: 'Susam',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Kavrulmuş susam al ya da kuru tavada 1 dakika kendin kavur.',
      substituteOption: 'Kuru çıtır soğan veya ezilmiş fıstık.',
    ),
    RecipeIngredient(
      name: 'Pul biber',
      amount: 0.5,
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
      title: 'Pirinci pişir',
      instruction:
          'Pirinci yıkayıp 1,5 katı suyla ve bir tutam tuzla kapağı kapalı, en kısık ateşte 12 dakika pişir. Ocağı kapatıp kapağı açmadan dinlendir. (Hazır pişmiş pirinç varsa bu adımı atla.)',
      sensoryCue: 'Tencerede su kalmamış, taneler birbirinden ayrışıyor ve yüzeyde küçük buhar delikleri var.',
      chefTip: 'Pirinci yıkamak yüzeydeki nişastayı alır; yoksa tencere dibine yapışır ve lapa olur.',
      timerSeconds: 720,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Soyalı sosu hazırla',
      instruction: 'Küçük bir kasede soya sosu, bal, rendelenmiş zencefil ve pul biberi karıştır.',
      sensoryCue: 'Bal tamamen çözünmüş ve sos tek renkte, parlak görünmeli.',
      chefTip: 'Sosu önceden hazırlamak şart: kıyma tavada pişerken sosu ölçmeye vaktin olmaz ve sarımsak yanar.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Kıymayı kızart',
      instruction:
          'Geniş bir tavayı yüksek ateşte 2 dakika ısıt, yağı ve kıymayı ekle. Büyük parçalar halinde yayıp 2 dakika dokunma, sonra kaşıkla parçala ve 4 dakika daha pişir.',
      sensoryCue:
          'Kıyma altın-kahverengi, kenarları çıtır ve tavada artık su yok, sadece yağ cızırdıyor olmalı. Su görüyorsan daha pişirmeye devam.',
      chefTip:
          'Neden dokunmuyoruz? Kıymanın yüzeyi tavayla temas ettikçe kahverengileşir (Maillard). Hemen karıştırırsan kıyma suyunu salar ve haşlanır.',
      timerSeconds: 360,
      mistakeWarning: 'Tava kalabalıksa kıymayı iki seferde pişir; aksi halde buharda kalır.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Sarımsak ve sosu ekle',
      instruction:
          'Ateşi orta seviyeye al. Sarımsağı ve taze soğanın beyaz kısmını ekle, 30 saniye karıştır. Sosu dök ve 1-2 dakika, sos kıymaya yapışana kadar pişir.',
      sensoryCue: 'Sos kıymayı kaplamış ve tavanın dibinde koyu bir cila oluşmuş olmalı; tatlı-karamelize bir koku gelir.',
      chefTip:
          'Neden sarımsağı sonda ekliyoruz? 30 saniyede yanar ve acılaşır; kıyma pişerken yüksek ısıda tavada kalırsa sarımsak yanardı.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Çıtır kenarlı yumurta',
      instruction:
          'Başka bir tavada 1 çay kaşığı yağı yüksek ateşte ısıt, yumurtaları kır; 2 dakika kapak kapalı pişir.',
      sensoryCue: 'Beyazlar donmuş ve kenarları kahverengi, çıtır dantelli görünür; sarısı parlak ve akışkan kalır.',
      chefTip:
          'Neden yüksek ateş? Kısık ateşte yumurta lastik gibi ve yağda yüzer; yüksek ısıda hızlıca kızarır ve kenarı çıtır olur.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Kaseyi kur',
      instruction:
          'Pirinci kaselere paylaştır; üzerine kıymayı, salatalık dilimlerini ve yumurtayı yerleştir. Susam ve taze soğanın yeşil kısmıyla süsle.',
      sensoryCue: 'Sıcak kıyma ve pirinç, soğuk salatalığın yanında; hepsi tek lokmada birleşecek şekilde dengelenmiş olmalı.',
      chefTip: 'Yumurta sarısını kes ve pirince karıştır: kendi sosunu yapar, ekstra sosa gerek kalmaz.',
    ),
  ],
);
