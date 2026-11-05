import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobArrabbiataCrispyBreadcrumb = Recipe(
  id: 'mob_classic_009',
  title: 'Fiery Penne Arrabbiata with Garlic Breadcrumbs',
  subtitle: 'Rich spicy tomato sauce, infused garlic chili oil, and toasted olive oil sourdough breadcrumbs.',
  category: RecipeCategory.pasta,
  prepTimeMinutes: 5,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 620, proteinG: 19, carbsG: 99, fatG: 16),
  tags: ['Budget-Friendly', 'Vegetarian', 'Vegan-Friendly', 'Spicy', 'Pasta'],
  chefGoldenRules: [
    'Warm sliced garlic and red pepper flakes slowly in olive oil so chili warmth and garlic sweetness infuse the fat evenly.',
    'Simmer the tomato sauce uncovered for at least 10 minutes to boil away excess water and concentrate natural tomato sugars.',
    'Toast coarse breadcrumbs separately in olive oil and garlic; scattering them just before eating preserves an irresistible crunch.',
  ],
  storageAndReheatingTip:
      'Arrabbiata sauce keeps in the fridge for up to 5 days, or freezes for 3 months; flavors deepen on day two. Store toasted breadcrumbs separately at room temperature so they remain crisp.',
  ingredients: [
    RecipeIngredient(
      name: 'Penne rigate',
      amount: 220,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Select bronze-die extruded penne rigate; ridges and rough matte texture grip thick tomato sauces.',
      substituteOption: 'Rigatoni, fusilli, or spaghetti.',
    ),
    RecipeIngredient(
      name: 'Crushed canned Italian tomatoes',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Look for whole peeled plum tomatoes (San Marzano style) or crushed pulp with no added calcium chloride or sugars.',
      substituteOption: '5 ripe summer vine tomatoes, grated on a box grater.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: '3 cloves thinly sliced, 1 clove finely minced for breadcrumbs',
      buyingTip: 'Heavy, firm cloves with dry paper skin; avoid garlic with green bitter inner sprouts.',
    ),
    RecipeIngredient(
      name: 'Red chili flakes',
      amount: 2,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Bright ruby-red chili flakes indicate freshness and lively heat; start with 1 tsp if heat-sensitive.',
      substituteOption: '1 fresh red bird\'s eye chili, thinly sliced, or Calabrian chili paste.',
    ),
    RecipeIngredient(
      name: 'Coarse breadcrumbs or panko',
      amount: 4,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Panko or coarse artisan sourdough breadcrumbs toast into airy, crunchy shards.',
      substituteOption: 'Stale crusty bread grated coarsely on a box grater.',
    ),
    RecipeIngredient(
      name: 'Extra virgin olive oil',
      amount: 4,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Use fruit-forward, cold-pressed olive oil for authentic Italian aroma.',
    ),
    RecipeIngredient(
      name: 'Dried oregano',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      substituteOption: 'Dried basil or Italian herb seasoning blend.',
    ),
    RecipeIngredient(
      name: 'Granulated sugar',
      amount: 1,
      unit: MeasurementUnit.pinch,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Just a tiny pinch to soften raw tomato acidity if canned tomatoes are sharp.',
      substituteOption: 'Finely grated sweet carrot.',
    ),
    RecipeIngredient(
      name: 'Coarse sea salt (for pasta water)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Fine sea salt',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Fresh flat-leaf parsley',
      amount: 0.25,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely chopped',
      buyingTip: 'Crisp green leaves and tender aromatic stems.',
      substituteOption: 'Fresh torn basil leaves.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Toast the garlic breadcrumbs',
      instruction:
          'In a small skillet, heat 2 tablespoons of olive oil over medium heat. Add the 1 minced garlic clove and coarse breadcrumbs; toast, stirring constantly, for 2-3 minutes until deep golden. Tip into a small bowl to halt cooking.',
      sensoryCue: 'Breadcrumbs turn fragrant, deep golden-amber, and crisp with a toasted nut aroma.',
      chefTip: 'Why toast separately? If breadcrumbs touch wet sauce directly, they turn soggy immediately. Toasted separately, they stay delightfully crunchy.',
      timerSeconds: 150,
      mistakeWarning: 'Stay attentive! Breadcrumbs can scorch in 10 seconds if left unmonitored.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Bloom garlic & chili in olive oil',
      instruction:
          'In a wide skillet, add the remaining 2 tablespoons of olive oil, sliced garlic, and chili flakes. Warm over medium-low heat for 1-2 minutes until garlic softens.',
      sensoryCue: 'The olive oil turns shimmering reddish-orange and sliced garlic edges curl into pale gold with fragrant heat.',
      chefTip: 'Capsaicin is fat-soluble: blooming chili in warm oil spreads the fiery heat smoothly throughout every bite of sauce.',
      timerSeconds: 90,
      mistakeWarning: 'Pour in the tomatoes immediately once garlic edges color; burnt garlic turns the entire sauce bitter.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Simmer the arrabbiata sauce',
      instruction:
          'Stir in crushed tomatoes, oregano, salt, and a pinch of sugar. Simmer uncovered over medium heat for 10-12 minutes, stirring occasionally.',
      sensoryCue: 'The sauce reduces, turns glossy and dark garnet red, leaving a clean trail when dragging a wooden spoon across the pan bottom.',
      chefTip: 'Why keep the lid off? Escaping steam reduces watery tomato juice into an intensely sweet, clingy sauce.',
      timerSeconds: 660,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Cook penne al dente',
      instruction:
          'While the sauce simmers, drop penne into a large pot of boiling salted water. Cook 1 minute less than package instructions. Reserve 1/2 cup of hot pasta water before draining.',
      sensoryCue: 'Penne retains a firm bite in the center core (al dente); water looks milky and starchy.',
      chefTip: 'Removing the pasta 1 minute early ensures it finishes cooking directly inside the hot sauce without turning limp.',
      timerSeconds: 600,
      mistakeWarning: 'Always save hot pasta water before tipping into the colander!',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Toss penne into the spicy sauce',
      instruction:
          'Add drained penne to the arrabbiata sauce. Splash in 3-4 tablespoons of reserved pasta water and toss briskly over medium heat for 60 seconds.',
      sensoryCue: 'The spicy sauce clings intimately to every penne ridge; no pool of liquid sits loose in the skillet bottom.',
      chefTip: 'Starch in the pasta water emulsifies with the tomato olive oil, creating a cohesive clinging texture.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Crown with crunchy breadcrumbs',
      instruction:
          'Divide between two bowls. Scatter generously with the golden garlic breadcrumbs and chopped fresh parsley. Drizzle with a final whisper of olive oil and serve immediately.',
      sensoryCue: 'A loud crunch greets the first forkful as the toasted breadcrumbs meet the velvety spicy pasta.',
      chefTip: 'Sprinkle breadcrumbs right at the table so every bite preserves its crunchy texture.',
    ),
  ],
);
