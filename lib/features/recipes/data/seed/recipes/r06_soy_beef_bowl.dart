import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSoyGarlicBeefBowl = Recipe(
  id: 'mob_classic_006',
  title: 'Ginger-Soy Glazed Beef Rice Bowl with Crispy Egg',
  subtitle: 'Sweet-savory caramelized ground beef, crispy-edged fried egg, and cool sliced cucumber in 15 minutes.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 5,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 735, proteinG: 46, carbsG: 74, fatG: 28),
  tags: ['15-Minute', 'Ground Beef', 'Asian Inspired', 'Rice Bowl', 'Quick Dinner'],
  chefGoldenRules: [
    'Leave the minced beef completely undisturbed for the first 2 minutes so it builds a deeply caramelized brown crust before releasing moisture.',
    'Soy sauce is naturally salty: mix and taste the glaze before adding any pinch of extra salt.',
    'Use day-old chilled rice or cook ahead; chilled grains stay distinct and absorb the glossy meat pan drippings without turning to mush.',
  ],
  storageAndReheatingTip:
      'Beef glaze keeps in an airtight container in the fridge for up to 4 days, or freezes for 2 months. Reheat in a pan with 1-2 tbsp water over low heat, or microwave for 2 minutes. Always fry the egg fresh.',
  ingredients: [
    RecipeIngredient(
      name: 'Lean ground beef (10-15% fat)',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      buyingTip: 'Ask the butcher for freshly ground lean beef (around 10-15% fat); avoid graying pre-packaged meat.',
      substituteOption: 'Ground turkey or chicken; add 1 extra tablespoon of oil since poultry is leaner.',
    ),
    RecipeIngredient(
      name: 'Jasmine or medium-grain rice',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Select fragrant jasmine or medium-grain rice; short and medium grains provide the pleasant sticky texture typical of rice bowls.',
      substituteOption: 'Basmati rice, brown rice, or microwavable ready-rice pouches.',
    ),
    RecipeIngredient(
      name: 'Low-sodium soy sauce',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Pick naturally brewed low-sodium light soy sauce over dark soy; dark soy is predominantly for coloring and too intense.',
      substituteOption: 'Tamari (gluten-free) or coconut aminos.',
    ),
    RecipeIngredient(
      name: 'Honey',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Use pure runny honey; avoid corn syrup blends which scorch too quickly.',
      substituteOption: 'Brown sugar (1 tbsp) or maple syrup.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 3,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely minced',
      buyingTip: 'Select firm, tight garlic bulbs with no green sprouts poking out.',
    ),
    RecipeIngredient(
      name: 'Fresh ginger',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'freshly grated',
      buyingTip: 'Look for smooth, taut ginger skin; wrinkled skin indicates dried-out fibrous roots.',
      substituteOption: '1/4 tsp ground ginger powder in a pinch.',
    ),
    RecipeIngredient(
      name: 'Scallions / Spring onions',
      amount: 3,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'thinly sliced, whites and greens separated',
      buyingTip: 'Choose crisp green tops and firm white stems; steer clear of slimy or wilted roots.',
    ),
    RecipeIngredient(
      name: 'Persian cucumber',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'thinly sliced rounds',
      buyingTip: 'Firm, small-seed cucumbers provide the best refreshing crunch alongside warm savory beef.',
    ),
    RecipeIngredient(
      name: 'Eggs',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Fresh free-range or organic eggs with intact shells; fresh eggs yield tighter whites and richer yolks.',
    ),
    RecipeIngredient(
      name: 'Toasted sesame seeds',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Buy pre-toasted white sesame seeds or toast raw seeds in a dry pan for 1 minute until fragrant.',
      substituteOption: 'Crispy fried shallots or crushed roasted peanuts.',
    ),
    RecipeIngredient(
      name: 'Red chili flakes',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Vibrant red flakes ensure fresh heat without stale bitterness.',
    ),
    RecipeIngredient(
      name: 'Vegetable or neutral oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Cook or warm the rice',
      instruction:
          'Rinse the rice until water runs almost clear, then cook with 1.5x water and a pinch of salt with lid on over low heat for 12 minutes. Remove from heat and rest covered. (Skip if using pre-cooked rice.)',
      sensoryCue: 'Water is completely absorbed, grains are fluffy and tender, and tiny steam chimneys appear on the surface.',
      chefTip: 'Rinsing washes away excess surface starch so the grains steam fluffy rather than turning gummy.',
      timerSeconds: 720,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Whisk the ginger-soy glaze',
      instruction: 'In a small bowl, whisk together the soy sauce, honey, grated ginger, and red chili flakes.',
      sensoryCue: 'Honey is completely dissolved and the sauce is uniform, glossy, and amber-dark.',
      chefTip: 'Premixing the sauce prevents garlic from scorching in the pan while you search for measuring spoons.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Sear the minced beef',
      instruction:
          'Heat a wide skillet over high heat for 2 minutes with oil, add the ground beef and spread across the pan. Leave untouched for 2 minutes, then break apart with a spoon and sear for 4 more minutes.',
      sensoryCue:
          'The beef turns deep golden brown with crispy crunchy edges. Moisture has evaporated and only sizzling fat remains.',
      chefTip:
          'Why leave it untouched? Direct contact triggers the Maillard reaction. Stirring too soon drops pan temp and boils meat in its own juice.',
      timerSeconds: 360,
      mistakeWarning: 'If using a small pan, cook in two batches so moisture evaporates immediately rather than steaming.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Add aromatics and glaze',
      instruction:
          'Turn heat down to medium. Add minced garlic and the white parts of scallions; toss for 30 seconds. Pour in the glaze and cook for 1-2 minutes until thick and clingy.',
      sensoryCue: 'Glaze clings tightly to the meat crumbles and a sticky, aromatic caramel aroma fills the kitchen.',
      chefTip:
          'Why garlic at the end? Minced garlic scorches in 30 seconds at high heat; adding it late keeps it aromatic and sweet.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Fry crispy lace eggs',
      instruction:
          'In a small non-stick pan, heat 1 tsp oil over medium-high heat. Crack the eggs in and fry for 2 minutes, lacing edges with crispy bubbles while keeping yolks runny.',
      sensoryCue: 'Whites are set with frizzled, golden brown lace edges; the yolks wobble softly in the center.',
      chefTip:
          'High heat produces the beloved crispy lace skirt without overcooking the delicate yolk.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Assemble the bowls',
      instruction:
          'Divide warm rice between two bowls. Spoon over the glossy minced beef, add sliced cucumbers and crown with the crispy egg. Garnish with scallion greens and toasted sesame seeds.',
      sensoryCue: 'Hot, savory beef and warm rice meet cool crisp cucumber and an unctuous golden egg yolk.',
      chefTip: 'Pierce the runny yolk right before eating so it coats the rice like a luxurious sauce.',
    ),
  ],
);
