import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobChickpeaShakshuka = Recipe(
  id: 'mob_classic_005',
  title: 'Cast-Iron Chickpea Shakshuka with Feta',
  subtitle: 'Budget-friendly skillet dinner: spiced chickpeas braised in rich tomato-pepper sugo with runny poached eggs and salty feta.',
  category: RecipeCategory.budget,
  prepTimeMinutes: 10,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 520, proteinG: 28, carbsG: 48, fatG: 24),
  tags: ['budget-friendly', 'one-pan', 'vegetarian', 'eggs', 'chickpeas'],
  chefGoldenRules: [
    'Cook down the tomato-pepper sauce until thick and glossy with oil separating before creating wells for the eggs.',
    'Fry tomato paste in olive oil for 1 minute to cook out raw bitterness and unlock sweet roasted umami.',
    'Cover skillet with a lid to gently set the whites while leaving the yolks warm, rich, and jammy.',
  ],
  storageAndReheatingTip:
      'The chickpea-tomato base keeps for up to 4 days refrigerated and tastes even deeper on day two. Reheat base and crack fresh eggs.',
  ingredients: [
    RecipeIngredient(
      name: 'Chickpeas (canned)',
      amount: 1,
      unit: MeasurementUnit.can,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'drained and rinsed',
      buyingTip: 'Look for plump canned chickpeas in water without added firming chemicals.',
      substituteOption: 'Cannellini beans or black beans.',
    ),
    RecipeIngredient(
      name: 'Crushed peeled tomatoes',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'San Marzano or Italian crushed tomatoes in thick tomato puree.',
      substituteOption: '5 fresh ripe plum tomatoes grated in season.',
    ),
    RecipeIngredient(
      name: 'Eggs',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Room temperature eggs poach evenly in hot sauce without chilling the skillet.',
    ),
    RecipeIngredient(
      name: 'Yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'diced',
      buyingTip: 'Choose firm, heavy yellow onions with paper-dry skins and no soft spots.',
    ),
    RecipeIngredient(
      name: 'Red bell pepper',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'diced into 1 cm chunks',
      buyingTip: 'Firm, heavy red pepper with shiny taut skin.',
      substituteOption: 'Yellow bell pepper or 2 roasted red peppers from a jar.',
    ),
    RecipeIngredient(
      name: 'Garlic cloves',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'minced',
      buyingTip: 'Plump, firm cloves without sprouting bitter green cores.',
    ),
    RecipeIngredient(
      name: 'Double-concentrated tomato paste',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Rich paste in a tube or glass jar.',
      substituteOption: 'Harissa paste for extra North African heat.',
    ),
    RecipeIngredient(
      name: 'Ground cumin',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Freshly ground cumin with a warm, pungent, earthy fragrance.',
    ),
    RecipeIngredient(
      name: 'Smoked paprika',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Spanish pimentón de la Vera adds authentic wood-fired aroma.',
    ),
    RecipeIngredient(
      name: 'Crumbled feta cheese',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'crumbled',
      buyingTip: 'Authentic sheep milk Greek feta stored in brine.',
      substituteOption: 'Goat cheese or Turkish white cheese.',
    ),
    RecipeIngredient(
      name: 'Extra virgin olive oil',
      amount: 2,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Fresh parsley or cilantro',
      amount: 0.5,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'chopped',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Sauté peppers and onions',
      instruction:
          'Heat olive oil in a wide cast-iron skillet over medium heat. Sauté diced onions and red bell pepper for 5-6 minutes until softened and lightly caramelized.',
      sensoryCue: 'Peppers soften and onions develop sweet golden edges with a gentle sizzle.',
      chefTip:
          'Sweating peppers slowly releases their natural sweetness, balancing the tangy canned tomatoes.',
      timerSeconds: 300,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Toast tomato paste and spices',
      instruction:
          'Stir in minced garlic, tomato paste, ground cumin, and smoked paprika. Fry continuously for 1 minute until the oil turns brick-red.',
      sensoryCue: 'Intense roasted tomato and earthy cumin aroma fills the room.',
      chefTip:
          'Frying tomato paste caramelizes the sugars and removes tinny metallic flavors.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Simmer rich chickpea sauce',
      instruction:
          'Pour in crushed tomatoes, drained chickpeas, and 100 ml water. Season with sea salt and cracked pepper. Simmer on medium-low for 8 minutes until thickened.',
      sensoryCue: 'Sauce bubbles lazily and thickens so a spoon drawn through leaves a momentary trail.',
      chefTip:
          'Chickpeas soak up the savory spiced tomato reduction, turning tender and flavorful.',
      timerSeconds: 480,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Nest the eggs and steam',
      instruction:
          'Make 4 distinct wells in the bubbling sauce using the back of a spoon. Crack an egg into each well. Cover with a tight-fitting lid and cook on medium-low for 4-5 minutes.',
      sensoryCue:
          'Egg whites turn opaque and set firm while the yolks remain soft, glossy, and gently wobbling.',
      chefTip:
          'The lid traps rising steam, gently cooking the top of the whites without overcooking the delicate yolk.',
      timerSeconds: 270,
      mistakeWarning: 'Check at minute 4; eggs continue cooking off the heat, so pull them when slightly softer than desired.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Feta crumble and crusty bread',
      instruction:
          'Remove from heat immediately. Scatter crumbled feta, chopped fresh parsley, and extra chili flakes. Serve straight from the sizzling skillet with thick toasted sourdough.',
      sensoryCue: 'White feta softens slightly against the hot red sauce, contrasting beautifully with bright yellow yolks.',
      chefTip: 'Dip crusty bread straight into the warm yolk and scoop up rich spiced chickpeas.',
    ),
  ],
);
