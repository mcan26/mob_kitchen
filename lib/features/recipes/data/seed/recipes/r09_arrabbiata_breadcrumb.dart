import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobArrabbiataCrispyBreadcrumb = Recipe(
  id: 'mob_classic_009',
  title: 'Penne Arrabbiata + Sarımsaklı Çıtır Galeta',
  subtitle: 'Acılı domates sosu, üstünde yağda kavrulmuş sarımsaklı galeta. Kasa dostu, etsiz ve doyurucu.',
  category: RecipeCategory.pasta,
  prepTimeMinutes: 5,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 620, proteinG: 19, carbsG: 99, fatG: 16),
  tags: ['bütçe dostu', 'vejetaryen', 'vegan uyumlu', 'acılı', 'makarna'],
  chefGoldenRules: [
    'Sarımsak ve pul biberi yağda yavaşça ısıt; acı ve aroma yağa geçer, sosun her yerine dağılır.',
    'Domates sosunu kapak açık ve en az 10 dakika pişir; ekşiliği gitsin, kıvamı oturan sos olsun.',
    'Galetayı yağ ve sarımsakla kuru tavada ayrıca kavur; sosa gelen çıtırlık ve "tuzlu" doku bu tarifin sırrıdır.',
  ],
  storageAndReheatingTip:
      'Sos buzdolabında 5 gün, dondurucuda 3 ay saklanır; ikinci gün daha lezzetli olur. Galetayı ayrı kapta, oda sıcaklığında sakla ve servis anında serp ki çıtır kalsın.',
  ingredients: [
    RecipeIngredient(
      name: 'Penne makarna',
      amount: 220,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Bronz kalıp (bronze die) yazanı seç; yüzeyi pürüzlü olduğundan sos tutar. "Rigate" (çizgili) penne tercih et.',
      substituteOption: 'Rigatoni, fusilli veya spagetti.',
    ),
    RecipeIngredient(
      name: 'Domates (rendelenmiş / konserve)',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'İçeriği sadece domates (ve belki tuz) olan konserveyi seç; "domates püresi" ile "rendelenmiş domates" farklıdır: rendelenmiş, parçacıklı olandır. Ucuzu da olur ama ilave şeker katılmış olmasın.',
      substituteOption: 'Sezonunda 5-6 olgun domatesi rendelemek; sezon dışıysa konserve daha lezzetlidir.',
    ),
    RecipeIngredient(
      name: 'Sarımsak',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince dilimlenmiş (galeta için 1 dişi ayır ve ince kıy)',
      buyingTip: 'Başı sert, kabuğu kuru ve ağır sarımsak seç; filizlenmişse acıdır.',
    ),
    RecipeIngredient(
      name: 'Pul biber (acı)',
      amount: 2,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Acı pul biber (Antep veya Maraş) seç; yağlı ve koyu kırmızı olan taze demektir. Acı sevmiyorsan 1 çay kaşığıyla başla.',
      substituteOption: 'Taze acı biber (1 adet, ince kıyılmış) veya biber salçası (1 yemek kaşığı).',
    ),
    RecipeIngredient(
      name: 'Galeta',
      amount: 4,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Panko (iri taneli) galeta en çıtırı olur; yoksa normal galeta veya bir gün önceki ekmeğin iç kısmını elinle ufala.',
      substituteOption: 'Bayat ekmeği rendele veya mutfak robotunda kır.',
    ),
    RecipeIngredient(
      name: 'Zeytinyağı',
      amount: 4,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Sos için riviera, galeta için de aynısı yeter; sızma yağı yüksek ısıda acılaşır.',
    ),
    RecipeIngredient(
      name: 'Kuru kekik',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      substituteOption: 'Kuru fesleğen veya İtalyan baharatı.',
    ),
    RecipeIngredient(
      name: 'Şeker',
      amount: 1,
      unit: MeasurementUnit.pinch,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Sadece domatesin ekşiliğini yumuşatmak için bir tutam yeter.',
      substituteOption: 'Küçük bir parça rendelenmiş havuç da aynı işi görür.',
    ),
    RecipeIngredient(
      name: 'Kaya tuzu (makarna suyu için)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Tuz',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Taze maydanoz',
      amount: 0.25,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'ince kıyılmış',
      buyingTip: 'Küçük bir demet yeter; yaprakları dik ve koyu yeşil olsun. Artığı doğranmış olarak dondurulabilir.',
      substituteOption: 'Taze fesleğen (varsa) veya sadece peynir.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Çıtır galetayı hazırla',
      instruction:
          'Küçük bir tavada 2 yemek kaşığı zeytinyağını orta ateşte ısıt. İnce kıyılmış 1 diş sarımsak ve galetayı ekle; sürekli karıştırarak 2-3 dakika kavur. Küçük bir kaseye al.',
      sensoryCue: 'Galeta altın-kahverengi, kuru ve gevrek görünmeli; ceviz gibi kavrulmuş bir koku gelir. Hâlâ yağlı ve yumuşaksa biraz daha kavur.',
      chefTip: 'Neden ayrı pişiriyoruz? Sosa doğrudan karışan galeta nemi emer ve yumuşar. Önce kavurup en sonda serpmek çıtırlığı korur.',
      timerSeconds: 150,
      mistakeWarning: 'Galeta saniyeler içinde yanar; başından ayrılma ve sürekli karıştır.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sarımsak ve acı biberi yağda ısıt',
      instruction:
          'Geniş bir tavaya 2 yemek kaşığı zeytinyağı, kalan dilimlenmiş sarımsak ve pul biberi koy. Orta-kısık ateşte 1-2 dakika ısıt.',
      sensoryCue: 'Yağ hafifçe kırmızıya dönmeli ve sarımsak kenarlarından altın rengi almaya başlamalı; acılı, tatlı bir koku gelir.',
      chefTip: 'Pul biberdeki acı ve renk bileşenleri yağda çözünür. Yağ onları tüm sosa taşıyan nakliyecidir; kuru eklersen acı tek lokmada çıkar.',
      timerSeconds: 90,
      mistakeWarning: 'Sarımsak koyulaşmadan hemen domatesi ekle; yanarsa acı olur.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Domates sosunu pişir',
      instruction:
          'Domatesi, kekik, tuz ve bir tutam şekeri ekle. Orta ateşte kapak açık, ara sıra karıştırarak 10-12 dakika pişir.',
      sensoryCue: 'Sos koyulaşmış, rengi canlı kırmızıdan derin kırmızıya dönmüş olmalı. Kaşıkla dibini sıyırınca birkaç saniye açık iz bırakır.',
      chefTip: 'Neden kapağı açık bırakıyoruz? Buharın kaçması sosu koyulaştırır ve domatesin çiğ ekşiliğini giderir; kapalı tencerede sulu ve ekşi kalır.',
      timerSeconds: 660,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Makarnayı haşla',
      instruction:
          'Sos kaynarken bol tuzlu suda penneyi paket süresinden 1 dakika kısa pişir. Süzmeden önce 1 çay bardağı makarna suyunu ayır.',
      sensoryCue: 'Penneyi ısırınca ortasında çok ince bir sert çizgi kalmalı (al dente).',
      chefTip: 'Makarnayı 1 dakika erken çıkarıyoruz çünkü sosla birlikte tavada pişmeye devam edecek.',
      timerSeconds: 600,
      mistakeWarning: 'Makarna suyunu ayırmayı unutma!',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Makarnayı sosla buluştur',
      instruction:
          'Süzülmüş makarnayı sosa ekle. Gerekirse 3-4 yemek kaşığı makarna suyu ilave edip 1 dakika ateşte karıştır.',
      sensoryCue: 'Sos makarnanın her yerine yapışmış, parlak ve kıvamlı olmalı. Tavanın dibinde sulu bir sos kalmamalı.',
      chefTip: 'Makarna suyundaki nişasta sosu makarnaya bağlar. Sosla birlikte 1 dakika ateşte karıştırmak, makarnanın sosu emmesini sağlar.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Galeta ile servis et',
      instruction: 'Tabaklara paylaştır. Kavrulmuş galetayı ve maydanozu bolca serp. İstersen üzerine bir çizgi sızma zeytinyağı gezdir.',
      sensoryCue: 'Galeta yüzeyde dağınık, gevrek ve sosla hafif temas ediyor olmalı; kaşıkla alınca "çıt" sesi gelmeli.',
      chefTip: 'Galetayı servis anında serp. 5 dakika bekleyince sosun nemini çeker ve yumuşar.',
    ),
  ],
);
