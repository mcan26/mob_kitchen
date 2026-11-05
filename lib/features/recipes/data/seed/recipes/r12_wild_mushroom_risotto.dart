import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobWildMushroomRisotto = Recipe(
  id: 'mob_classic_012',
  title: 'Creamy Thyme Wild Mushroom Risotto',
  subtitle: 'Arborio rice slowly simmered with golden garlic-thyme mushrooms, white wine, and aged parmesan.',
  category: RecipeCategory.onePot,
  prepTimeMinutes: 10,
  cookTimeMinutes: 25,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 610, proteinG: 18, carbsG: 78, fatG: 22),
  tags: ['One-Pan', 'Risotto', 'Vegetarian', 'Mushrooms', 'Italian Classic'],
  chefGoldenRules: [
    'Keep your vegetable broth hot on a back burner: adding cold stock drops the pan temperature and shocks the rice starch.',
    'Toast the raw Arborio grains in butter until translucent around the edges with a chalky center before adding any liquid (tostatura).',
    'Finish off the heat with cold butter and grated parmesan (mantecatura) vigorously beaten in for an ultra-velvety wave texture (all\'onda).',
  ],
  storageAndReheatingTip:
      'Risotto is best served immediately. Leftovers keep in the fridge for up to 3 days and make phenomenal crispy arancini (risotto balls) when rolled in breadcrumbs and pan-fried.',
  ingredients: [
    RecipeIngredient(
      name: 'Carnaroli or Arborio rice',
      amount: 180,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Look for Italian Carnaroli or Arborio; Carnaroli holds its bite best while releasing generous starch for a creamy sauce.',
      substituteOption: 'Vialone Nano or short-grain sushi rice in an emergency.',
    ),
    RecipeIngredient(
      name: 'Cremini or mixed wild mushrooms',
      amount: 250,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'sliced into bite-sized pieces',
      buyingTip: 'Choose firm, dry, earthy brown cremini, shiitake, or chanterelles; avoid slimy, damp, or blackened caps.',
      substituteOption: 'Portobello or button mushrooms.',
    ),
    RecipeIngredient(
      name: 'Shallot or small yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'very finely minced',
      buyingTip: 'Shallots provide delicate sweetness that doesn\'t overpower subtle mushroom notes.',
      substituteOption: 'Half a small sweet yellow onion.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 2,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely minced',
      buyingTip: 'Firm, fresh cloves without sprouting green cores.',
    ),
    RecipeIngredient(
      name: 'Dry white wine',
      amount: 80,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Use a crisp, dry white wine like Pinot Grigio or Sauvignon Blanc that you would enjoy drinking.',
      substituteOption: '1 tbsp lemon juice plus 70ml vegetable stock.',
    ),
    RecipeIngredient(
      name: 'Vegetable or chicken broth',
      amount: 750,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Low-sodium vegetable stock keeps seasoning controlled as liquid concentrates during reduction.',
    ),
    RecipeIngredient(
      name: 'Parmigiano-Reggiano or Grana Padano',
      amount: 50,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'freshly grated',
      buyingTip: 'Aged Parmigiano-Reggiano with stamped rind delivers crystalline savory crunch and deep umami.',
      substituteOption: 'Pecorino Romano or vegetarian Italian hard cheese.',
    ),
    RecipeIngredient(
      name: 'Unsalted butter',
      amount: 30,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'chilled and cubed',
      buyingTip: 'High-fat European-style butter lends a luxurious sheen and silken texture.',
    ),
    RecipeIngredient(
      name: 'Fresh thyme',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'sprigs, leaves stripped',
      buyingTip: 'Fragrant green sprigs that snap cleanly.',
      substituteOption: '1/2 tsp dried thyme.',
    ),
    RecipeIngredient(
      name: 'Extra virgin olive oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Salt and black pepper',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Warm broth & brown mushrooms',
      instruction:
          'Keep stock simmering on low heat in a small saucepan. In a wide skillet, heat olive oil with 10g butter over medium-high heat. Add mushrooms and thyme; sear undisturbed for 3 minutes, then toss for 3 more minutes until deep golden brown. Set half aside for garnish.',
      sensoryCue: 'Mushrooms release their water, sizzle into deep nutty mahogany, and perfume the air with earthy thyme.',
      chefTip: 'Do not salt mushrooms until they have browned; salting too early draws moisture out and causes them to stew rather than brown.',
      timerSeconds: 360,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sweat shallot & toast rice (Tostatura)',
      instruction:
          'Lower heat to medium. Add minced shallots and garlic to the remaining mushrooms in the skillet; cook for 2 minutes. Stir in raw Arborio rice and toast, stirring constantly, for 2 minutes until rice edges turn translucent.',
      sensoryCue: 'Rice grains make a faint crackling dry sound against the pan floor; an aroma reminiscent of toasted hazelnuts emerges.',
      chefTip: 'Toasting creates an outer protective barrier on the rice grain that prevents it from turning mushy while absorbing broth.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Deglaze with white wine',
      instruction:
          'Pour in white wine. Stir vigorously with a wooden spoon, scraping up any caramelized fond from the skillet floor, until the wine is almost fully absorbed.',
      sensoryCue: 'A loud hiss and burst of aromatic citrus steam rises; liquid quickly reduces to a glossy coating on the grains.',
      chefTip: 'Wine acidity cuts through the richness of butter and cheese, giving the risotto a balanced, vibrant finish.',
      timerSeconds: 90,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Simmer and ladle hot broth',
      instruction:
          'Add hot broth one ladle at a time, stirring frequently in a gentle figure-eight motion. Wait until each ladle is almost fully absorbed before adding the next. Continue for 16-18 minutes until rice is tender with a firm al dente heart.',
      sensoryCue: 'Broth simmers with gentle bubbles; liquid turns increasingly creamy, thick, and velvety as rice releases starch.',
      chefTip: 'Frequent stirring rubs rice grains against each other, releasing amylopectin starch to create natural sauce creaminess.',
      timerSeconds: 1020,
      mistakeWarning: 'Never drown the rice in all the broth at once; gradual addition is what develops luxurious creaminess.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Mantecatura & plate (All\'onda)',
      instruction:
          'Remove skillet completely from the heat. Vigorously beat in chilled butter cubes and grated parmesan until fully emulsified into a glossy wave (all\'onda). Spoon onto warm flat plates and crown with reserved browned mushrooms.',
      sensoryCue: 'The risotto ripples like a gentle wave when the plate is tapped on the counter; glossy, creamy, and fragrant.',
      chefTip: 'Emulsifying cold butter into hot risotto off the heat creates a stable, silky glaze without greasy separation.',
    ),
  ],
);
