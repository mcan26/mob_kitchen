import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCarbonara = Recipe(
  id: 'mob_classic_002',
  title: 'Kremasız Gerçek Carbonara',
  subtitle: 'Krema yok, sır yumurta ve makarna suyunda. 20 dakikada ipeksi sos.',
  category: RecipeCategory.pasta,
  prepTimeMinutes: 5,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 780, proteinG: 38, carbsG: 78, fatG: 34),
  tags: ['makarna', '20 dakika', 'krema yok', 'klasik', 'yumurtalı'],
  chefGoldenRules: [
    'Yumurtalı sosu asla ocakta karıştırma: tava ocaktan inmiş ve 1 dakika dinlenmiş olmalı, yoksa sos omlete döner.',
    'Makarna suyunu dökmeden önce bir su bardağı ayır; sosu bağlayan ve ipeksi yapan şey budur.',
    'Baconı soğuk tavada başlat; yağ yavaş erisin, et yanmadan çıtırlaşsın.',
  ],
  storageAndReheatingTip:
      'Carbonara en iyi hemen yenir. Artarsa buzdolabında 1 gün saklayabilirsin; tavada 2-3 yemek kaşığı su ile çok kısık ateşte, sürekli karıştırarak ısıt. Mikrodalga yumurtayı pişirip sosu lastikleştirir.',
  ingredients: [
    RecipeIngredient(
      name: 'Spagetti',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Bronz kalıp (bronze die) yazanı seç; pürüzlü yüzey sosu tutar. Uzun, düz ve kırık içermeyen paketi al.',
      substituteOption: 'Rigatoni veya linguine; kısa makarnada da sos iyi tutunur.',
    ),
    RecipeIngredient(
      name: 'Füme dana bacon (kalın dilim)',
      amount: 120,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: '1 cm\'lik çubuklar halinde doğranmış',
      buyingTip:
          'Kalın dilimli ve görünür yağ şeritleri olanı seç; aşırı ince dilimli bacon kavrulunca kurur ve yağ salmaz.',
      substituteOption:
          'Guanciale veya pancetta bulursan orijinal tadı olur. Bulamazsan kasaptan kalın dilim füme dana kaburga/antrikot pastırma al.',
    ),
    RecipeIngredient(
      name: 'Yumurta',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Kabuğunda çatlak olmayan, serbest dolaşan (kod 0 veya 1) yumurta seç; oda sıcaklığında kullan.',
    ),
    RecipeIngredient(
      name: 'Yumurta sarısı',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Ekstra sarı yumurtalar için de normal yumurta alıp beyazını ayır. Kalan beyazları omlet veya protein kahvaltısı için sakla.',
      substituteOption: 'Sarı yerine bir tam yumurta daha kullanabilirsin; sos biraz daha az zengin olur.',
    ),
    RecipeIngredient(
      name: 'Pecorino Romano veya Parmesan',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'ince rendelenmiş',
      buyingTip:
          'Etikette "Pecorino Romano" veya "Parmigiano Reggiano" yazan blok peyniri al; "parmesan tipi" yazanlar genelde nişastalı ve sosa uygun değil.',
      substituteOption: 'Eski kaşar rendesi + fazladan yarım çay kaşığı karabiber.',
    ),
    RecipeIngredient(
      name: 'Karabiber (taze çekilmiş)',
      amount: 1.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Bütün tane karabiber al, makarna hazırken değirmende çek; öğütülmüş olanın aroması çoktan uçmuştur.',
    ),
    RecipeIngredient(
      name: 'Kaya tuzu (makarna suyu için)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'İri taneli kaya tuzu makarna suyuna yeter; baconlar zaten tuzlu olduğundan sosa ayrıca tuz ekleme.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Yumurtalı sosu hazırla',
      instruction:
          'Büyük bir kasede yumurtaları, sarıları, peynirin yarısını ve karabiberi çırp. Kalan peyniri servis için ayır. Bu karışımı bir kenarda oda sıcaklığında beklet.',
      sensoryCue: 'Karışım yoğurt kıvamında, kaşıktan şerit halinde akmalı ve rengi açık sarı olmalı.',
      chefTip:
          'Neden ocağın yanında değil de kasede? Yumurta 70°C civarında topaklanır. Sosu ocaktan uzak hazırlamak, ısıyı kontrol etmeni sağlar.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Baconı soğuk tavada kavur',
      instruction:
          'Baconları soğuk, geniş bir tavaya koy. Orta-kısık ateşte 6-8 dakika kavur; yağı erirken ara sıra karıştır. Ocağı kapat, tavayı yağıyla birlikte kenara al.',
      sensoryCue:
          'Yağın büyük kısmı erimiş, bacon parçalarının kenarları cam gibi sert ve çıtır olmalı. Tavanın dibinde altın rengi yağ gölü görülmeli.',
      chefTip:
          'Neden soğuk tavada başlıyoruz? Yüksek ısı dışını yakar, içi yağlı kalır. Soğuktan başlamak yağın yavaşça erimesini ve et lifinin çıtırlaşmasını sağlar. Bu yağ sosun lezzet bazı olacak.',
      timerSeconds: 420,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Makarnayı haşla, suyundan ayır',
      instruction:
          'En az 2 litre suyu kaynat, kaya tuzunu ekle. Spagettiyi paket süresinden 1 dakika önce çıkaracak şekilde pişir (yaklaşık 8-9 dakika). Süzmeden önce 1 su bardağı makarna suyu ayır.',
      sensoryCue:
          'Bir tel çıkar ve ısır: ortasında kıl inceliğinde beyaz çizgi kalmalı (al dente). Su bulanık ve sütlü görünüyorsa nişasta tamam demektir.',
      chefTip:
          'Neden makarna suyunu ayırıyoruz? Nişastalı su, yumurta ile yağı birbirine bağlayan emülsiyonun anahtarıdır. Bu su olmadan sos kuru ve yapışkan olur.',
      timerSeconds: 480,
      mistakeWarning: 'Suyu süzerken ayırmayı unutma! Süzgece dökmeden önce bir bardağı mutlaka al.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Ocaktan uzakta birleştir',
      instruction:
          'Süzülmüş makarnayı bacon yağının olduğu tavaya at (ocak kapalı) ve 1 dakika bekle. Sonra yumurta karışımını dök, 3-4 yemek kaşığı makarna suyunu ekle ve hızlıca, sürekli karıştır.',
      sensoryCue:
          'Sos parlak, ipeksi ve makarnayı sarar halde olmalı; tavada kremaya benzer akışkan bir kıvam. Hiç topak olmamalı.',
      chefTip:
          'Tavanın artık ısısı yumurtayı yarı pişirmeye yeter. Tavaya elini yaklaştırdığında sıcak ama yakmıyorsa doğru sıcaklıktasın. Sos koyulaşmazsa 1-2 yemek kaşığı daha makarna suyu ekle.',
      timerSeconds: 60,
      mistakeWarning:
          'Sos topaklanıp kesilirse hemen 2 yemek kaşığı soğumuş makarna suyu ekle ve hızla çırparak toparla.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Servis et',
      instruction: 'Hemen tabaklara al; ayırdığın peynir ve taze çekilmiş karabiberle servis et.',
      sensoryCue: 'Tabaktaki sos akışkan ve parlak, kenarda su toplamıyor olmalı.',
      chefTip: 'Carbonara beklemeyi sevmez. Tabakları önceden ısıtırsan sos daha uzun süre akışkan kalır.',
    ),
  ],
);
