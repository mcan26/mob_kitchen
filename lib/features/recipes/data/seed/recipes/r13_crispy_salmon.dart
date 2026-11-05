import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCrispySalmon = Recipe(
  id: 'mob_classic_013',
  title: 'Pan-Seared Crispy Salmon with Lemon Butter',
  subtitle: 'Glass-crisp crackling skin, tender flaky pink fillets, basted in foaming garlic butter, capers, and dill.',
  category: RecipeCategory.highProtein,
  prepTimeMinutes: 5,
  cookTimeMinutes: 10,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 650, proteinG: 46, carbsG: 6, fatG: 48),
  tags: ['High-Protein', 'Salmon', 'Crispy Skin', 'Keto-Friendly', 'Quick Dinner'],
  chefGoldenRules: [
    'Dry the salmon skin relentlessly with paper towels before cooking; any surface moisture steams the skin instead of crisping it into crackling.',
    'Press down firmly on each fillet with a flexible fish spatula for the first 30 seconds to prevent the natural skin shrinkage curl.',
    'Cook 85% of the time skin-side down; flip only at the end to kiss the flesh side with foaming lemon-garlic butter.',
  ],
  storageAndReheatingTip:
      'Best enjoyed fresh while skin is shatteringly crisp. Leftover salmon keeps in an airtight container for up to 2 days; enjoy cold flaked over salads, as reheating in a microwave will overcook the delicate fish and soften the skin.',
  ingredients: [
    RecipeIngredient(
      name: 'Salmon fillets (skin-on, center cut)',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.butcherDeli,
      buyingTip: 'Select thick, uniform center-cut fillets with scales scraped off and vibrant coral-pink flesh smelling of fresh ocean breeze.',
      substituteOption: 'Skin-on sea bass fillets, rainbow trout, or arctic char.',
    ),
    RecipeIngredient(
      name: 'Unsalted butter',
      amount: 25,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Pure sweet cream butter creates rich foaming basting nutty butter (beurre noisette).',
      substituteOption: 'Ghee or avocado oil for dairy-free.',
    ),
    RecipeIngredient(
      name: 'Fresh lemon',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'halved for juicing and wedges',
      buyingTip: 'Heavy, thin-skinned juicy lemons yield bright acidity to cut the rich salmon oils.',
    ),
    RecipeIngredient(
      name: 'Capers (in brine)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      preparationNote: 'drained',
      buyingTip: 'Non-pareil small capers bring concentrated salty floral bursts to fish pan sauces.',
      substituteOption: 'Finely chopped green olives or pickled baby gherkins.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 2,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'lightly crushed with flat knife',
      buyingTip: 'Fresh plump garlic cloves.',
    ),
    RecipeIngredient(
      name: 'Fresh dill',
      amount: 0.25,
      unit: MeasurementUnit.bunch,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'coarsely torn',
      buyingTip: 'Feathery, fragrant bright green fronds without yellowing wilt.',
      substituteOption: 'Fresh flat-leaf parsley or tarragon.',
    ),
    RecipeIngredient(
      name: 'Avocado or high-smoke oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'A neutral oil with high smoke point allows skin to sear crisp without burning.',
    ),
    RecipeIngredient(
      name: 'Flaky sea salt (Maldon)',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Craggy sea salt flakes provide delightful crunch on crispy fish skin.',
    ),
    RecipeIngredient(
      name: 'Freshly ground black pepper',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Dry skin thoroughly & season',
      instruction:
          'Press paper towels firmly against the salmon skin until bone dry. Season both the flesh and skin generously with flaky sea salt and cracked black pepper.',
      sensoryCue: 'The salmon skin feels matte and dry with no slick or wet sheen.',
      chefTip: 'Moisture is the enemy of crispiness: dry skin turns into wafer-thin crackling, while damp skin turns chewy and rubbery.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Sear skin-side down & press',
      instruction:
          'Heat high-smoke oil in a heavy stainless steel or cast-iron skillet over medium-high heat until shimmering. Lay fillets skin-side down facing away from you. Immediately press down firmly with a spatula across each fillet for 30 seconds.',
      sensoryCue: 'A loud energetic hiss erupts as skin meets hot oil; fillet lays flat without buckling or curling at edges.',
      chefTip: 'Salmon skin shrinks rapidly when hitting high heat; pressing down holds it flat for complete, uniform skin-to-pan contact.',
      timerSeconds: 30,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Cook undisturbed for 6 minutes',
      instruction:
          'Lower heat slightly to medium. Leave the fillets completely untouched for 6 minutes while the heat creeps upward through the fish.',
      sensoryCue: 'The opaque cooked white layer climbs up the sides from the pan, reaching about 80% to the top; skin is deep golden and rigid.',
      chefTip: 'Resist nudging or prodding the fish; salmon naturally releases from the skillet floor once the skin becomes crisp and dehydrated.',
      timerSeconds: 360,
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Flip and baste with foaming butter',
      instruction:
          'Gently flip fillets over onto the flesh side. Add cold butter, crushed garlic, and drained capers to the pan. Tilt skillet and spoon the frothing, nutty butter over the crispy skin for 60-90 seconds.',
      sensoryCue: 'Butter foams up into fragrant golden bubbles smelling of toasted hazelnuts and garlicky capers; salmon center turns tender rose-pink.',
      chefTip: 'Basting with foaming butter cooks the flesh gently and imparts rich sheen while keeping the top skin perfectly crisp.',
      timerSeconds: 90,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Squeeze lemon & serve',
      instruction:
          'Squeeze half a fresh lemon directly into the foaming pan butter off heat. Transfer fillets onto warm plates skin-side up, spoon over the lemon-caper butter sauce, and garnish with fresh dill.',
      sensoryCue: 'Tapping the skin with a fork produces an audible crisp scrape; flesh flakes apart in succulent silky petals.',
      chefTip: 'Always plate skin-side UP and spoon the sauce around the fillet, never directly on top, to safeguard your crispy crust.',
    ),
  ],
);
