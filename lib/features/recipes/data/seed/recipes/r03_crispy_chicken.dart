import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCrispyChickenHotHoney = Recipe(
  id: 'mob_classic_003',
  title: 'Crispy Hot Honey Skillet Chicken',
  subtitle: 'Zero deep-frying. Yogurt-tenderized thighs with a shattering cornflake crunch and spicy garlic honey glaze.',
  category: RecipeCategory.crispyChicken,
  prepTimeMinutes: 25,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 690, proteinG: 54, carbsG: 49, fatG: 29),
  tags: ['crispy-chicken', 'hot-honey', 'airfryer-friendly', 'high-protein', 'skillet'],
  chefGoldenRules: [
    'Marinate chicken in seasoned yogurt for at least 15 minutes: lactic acid gently breaks down meat fibers for maximum juiciness.',
    'Coarsely crush the cornflakes by hand; never pulverize into powder or it absorbs excess oil instead of creating craggy crispiness.',
    'Rest fried chicken on a wire rack rather than a paper towel to stop trapped steam from softening the crunchy underside.',
  ],
  storageAndReheatingTip:
      'Stores refrigerated for 2 days. Revive crunch in an air fryer at 180°C for 4 minutes or dry in a hot skillet for 2 minutes each side.',
  ingredients: [
    RecipeIngredient(
      name: 'Boneless skinless chicken thighs',
      amount: 450,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'cut into 4-5 cm nuggets',
      buyingTip: 'Thigh meat retains deep moisture and natural fat through searing and frying without drying out.',
      substituteOption: 'Chicken tenders or breast chunks; shave 1 minute off frying time.',
    ),
    RecipeIngredient(
      name: 'Plain Greek yogurt',
      amount: 150,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Full-fat, unflavored yogurt is best for creating a clingy marinade without watery separation.',
      substituteOption: '120 ml buttermilk or kefir.',
    ),
    RecipeIngredient(
      name: 'Unsweetened cornflakes',
      amount: 80,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'coarsely crushed by hand',
      buyingTip: 'Ensure plain unsweetened cornflakes; frosted varieties will burn and create an unwanted sweet crust.',
      substituteOption: 'Panko breadcrumbs mixed with 1 tbsp cornstarch.',
    ),
    RecipeIngredient(
      name: 'Egg',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Beaten into the yogurt marinade to form a powerful binding glue for the flakes.',
    ),
    RecipeIngredient(
      name: 'All-purpose flour',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Standard wheat flour creates the initial moisture barrier.',
      substituteOption: 'Cornstarch for an even lighter, gluten-free crunch.',
    ),
    RecipeIngredient(
      name: 'Garlic powder',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Fine powder blends seamlessly into the dry dredge.',
      substituteOption: '2 fresh grated garlic cloves in the yogurt marinade.',
    ),
    RecipeIngredient(
      name: 'Smoked sweet paprika',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Spanish pimentón adds deep sunset color and barbecue smokiness.',
      substituteOption: 'Standard paprika plus cayenne.',
    ),
    RecipeIngredient(
      name: 'Sea salt',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Neutral high-heat cooking oil',
      amount: 150,
      unit: MeasurementUnit.milliliter,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Sunflower, canola, or peanut oil with high smoke points.',
      substituteOption: 'For air frying: 2-3 sprays of cooking oil.',
    ),
    RecipeIngredient(
      name: 'Runny wildflower honey',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Raw, liquid honey that warms cleanly without crystallizing.',
      substituteOption: 'Maple syrup or agave nectar.',
    ),
    RecipeIngredient(
      name: 'Chili flakes or Sriracha',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Crushed red pepper flakes or gochugaru for adjustable heat in the hot honey.',
    ),
    RecipeIngredient(
      name: 'Apple cider vinegar',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Sharp acidity cuts the honey sweetness and balances the sauce.',
      substituteOption: 'Fresh lemon juice.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Yogurt brine marinade',
      instruction:
          'In a medium bowl, whisk yogurt, beaten egg, garlic powder, smoked paprika, and salt. Fold in chicken pieces and let marinate for at least 15 minutes at room temperature.',
      sensoryCue: 'Chicken pieces should be coated in a thick, spiced, salmon-pink yogurt cream.',
      chefTip:
          'Yogurt enzymes gently tenderize without turning the chicken mushy, locking in succulent juices while cooking.',
      timerSeconds: 900,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Crush flakes and dredge',
      instruction:
          'In a shallow dish, combine crushed cornflakes and all-purpose flour. Lift each chicken piece from the yogurt, dredge in the flakes, and press firmly so the flakes adhere in jagged layers.',
      sensoryCue:
          'Chicken is completely clad in golden, crunchy scales with no bare wet patches.',
      chefTip:
          'Pressing firmly creates irregular edges that catch hot oil and turn dramatically crispy.',
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Shallow pan-fry',
      instruction:
          'Pour oil into a skillet (about 1 cm deep) and heat over medium-high heat until 175°C (a dropped flake sizzles instantly). Gently lay chicken pieces and fry 3-4 minutes per side until deeply golden.',
      sensoryCue:
          'Lively, steady bubbles sizzle around each piece. The coating turns amber-golden and sounds hollow when tapped with metal tongs.',
      chefTip:
          'Do not overcrowd the skillet or oil temperature will plummet, causing the coating to absorb oil instead of frying.',
      timerSeconds: 240,
      mistakeWarning: 'Keep heat around medium once bubbling; too high will scorch cornflakes before the thigh cooks through.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Rest on a wire rack',
      instruction:
          'Transfer golden chicken onto a wire cooling rack set over a tray. Season immediately with a sprinkle of fine sea salt while sizzling.',
      sensoryCue: 'Steam escapes freely from all sides, keeping the underside crackling crisp.',
      chefTip:
          'Never drain on paper towels! Trapped steam softens the underside into soggy batter.',
      timerSeconds: 120,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Warm the hot honey glaze',
      instruction:
          'In a small butter warmer or microwave, warm honey, chili flakes, and apple cider vinegar for 45 seconds until runny and bubbling gently. Drizzle over hot chicken right before devouring.',
      sensoryCue:
          'Honey cascades over the craggy cornflake edges with a glossy, sweet-and-spicy sheen.',
      chefTip:
          'Drizzle immediately before serving to preserve maximum crunch.',
      timerSeconds: 45,
    ),
  ],
);
