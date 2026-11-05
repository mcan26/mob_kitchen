import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCoconutChickpeaCurry = Recipe(
  id: 'mob_classic_014',
  title: 'Golden Coconut Chickpea & Spinach Curry',
  subtitle: 'Nutty chickpeas simmered in rich coconut cream with turmeric, ginger, garam masala, and tender baby spinach.',
  category: RecipeCategory.budget,
  prepTimeMinutes: 10,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 590, proteinG: 21, carbsG: 64, fatG: 26),
  tags: ['Curry', 'Plant-Based', 'Vegan', 'Chickpeas', 'Budget-Friendly', 'One-Pan'],
  chefGoldenRules: [
    'Toast the dry ground spices (turmeric, cumin, garam masala) in warm oil with the onions to bloom their fat-soluble aromatic oils.',
    'Crush half a cup of the simmered chickpeas against the pan side with a wooden spoon; releasing their starch thickens the curry naturally without flour.',
    'Fold fresh baby spinach in right at the end; residual coconut sauce heat wilts tender greens without losing their bright color.',
  ],
  storageAndReheatingTip:
      'Curry flavors dramatically improve on day two as chickpeas soak in the spiced coconut broth. Keeps in the fridge for up to 5 days, or freezes for 3 months. Reheat gently in a saucepan with a splash of water.',
  ingredients: [
    RecipeIngredient(
      name: 'Canned chickpeas (garbanzo beans)',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'drained and rinsed',
      buyingTip: 'Check ingredient list for chickpeas, water, and salt; avoid cans with calcium disodium EDTA when possible.',
      substituteOption: 'Cooked dried chickpeas, brown lentils, or cubed firm tofu.',
    ),
    RecipeIngredient(
      name: 'Full-fat coconut milk',
      amount: 400,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Choose canned full-fat coconut milk with coconut extract as the main ingredient; "light" coconut milk yields a watery sauce.',
      substituteOption: 'Heavy cooking cream or cashew cream.',
    ),
    RecipeIngredient(
      name: 'Fresh baby spinach',
      amount: 120,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.produce,
      buyingTip: 'Crisp, tender baby spinach leaves with vibrant dark green color and zero wilting.',
      substituteOption: 'Tuscan kale (stems stripped and chopped) or Swiss chard.',
    ),
    RecipeIngredient(
      name: 'Yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely diced',
      buyingTip: 'Firm heavy yellow onion with dry papery skin.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely minced',
      buyingTip: 'Fresh tight heads of garlic.',
    ),
    RecipeIngredient(
      name: 'Fresh ginger',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely grated',
      buyingTip: 'Smooth, plump fresh ginger rhizomes.',
      substituteOption: '1/2 tsp ground dried ginger.',
    ),
    RecipeIngredient(
      name: 'Ground turmeric',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Bright golden-orange ground turmeric gives the curry its warm hue and earthy fragrance.',
    ),
    RecipeIngredient(
      name: 'Garam masala',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Aromatic blend containing cardamom, cinnamon, cloves, and cumin.',
      substituteOption: 'Madras curry powder.',
    ),
    RecipeIngredient(
      name: 'Ground cumin',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Coconut or olive oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Lime',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'cut into wedges',
      buyingTip: 'Soft, heavy limes give the juiciest bright squeeze to balance rich coconut fats.',
    ),
    RecipeIngredient(
      name: 'Salt',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Soften aromatics',
      instruction:
          'Heat coconut oil in a wide Dutch oven or skillet over medium heat. Add diced onion with a pinch of salt; cook for 4-5 minutes until translucent and soft. Stir in minced garlic and grated ginger for 1 minute.',
      sensoryCue: 'Onions are soft, sweet, and golden-edged; warm, spicy ginger and garlic perfume fills the kitchen.',
      chefTip: 'Cooking onions thoroughly until tender provides the natural sweetness foundational to rich curries.',
      timerSeconds: 300,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Bloom spices in warm oil',
      instruction:
          'Add ground turmeric, cumin, and garam masala to the softened onions. Stir constantly over medium heat for 60 seconds to toast the spices in the warm fat.',
      sensoryCue: 'The spices turn deep amber-gold and release an intoxicating, earthy, warm aroma with no raw powder smell.',
      chefTip: 'Toasting spices in oil (tadka) activates their lipophilic essential oils, multiplying flavor complexity tenfold.',
      timerSeconds: 60,
      mistakeWarning: 'Keep stirring constantly so delicate ground spices do not scorch.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Simmer chickpeas & coconut milk',
      instruction:
          'Pour in the full-fat coconut milk and drained chickpeas. Season with salt. Bring to a lively simmer, then turn heat down to low, cover partially, and let bubble gently for 12-14 minutes.',
      sensoryCue: 'The curry turns into a rich glowing marigold yellow; liquid bubbles gently around plump tender chickpeas.',
      chefTip: 'Gentle simmering allows the porous chickpeas to absorb coconut cream and savory spice infused oil.',
      timerSeconds: 780,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Crush chickpeas for natural body',
      instruction:
          'Uncover the curry. Using the back of a wooden spoon or potato masher, crush about 1/4 of the chickpeas against the side of the pot, stirring well for 2 minutes.',
      sensoryCue: 'The sauce immediately transforms from loose liquid into a thick, velvety, spoon-coating stew.',
      chefTip: 'Crushing chickpeas releases internal starch, creating a lush creamy body without using flour, cornstarch, or dairy.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Fold spinach & finish with lime',
      instruction:
          'Remove from heat. Pile fresh baby spinach into the pot and fold gently until tender and wilted (about 1 minute). Squeeze in fresh lime juice and serve warm over basmati rice or with warm naan.',
      sensoryCue: 'Spinach wilts into silky emerald ribbons contrasting with the creamy golden yellow sauce; lime cuts the richness.',
      chefTip: 'A squeeze of fresh lime juice right at the end provides bright acid that lifts and balances rich coconut cream.',
    ),
  ],
);
