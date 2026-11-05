import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobLemonTunaPasta = Recipe(
  id: 'mob_classic_008',
  title: 'Zesty Mediterranean Lemon & Garlic Tuna Spaghetti',
  subtitle: 'A pantry-staple dinner in 15 minutes: bright lemon zest, olive oil tuna, sweet garlic, and fresh parsley.',
  category: RecipeCategory.highProtein,
  prepTimeMinutes: 5,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 640, proteinG: 42, carbsG: 79, fatG: 17),
  tags: ['High-Protein', '15-Minute', 'Pantry Staple', 'Canned Tuna', 'Budget-Friendly', 'Pasta'],
  chefGoldenRules: [
    'Always reserve a mug of starchy pasta water before draining: emulsifying it with olive oil creates a silky glossy glaze without cream.',
    'Zest only the outermost yellow citrus skin; the spongy white pith beneath is bitter.',
    'Fold in the tuna off the heat; further cooking canned tuna makes it dry, chalky, and overly fishy.',
  ],
  storageAndReheatingTip:
      'Keeps in the fridge for up to 2 days; also delicious cold as a chilled pasta salad. To reheat warm, toss in a skillet over low heat with 2 tbsp water for 90 seconds.',
  ingredients: [
    RecipeIngredient(
      name: 'Spaghetti',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Look for bronze-cut extruded pasta (trafilata al bronzo); its chalky, coarse surface grips olive oil emulsified sauces.',
      substituteOption: 'Linguine, bucatini, or penne rigate.',
    ),
    RecipeIngredient(
      name: 'Canned tuna in olive oil',
      amount: 2,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'flaked gently with its oil reserved',
      buyingTip: 'Choose solid yellowfin or albacore fillets packed in olive oil rather than shredded water-packed flakes; retain the flavorful oil.',
      substituteOption: 'Canned wild salmon, canned sardines in oil, or drained chickpeas for a plant-based twist.',
    ),
    RecipeIngredient(
      name: 'Fresh unwaxed lemon',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'zested and juiced',
      buyingTip: 'Select organic or untreated unwaxed lemons with heavy weight and fragrant, unblemished skin.',
      substituteOption: '2 tbsp white wine vinegar or capers (though missing fresh citrus peel perfume).',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'thinly sliced',
      buyingTip: 'Choose firm heads with tight skins; avoid soft cloves with bitter green interior sprouts.',
    ),
    RecipeIngredient(
      name: 'Fresh flat-leaf parsley',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely chopped',
      buyingTip: 'Crisp, vibrant green leaves with sturdy, fragrant stems; pass on wilted or slimy bunches.',
      substituteOption: 'Fresh dill or baby arugula leaves.',
    ),
    RecipeIngredient(
      name: 'Extra virgin olive oil',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Use a high-quality fragrant cold-pressed extra virgin olive oil as it forms the backbone of the sauce.',
    ),
    RecipeIngredient(
      name: 'Red pepper flakes',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Vibrant red flakes ensure a warm, gentle heat that cuts through rich olive oil.',
    ),
    RecipeIngredient(
      name: 'Coarse sea salt (for pasta water)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Freshly cracked black pepper',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Boil pasta & save starchy water',
      instruction:
          'Bring a large pot of water to a rolling boil, add coarse sea salt, and cook spaghetti 1 minute shy of package instructions (about 8-9 minutes). Scoop out 1 mug of cloudy cooking water before draining.',
      sensoryCue: 'Spaghetti has a tiny white dot in its cross-section when bitten (al dente); water looks cloudy and starchy.',
      chefTip: 'Starchy pasta water is the culinary glue that marries olive oil and lemon juice into an emulsion.',
      timerSeconds: 510,
      mistakeWarning: 'Always scoop out the pasta water before draining down the sink!',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Gently infuse garlic & chili oil',
      instruction:
          'While pasta cooks, place extra virgin olive oil in a wide skillet over gentle low heat. Add sliced garlic and chili flakes; heat for 1-2 minutes until garlic softens.',
      sensoryCue: 'Garlic sizzles very gently, perfuming the kitchen without browning; edges turn pale blonde, never dark brown.',
      chefTip: 'Why low heat? Infusing gently draws garlic essence into the oil; high heat fries and turns garlic unpleasantly bitter in seconds.',
      timerSeconds: 90,
      mistakeWarning: 'If garlic turns brown, discard and start fresh; burnt garlic ruins seafood pasta.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Emulsify pasta with cooking water',
      instruction:
          'Transfer drained spaghetti directly into the garlic oil skillet. Pour in half the lemon juice and 4-5 tablespoons of reserved hot pasta water. Increase heat to medium and swirl vigorously for 60 seconds.',
      sensoryCue: 'The liquid thickens into a glossy, creamy sheen clinging tightly to every noodle with no watery separation.',
      chefTip: 'Agitation and rapid swirling force the starch molecules and fats to bond into a velvety coating.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Fold in tuna, lemon zest & herbs',
      instruction:
          'Kill the heat completely. Tip in the flaked tuna with its oil, lemon zest, fresh chopped parsley, and cracked black pepper. Gently fold with tongs, keeping tuna in substantial tender flakes.',
      sensoryCue: 'Tuna remains in succulent chunks and the bright perfume of lemon zest and green parsley rises in the steam.',
      chefTip: 'Why off the heat? Canned tuna is already pre-cooked. Residual skillet heat warms it gently without drying the fibers.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Taste, balance & twirl',
      instruction:
          'Taste a noodle: adjust with remaining lemon juice for brightness, or another splash of pasta water if too dry. Twirl onto warm shallow bowls.',
      sensoryCue: 'Sauce is tart, savory, glossy, and subtly peppery; each bite balances flaky tuna with citrus warmth.',
      chefTip: 'Leave extra salt to the very end; canned tuna and salted pasta water usually provide ample seasoning.',
    ),
  ],
);
