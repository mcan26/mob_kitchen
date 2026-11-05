import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCreamyGarlicChickenPasta = Recipe(
  id: 'mob_classic_001',
  title: 'One-Pan Creamy Garlic Chicken Penne',
  subtitle: 'Pasta cooks right in the sauce and chicken fond. 30 minutes with one single pan to wash.',
  category: RecipeCategory.onePot,
  prepTimeMinutes: 10,
  cookTimeMinutes: 25,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 745, proteinG: 52, carbsG: 72, fatG: 26),
  tags: ['one-pan', 'chicken', 'pasta', 'creamy', 'weeknight'],
  chefGoldenRules: [
    'Pat chicken completely dry before searing in a hot skillet; otherwise it steams instead of forming a Maillard crust.',
    'Scrape all caramelized brown fond from the bottom when adding stock: that is where the deep pan sauce flavor lives.',
    'Kill the heat before adding grated parmesan and cream; boiling dairy separates and turns oily or grainy.',
  ],
  storageAndReheatingTip:
      'Stores airtight in the fridge for up to 3 days. Reheat gently in a skillet over low heat with 2-3 tbsp milk or water to revive the emulsified sauce.',
  ingredients: [
    RecipeIngredient(
      name: 'Boneless skinless chicken thighs',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'cut into 2 cm bite-sized pieces',
      buyingTip:
          'Choose thighs over breast for higher moisture retention and rich flavor under high skillet heat.',
      substituteOption:
          'Chicken breast works too, but reduce cook time by 2 minutes to prevent dryness.',
    ),
    RecipeIngredient(
      name: 'Penne rigate',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip:
          'Pick bronze-die extruded pasta: the textured surface catches sauce and releases starch naturally.',
      substituteOption: 'Fusilli, rigatoni, or farfalle.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'thinly sliced',
      buyingTip: 'Pick firm, heavy heads with tight paper skins. Avoid sprouted green cloves.',
      substituteOption: '1 tsp garlic powder in a pinch.',
    ),
    RecipeIngredient(
      name: 'Yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely diced',
      buyingTip: 'Firm with dry, papery outer skin and no soft spots around the stem.',
      substituteOption: '3 shallots or 4 spring onions (white parts).',
    ),
    RecipeIngredient(
      name: 'Low-sodium chicken stock',
      amount: 400,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip:
          'Always use low-sodium stock because reduction concentrates the salt content dramatically.',
      substituteOption: '400 ml hot water + half a chicken bouillon cube.',
    ),
    RecipeIngredient(
      name: 'Heavy cooking cream',
      amount: 100,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Select fresh dairy cream with at least 30-36% milk fat for stable emulsification.',
      substituteOption: '3 tbsp crème fraîche or whole milk with 1 tbsp butter.',
    ),
    RecipeIngredient(
      name: 'Parmigiano Reggiano',
      amount: 40,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'finely grated',
      buyingTip:
          'Buy a whole wedge and grate it fresh; pre-shredded cheese contains anti-caking starches that ruin emulsion.',
      substituteOption: 'Pecorino Romano or mature Grana Padano.',
    ),
    RecipeIngredient(
      name: 'Smoked sweet paprika',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Look for Spanish pimentón dulce for subtle woodsmoke aroma without bitter heat.',
      substituteOption: 'Regular sweet paprika plus a pinch of ground cumin.',
    ),
    RecipeIngredient(
      name: 'Olive oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Use standard olive oil for searing rather than extra virgin, which burns at high skillet temps.',
      substituteOption: 'Neutral vegetable oil or avocado oil.',
    ),
    RecipeIngredient(
      name: 'Sea salt',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Black pepper',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Use freshly cracked whole peppercorns for pungent aroma.',
    ),
    RecipeIngredient(
      name: 'Fresh flat-leaf parsley',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely chopped',
      buyingTip: 'Vibrant green, crisp upright stems with no yellow wilted leaves.',
      substituteOption: 'Fresh basil or chives.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Dry and season chicken',
      instruction:
          'Pat chicken thigh pieces thoroughly dry using paper towels. Transfer to a bowl; toss with salt, black pepper, and smoked paprika until evenly coated.',
      sensoryCue: 'Chicken surface should look matte rather than wet and slimy.',
      chefTip:
          'Moisture creates steam in hot oil, which cools the pan and boils the meat instead of searing a golden Maillard crust.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sear the chicken',
      instruction:
          'Heat olive oil in a wide deep skillet over medium-high heat for 2 minutes. Lay chicken pieces in a single layer and sear undisturbed for 4 minutes. Flip and sear 2 more minutes, then transfer to a plate.',
      sensoryCue:
          'You should hear an aggressive sizzle immediately. Chicken releases easily from the pan when deeply golden brown.',
      chefTip:
          'Do not overcrowd the skillet or stir constantly. The dark fond sticking to the bottom will form the bedrock of your pasta sauce.',
      timerSeconds: 240,
      mistakeWarning: 'If the chicken is sticking stubbornly, it is not ready to flip yet. Give it another 30 seconds.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Aromatics in the pan',
      instruction:
          'Lower heat to medium. Add diced onion to the residual skillet juices and sauté for 3 minutes until softened. Stir in sliced garlic for 30 seconds.',
      sensoryCue:
          'Onions turn translucent and sweet-smelling. Garlic turns fragrant and pale golden; do not let it brown.',
      chefTip:
          'Garlic burns in under a minute and becomes acrid, so always let the onions soften first before garlic touches the hot pan.',
      timerSeconds: 180,
      mistakeWarning: 'If garlic starts to brown too quickly, pour in stock immediately to halt the cooking.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Deglaze and simmer pasta',
      instruction:
          'Pour in chicken stock and 200 ml hot water. Vigorously scrape all brown bits off the pan bottom with a wooden spoon. Add penne, bring to a boil, cover with lid, and simmer on medium-low for 10-11 minutes, stirring every 3 minutes.',
      sensoryCue:
          'Liquid reduces by three-quarters and turns glossy as pasta turns al dente with a firm bite at the center.',
      chefTip:
          'Cooking pasta directly in stock traps its natural starches right in the skillet, thickening the sauce without any flour or cornstarch.',
      timerSeconds: 600,
      mistakeWarning: 'If liquid evaporates too fast before penne is tender, splash in 50 ml of warm water.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Fold chicken, cream, and parmesan',
      instruction:
          'Turn heat to the absolute lowest setting. Return seared chicken and resting juices back to the skillet, pour in heavy cream, and stir for 1 minute. Turn off the heat entirely, then fold in grated parmesan until velvety.',
      sensoryCue:
          'Sauce clings seamlessly to the ridges of the penne with a mirror-like sheen and no separated oil droplets.',
      chefTip:
          'Cheese proteins contract and break above 70°C, turning sauces oily. The residual pan heat is plenty to melt fresh parmesan smoothly.',
      timerSeconds: 90,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Rest and garnish',
      instruction:
          'Cover the skillet off the heat and let rest for 2 minutes. Shower with chopped fresh parsley and extra cracked black pepper before serving.',
      sensoryCue:
          'During resting, the sauce settles into a luscious, clingy restaurant-style coat over every piece of pasta.',
      chefTip:
          'The 2-minute rest allows pasta starch to finish setting the sauce emulsion.',
      timerSeconds: 120,
    ),
  ],
);
