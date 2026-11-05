import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobBurritoBowl = Recipe(
  id: 'mob_classic_004',
  title: 'High-Protein Chipotle Chicken Burrito Bowl',
  subtitle: 'Smoky spiced chicken thighs, black beans, zesty lime cilantro rice, and creamy garlic yogurt crema in 30 minutes.',
  category: RecipeCategory.bowl,
  prepTimeMinutes: 15,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 710, proteinG: 55, carbsG: 78, fatG: 17),
  tags: ['bowl', 'high-protein', 'meal-prep', 'stovetop', 'tex-mex'],
  chefGoldenRules: [
    'Rinse basmati rice under cold running water until clear to remove surface starch for fluffy, distinct grains.',
    'Bloom ground spices directly in warm oil before adding chicken to unlock fat-soluble aromatics.',
    'Assemble fresh toppings (avocado, pico de gallo) just before serving to preserve vibrant crunch and color.',
  ],
  storageAndReheatingTip:
      'Ideal for meal prep: chicken and rice keep airtight for 4 days. Keep fresh salsa and crema in separate containers. Warm rice and chicken with 1 tbsp water.',
  ingredients: [
    RecipeIngredient(
      name: 'Boneless skinless chicken thighs',
      amount: 350,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'sliced into bite-sized strips',
      buyingTip: 'Thigh meat sears with caramelized edges while staying juicy.',
      substituteOption: 'Chicken breast strips or lean ground beef.',
    ),
    RecipeIngredient(
      name: 'Basmati rice',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Aged long-grain basmati delivers the fluffiest, non-sticky rice grains.',
      substituteOption: 'Jasmine rice or brown rice.',
    ),
    RecipeIngredient(
      name: 'Black beans or kidney beans (canned)',
      amount: 1,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'drained and thoroughly rinsed',
      buyingTip: 'Look for no-salt-added beans with firm texture.',
      substituteOption: 'Pinto beans or chickpeas.',
    ),
    RecipeIngredient(
      name: 'Ripe avocado',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'sliced or cubed',
      buyingTip: 'Yields slightly to gentle thumb pressure without deep bruising; cap under stem should be green.',
      substituteOption: '2 tbsp guacamole or olive oil hummus.',
    ),
    RecipeIngredient(
      name: 'Roma tomatoes',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely diced for fresh salsa',
      buyingTip: 'Firm and deep crimson with rich tomato aroma.',
      substituteOption: 'Cherry tomatoes halved.',
    ),
    RecipeIngredient(
      name: 'Red onion',
      amount: 0.5,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely diced',
      buyingTip: 'Glossy purple skin with crisp layers.',
      substituteOption: 'Fresh scallions.',
    ),
    RecipeIngredient(
      name: 'Fresh lime',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      buyingTip: 'Thin-skinned limes that feel heavy for their size have the most juice.',
      substituteOption: 'Fresh lemon juice.',
    ),
    RecipeIngredient(
      name: 'Greek yogurt (0% or 2%)',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Strained Greek yogurt adds clean acidity and protein without heavy sour cream fat.',
      substituteOption: 'Sour cream or crème fraîche.',
    ),
    RecipeIngredient(
      name: 'Ground cumin',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Smoked paprika',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Olive oil',
      amount: 1.5,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Fresh cilantro / coriander',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'chopped',
      substituteOption: 'Flat parsley for cilantro-haters.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Cook fluffy lime rice',
      instruction:
          'Rinse basmati rice until water runs clear. Cook in 280 ml lightly salted water for 12 minutes covered, then remove from heat and let steam 5 minutes. Fluff with a fork and stir in lime zest and juice.',
      sensoryCue: 'Rice grains are long, fragrant, and separated without clumping.',
      chefTip:
          'Letting rice steam off the heat allows moisture to equilibrate, preventing mushy bottoms.',
      timerSeconds: 720,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Toss fresh pico de gallo',
      instruction:
          'In a small bowl, combine diced tomatoes, red onion, chopped cilantro, a squeeze of lime juice, and a pinch of sea salt. Let sit at room temperature.',
      sensoryCue: 'Salsa releases a small pool of seasoned sweet tomato nectar.',
      chefTip:
          'Salting tomatoes draws out liquid and intensifies natural sugars.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Sear smoky chipotle chicken',
      instruction:
          'Heat olive oil in a wide skillet over medium-high heat. Add ground cumin and smoked paprika for 20 seconds until fragrant. Add chicken strips and sear for 5-6 minutes until deeply caramelized and cooked through.',
      sensoryCue:
          'Aromatic spices sizzle and release toasted aromas. Chicken edges develop charred, crisp corners.',
      chefTip:
          'Blooming spices in hot oil dissolves their fat-soluble flavor compounds for ten times the aroma.',
      timerSeconds: 330,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Warm the spiced beans',
      instruction:
          'Push chicken to one side of the skillet. Pour in rinsed black beans, a pinch of cumin, and 2 tbsp water; simmer for 2 minutes to absorb the pan drippings.',
      sensoryCue: 'Beans heat through and glisten with seasoned chicken juices.',
      chefTip:
          'Warming beans in the same skillet saves dishes while infusing them with savory fond.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Assemble the power bowl',
      instruction:
          'Divide fluffy lime rice between two wide bowls. Arrange seared chicken, warm black beans, fresh pico de gallo, and sliced avocado. Crown with a generous dollop of Greek yogurt crema.',
      sensoryCue: 'A stunning kaleidoscope of vibrant red, green, deep black, and golden seared chicken.',
      chefTip: 'The contrast between steaming hot chicken and cool lime crema makes every bite dynamic.',
    ),
  ],
);
