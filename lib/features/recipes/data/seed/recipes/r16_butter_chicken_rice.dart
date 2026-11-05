import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobButterChickenRice = Recipe(
  id: 'mob_classic_016',
  title: 'Silky Stovetop Butter Chicken with Basmati Rice',
  subtitle: 'Tender spiced yogurt-marinated chicken simmered in a velvety tomato, butter, and cream sauce fragrant with garam masala.',
  category: RecipeCategory.crispyChicken,
  prepTimeMinutes: 15,
  cookTimeMinutes: 20,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 790, proteinG: 48, carbsG: 62, fatG: 40),
  tags: ['Butter Chicken', 'Murgh Makhani', 'Curry', 'High-Protein', 'One-Pan', 'Comfort Food'],
  chefGoldenRules: [
    'Marinate chicken chunks in spiced yogurt first: lactic acid gently tenderizes meat fibers so chicken remains succulent during high-heat searing.',
    'Sear the marinated chicken in a blazing hot pan to get browned charred spots before submerging in the sauce.',
    'Finish the sauce with cold unsalted butter and crushed dried fenugreek (kasuri methi); this gives authentic restaurant silkiness and fragrance.',
  ],
  storageAndReheatingTip:
      'Butter chicken tastes even more incredible the next day as the sauce matures. Keeps in the fridge for up to 4 days, or freezes well for 2 months. Reheat over low heat in a covered saucepan with 2 tbsp water or milk.',
  ingredients: [
    RecipeIngredient(
      name: 'Boneless skinless chicken thighs',
      amount: 400,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'cut into 3 cm bite-sized pieces',
      buyingTip: 'Chicken thighs stay moist and tender in rich tomato cream sauces, whereas chicken breast can dry out easily.',
      substituteOption: 'Chicken breast, paneer cubes, or canned chickpeas.',
    ),
    RecipeIngredient(
      name: 'Greek whole yogurt',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Thick, full-fat Greek or Turkish strained yogurt clings tightly to meat during searing.',
      substituteOption: 'Plain natural whole-milk yogurt.',
    ),
    RecipeIngredient(
      name: 'Passata (strained tomato puree)',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Smooth Italian passata creates an ultra-velvety restaurant sauce without needing a food processor.',
      substituteOption: 'Canned crushed tomatoes blended until silky smooth.',
    ),
    RecipeIngredient(
      name: 'Heavy cream',
      amount: 80,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Heavy whipping cream (at least 35% fat) produces the luxurious, velvety makhani texture.',
      substituteOption: 'Full-fat coconut cream or cashew cream.',
    ),
    RecipeIngredient(
      name: 'Unsalted butter',
      amount: 35,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'cold and cubed',
      buyingTip: 'Pure unsalted butter melted in at the end yields a glossy restaurant-style finish.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely grated or pasted',
      buyingTip: 'Fresh tight heads with firm cloves.',
    ),
    RecipeIngredient(
      name: 'Fresh ginger',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely grated into paste',
      buyingTip: 'Plump, smooth ginger root.',
      substituteOption: '1 tsp ginger powder.',
    ),
    RecipeIngredient(
      name: 'Garam masala',
      amount: 1.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Fragrant warm Indian spice blend with cardamom, cinnamon, mace, and cloves.',
    ),
    RecipeIngredient(
      name: 'Kashmiri chili powder or paprika',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Kashmiri chili powder imparts an iconic glowing ruby-red hue with mild, gentle heat.',
      substituteOption: 'Sweet paprika mixed with a pinch of cayenne.',
    ),
    RecipeIngredient(
      name: 'Basmati rice',
      amount: 160,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Aged long-grain basmati rice steams into individual, fluffy, fragrant grains that soak up rich curry.',
    ),
    RecipeIngredient(
      name: 'Honey or sugar',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'A touch of sweetness balances the rich tomato tang.',
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
      title: 'Marinate spiced chicken',
      instruction:
          'In a bowl, combine chicken chunks, Greek yogurt, half of the grated ginger and garlic, 1 tsp Kashmiri chili powder, 1/2 tsp garam masala, and 1/2 tsp salt. Mix thoroughly and rest for 10 minutes.',
      sensoryCue: 'Chicken chunks are enveloped in a vibrant coral-orange yogurt marinade smelling of warm aromatic spices.',
      chefTip: 'Yogurt enzymes tenderize the poultry and create a protective crust that traps moisture during searing.',
      timerSeconds: 600,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sear charred chicken chunks',
      instruction:
          'Heat a wide skillet or Dutch oven over high heat with 1 tablespoon oil. Add marinated chicken in a single layer. Sear for 3-4 minutes per side until deeply browned with charred edges. Transfer to a plate; chicken does not need to be fully cooked inside yet.',
      sensoryCue: 'Vigorous sizzling crackles as yogurt marinade forms charred, caramelized spots reminiscent of a tandoor oven.',
      chefTip: 'Do not crowd the skillet; high contact heat produces charred spots that give butter chicken its signature smoky profile.',
      timerSeconds: 420,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Build the makhani tomato base',
      instruction:
          'Reduce heat to medium. Add remaining grated ginger and garlic to the pan drippings; cook for 60 seconds. Pour in smooth passata, remaining garam masala, a pinch of salt, and honey. Simmer gently for 8 minutes until darkened and reduced.',
      sensoryCue: 'Tomato sauce deepens from bright orange-red into a rich crimson glaze with sweet caramelized tomato perfume.',
      chefTip: 'Simmering removes raw tomato acidity and concentrates natural sugars before introducing dairy.',
      timerSeconds: 480,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Simmer chicken & enrich with cream',
      instruction:
          'Return seared chicken and all resting juices into the simmering tomato sauce. Pour in heavy cream and stir gently. Simmer over low heat for 5-6 minutes until chicken is cooked through and tender.',
      sensoryCue: 'The sauce softens into an iconic silky, pastel-orange velvet blanket bubbling gently around tender chicken pieces.',
      chefTip: 'Keep heat gentle once cream is added to keep the dairy stable and velvety without curdling.',
      timerSeconds: 360,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Finish with cold butter & serve',
      instruction:
          'Turn off heat. Swirl in cold cubed butter until melted and glossy. Spoon generous ladles of butter chicken over steaming basmati rice, drizzle with a swirl of cream, and serve warm with naan.',
      sensoryCue: 'The curry turns mirror-glossy with an opulent buttery aroma; chicken pieces yield effortlessly to a spoon.',
      chefTip: 'Swirling in cold butter off the heat (mantecare style) creates an emulsion that gives the sauce a mirror-like shine and silkiness.',
    ),
  ],
);
