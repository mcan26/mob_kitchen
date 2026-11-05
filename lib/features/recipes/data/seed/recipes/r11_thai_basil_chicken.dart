import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobThaiBasilChicken = Recipe(
  id: 'mob_classic_011',
  title: 'Spicy Thai Basil Chicken (Pad Krapow Gai)',
  subtitle: 'Wok-seared minced chicken fragrant with holy basil, fiery bird\'s eye chilies, and a bubbly crispy fried egg.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 10,
  cookTimeMinutes: 10,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 680, proteinG: 44, carbsG: 68, fatG: 24),
  tags: ['Thai', '15-Minute', 'Spicy', 'Pad Krapow', 'High-Protein', 'Quick Dinner'],
  chefGoldenRules: [
    'Toss fresh basil leaves in off the heat at the very end; basil wilts in 15 seconds and overcooking loses its peppery perfume.',
    'Pound the garlic and bird\'s eye chilies in a mortar and pestle to crush cell walls and release potent essential oils before stir-frying.',
    'Fry the egg in generous bubbling oil so the edges blister into crispy golden lace while the yolk remains liquid.',
  ],
  storageAndReheatingTip:
      'Store cooked chicken in an airtight container in the fridge for up to 3 days. Reheat in a dry wok or skillet over medium-high heat with a tablespoon of water for 2 minutes. Fry a fresh egg on demand.',
  ingredients: [
    RecipeIngredient(
      name: 'Boneless chicken thighs or breast',
      amount: 350,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'hand-minced or finely chopped',
      buyingTip: 'Skinless boneless chicken thighs stay juicier and more flavorful during high-heat wok frying than breast meat.',
      substituteOption: 'Ground turkey, minced pork, or crumbled firm tofu.',
    ),
    RecipeIngredient(
      name: 'Fresh Thai holy basil or Italian basil',
      amount: 1,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'leaves picked whole',
      buyingTip: 'Seek out fresh Thai holy basil with purple stems; sweet Italian basil works as a bright aromatic substitute.',
      substituteOption: 'Sweet Italian basil or fresh mint leaves.',
    ),
    RecipeIngredient(
      name: 'Bird\'s eye chilies (Thai red and green)',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'coarsely crushed or sliced',
      buyingTip: 'Choose firm, glossy, vibrant red and green chilies without wrinkles or dark soft spots.',
      substituteOption: 'Serrano peppers or 1 tsp crushed red chili flakes.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 5,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'crushed and coarsely chopped',
      buyingTip: 'Select plump, heavy heads of garlic with intact white skins.',
    ),
    RecipeIngredient(
      name: 'Oyster sauce',
      amount: 1.5,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Buy authentic oyster sauce where oyster extract is listed near the top of the ingredient label.',
      substituteOption: 'Vegetarian stir-fry mushroom sauce or hoisin sauce.',
    ),
    RecipeIngredient(
      name: 'Fish sauce',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'First-press pure fish sauce (such as Red Boat or Megachef) has a clean amber clarity and savory umami aroma.',
      substituteOption: 'Soy sauce mixed with a pinch of sea salt.',
    ),
    RecipeIngredient(
      name: 'Dark sweet soy sauce',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Thick dark soy sauce provides deep caramel color and subtle molasses sweetness.',
      substituteOption: '1 tsp regular soy sauce mixed with 1/2 tsp brown sugar.',
    ),
    RecipeIngredient(
      name: 'Jasmine rice',
      amount: 160,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Fragrant new-crop Thai jasmine rice yields soft, fragrant grains that soak up savory chili juices.',
    ),
    RecipeIngredient(
      name: 'Eggs',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Fresh large eggs with intact shells for making crispy Thai-style fried eggs (kai dao).',
    ),
    RecipeIngredient(
      name: 'Neutral vegetable oil',
      amount: 2,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Cook jasmine rice & prep sauce',
      instruction:
          'Cook jasmine rice in boiling salted water or rice cooker. In a small cup, stir together the oyster sauce, fish sauce, dark soy sauce, and 1 tablespoon of water.',
      sensoryCue: 'Rice is tender and steaming with delicate floral jasmine aroma; sauce is uniform, glossy, and dark.',
      chefTip: 'Premixing the sauce ensures rapid seasoning without burning garlic while searching for bottles at high wok heat.',
      timerSeconds: 600,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Fry crispy Thai lace eggs',
      instruction:
          'Heat 1 tablespoon oil in a wok or skillet over high heat until smoking. Crack in the eggs and spoon hot oil over the whites for 90 seconds until the edges bubble into deep golden lace while the yolk remains liquid. Set aside on a plate.',
      sensoryCue: 'Loud crackling sizzle with golden brown frilly blistered edges around a wobbling bright yellow yolk.',
      chefTip: 'Spoon hot oil directly over the egg white around the yolk to cook the white through without turning the yolk solid.',
      timerSeconds: 90,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Aromatize chili and garlic',
      instruction:
          'Add remaining oil to the smoking wok. Add crushed chilies and garlic; stir-fry vigorously for 30 seconds until intensely fragrant.',
      sensoryCue: 'Vibrant chili and toasted garlic aroma immediately hits the room; garlic turns pale gold, never dark.',
      chefTip: 'Wok should be sizzling hot: 30 seconds is all it takes to perfume the cooking oil.',
      timerSeconds: 30,
      mistakeWarning: 'Keep heat moving; burnt garlic turns bitter.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Stir-fry chicken & glaze',
      instruction:
          'Tumble in hand-minced chicken. Spread across wok surface for 1 minute to sear, then break apart and stir-fry for 3-4 minutes until cooked through. Pour over the sauce mixture and toss vigorously for 1 minute until caramelized.',
      sensoryCue: 'Chicken turns appetizingly bronze and glossy; sauce reduces to coat every crumble with no loose watery puddle.',
      chefTip: 'Spreading the chicken initially ensures high contact heat for browning rather than stewing in chicken juices.',
      timerSeconds: 240,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Wilt basil off heat & assemble',
      instruction:
          'Turn off the heat immediately. Throw in the fresh basil leaves and toss for 15 seconds until wilted. Divide warm jasmine rice into bowls, spoon over spicy basil chicken, and crown with the crispy fried egg.',
      sensoryCue: 'Basil turns bright emerald green and wilts softly, releasing sweet anise and peppery floral perfume.',
      chefTip: 'Never boil basil: residual wok heat is plenty to soften leaves while preserving their vibrant aroma.',
    ),
  ],
);
