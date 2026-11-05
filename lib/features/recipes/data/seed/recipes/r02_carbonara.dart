import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobCarbonara = Recipe(
  id: 'mob_classic_002',
  title: 'Authentic Roman Carbonara',
  subtitle: 'Zero cream. Silky emulsification powered by egg yolks, pecorino, and starchy pasta water in 20 minutes.',
  category: RecipeCategory.pasta,
  prepTimeMinutes: 5,
  cookTimeMinutes: 15,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 780, proteinG: 38, carbsG: 78, fatG: 34),
  tags: ['pasta', '20-minute', 'no-cream', 'roman-classic', 'high-protein'],
  chefGoldenRules: [
    'Never pour the egg emulsion into a pan over active flame: the residual skillet heat off the burner is all you need, or you get scrambled eggs.',
    'Always reserve a mug of cloudy, starchy pasta cooking water before draining; it is the chemical binder that makes the sauce glossy.',
    'Start cured pork in a cold skillet to gently render out the fat without burning the meat.',
  ],
  storageAndReheatingTip:
      'Carbonara is best savored immediately. If reheating leftovers, stir in a skillet over gentle low heat with 2-3 tbsp water; never microwave.',
  ingredients: [
    RecipeIngredient(
      name: 'Spaghetti',
      amount: 200,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Look for bronze-die extruded spaghetti with an opaque, floury texture.',
      substituteOption: 'Rigatoni, linguine, or bucatini.',
    ),
    RecipeIngredient(
      name: 'Smoked beef bacon or pancetta',
      amount: 120,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'sliced into 1 cm lardons',
      buyingTip:
          'Choose thick-cut strips with generous white fat marbling; paper-thin bacon dries out without rendering enough fat.',
      substituteOption: 'Guanciale for the purist Roman standard, or thick-cut pancetta.',
    ),
    RecipeIngredient(
      name: 'Eggs',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Farm-fresh free-range eggs with bright golden-orange yolks at room temperature.',
    ),
    RecipeIngredient(
      name: 'Egg yolks',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Separate the whites and save them for morning omelets or meringue.',
      substituteOption: 'One whole egg instead of two yolks for a slightly lighter texture.',
    ),
    RecipeIngredient(
      name: 'Pecorino Romano',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'finely grated with a microplane',
      buyingTip:
          'Sharp, aged Pecorino Romano gives the signature salty bite.',
      substituteOption: 'Parmigiano Reggiano or a 50/50 blend of both.',
    ),
    RecipeIngredient(
      name: 'Freshly cracked black pepper',
      amount: 1.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Grind whole black peppercorns coarsely into a pan; pre-ground pepper lacks volatile oils.',
    ),
    RecipeIngredient(
      name: 'Coarse sea salt (for pasta water)',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Salt the boiling water like seawater; the cured pork already brings ample salt to the sauce.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Whisk the egg and cheese paste',
      instruction:
          'In a large mixing bowl, vigorously whisk whole eggs, egg yolks, half the grated pecorino, and coarse black pepper until homogenous. Reserve the remaining cheese for finishing.',
      sensoryCue: 'Mixture should look like a rich, sunny-yellow custard paste.',
      chefTip:
          'Whisking in a separate bowl off the heat guarantees temperature stability. Egg proteins coagulate above 65°C.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Render the bacon from cold',
      instruction:
          'Place lardons into a wide cold skillet. Turn heat to medium-low and slowly render the fat for 6-8 minutes, stirring occasionally until golden and crispy. Take off the heat and let the pan rest.',
      sensoryCue:
          'Fat turns clear and liquid in the skillet while the pork pieces turn crunchy on the outside with a slight chew inside.',
      chefTip:
          'Starting cold melts fat before the outer meat chars. This rendered liquid fat is the foundational flavor of your carbonara.',
      timerSeconds: 420,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Boil spaghetti al dente',
      instruction:
          'Drop spaghetti into salted boiling water. Cook for 8-9 minutes (1 minute shy of box directions). Scoop out 1 cup of starchy pasta water right before draining.',
      sensoryCue:
          'Spaghetti should have a faint white dot at the core when bitten, offering firm resistance (al dente). Water is cloudy and starchy.',
      chefTip:
          'Pasta water is rich in suspended starch, the crucial emulsifier that binds hot fat and eggs together.',
      timerSeconds: 480,
      mistakeWarning: 'Never forget to scoop out the pasta water before dumping everything into the colander!',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Emulsify off the heat',
      instruction:
          'Transfer hot drained pasta directly into the warm skillet with rendered bacon fat (heat OFF). Wait 60 seconds, then pour in the egg paste and 3-4 tbsp of hot pasta water. Toss and stir vigorously with tongs.',
      sensoryCue:
          'The sauce transforms before your eyes into a creamy, mirror-sheen coating that clings to every noodle without any curdled egg bits.',
      chefTip:
          'If the skillet is too hot, the eggs scramble. If it is too cold, the cheese clumps. That 60-second cooldown is the culinary sweet spot.',
      timerSeconds: 60,
      mistakeWarning:
          'If the sauce feels tight or tacky, splash in 1-2 more tablespoons of pasta water and keep tossing immediately.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Plate and finish',
      instruction:
          'Twirl spaghetti into warmed shallow bowls using tongs and a ladle. Dust generously with remaining pecorino and freshly cracked black pepper.',
      sensoryCue: 'Glistening sauce pools gently around the base without separating into grease puddles.',
      chefTip: 'Warming your plates beforehand keeps the emulsified egg sauce silky to the very last bite.',
    ),
  ],
);
