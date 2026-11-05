import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSausagePotatoHash = Recipe(
  id: 'mob_classic_007',
  title: 'Crispy Sausage & Potato Skillet Hash with Eggs',
  subtitle: 'Golden skillet potatoes crisped in spiced sausage drippings, sweet peppers, and melted cheese.',
  category: RecipeCategory.budget,
  prepTimeMinutes: 10,
  cookTimeMinutes: 25,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 780, proteinG: 33, carbsG: 62, fatG: 44),
  tags: ['Budget-Friendly', 'One-Pan', 'Sausage', 'Crispy Potatoes', 'Brunch'],
  chefGoldenRules: [
    'Steam the diced potatoes covered first to tenderize the interior, then uncover to develop a shatteringly crisp crust.',
    'Resist stirring the potatoes constantly; allow each cut side 3-4 minutes undisturbed contact with the skillet floor to build color.',
    'Never discard the sausage drippings: frying the potatoes directly in seasoned rendered fat provides effortless depth of flavor.',
  ],
  storageAndReheatingTip:
      'Store hash in the fridge for up to 3 days. Re-crisp in a dry skillet over medium-high heat for 4-5 minutes, tossing occasionally; avoid microwaves as they turn potatoes soggy. Always cook fresh eggs.',
  ingredients: [
    RecipeIngredient(
      name: 'Yukon gold or waxy potatoes',
      amount: 500,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'cut into 1.5 cm cubes (skin on)',
      buyingTip: 'Choose firm, unblemished yellow or Yukon Gold potatoes; avoid green-tinged skins which taste bitter.',
      substituteOption: 'Sweet potatoes or red-skinned potatoes.',
    ),
    RecipeIngredient(
      name: 'Smoked beef sausage or chorizo',
      amount: 120,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'sliced into half-moons',
      buyingTip: 'Pick a high-meat spiced beef sausage, sucuk, or chorizo with visible marbling that renders flavorful fat.',
      substituteOption: 'Thick-cut bacon lardons, smoked turkey sausage, or plant-based spicy sausage.',
    ),
    RecipeIngredient(
      name: 'Yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'thinly sliced into half-moons',
      buyingTip: 'Select heavy, firm onions with dry, paper-thin skin.',
      substituteOption: 'Red onion or two shallots.',
    ),
    RecipeIngredient(
      name: 'Green bell pepper',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'diced into 1 cm pieces',
      buyingTip: 'Select heavy bell peppers with taut, glossy, unwrinkled skin.',
      substituteOption: 'Poblano pepper, cubanelle pepper, or red bell pepper.',
    ),
    RecipeIngredient(
      name: 'Eggs',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Fresh large free-range eggs with intact, clean shells.',
    ),
    RecipeIngredient(
      name: 'Sharp Cheddar or aged melting cheese',
      amount: 60,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.dairy,
      preparationNote: 'freshly grated',
      buyingTip: 'Buy block cheese and grate yourself; pre-shredded bagged cheese contains anti-caking starches that hinder melting.',
      substituteOption: 'Monterey Jack, Turkish aged kaşar, or shredded mozzarella.',
    ),
    RecipeIngredient(
      name: 'Smoked paprika or chili flakes',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
      buyingTip: 'Vibrant scarlet smoked Spanish paprika yields a rich wood-smoke aroma and vivid red color.',
    ),
    RecipeIngredient(
      name: 'Fine sea salt',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Olive or vegetable oil',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Render and crisp the sausage',
      instruction:
          'Heat a wide, heavy skillet over medium heat. Add the sausage half-moons and fry for 3-4 minutes until edges curl and render their vibrant spiced fat. Transfer sausage to a plate using a slotted spoon; leave all fat in the pan.',
      sensoryCue: 'A pool of fragrant, crimson-orange seasoned oil coats the pan floor; sausage edges are crisp and sizzling.',
      chefTip: 'Why pull the sausage out? Leaving it in the skillet for the entire 20-minute potato cook would render it tough and dry.',
      timerSeconds: 210,
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Steam-tenderize the potatoes',
      instruction:
          'Tumble diced potatoes into the shimmering sausage fat, season with salt, and cover tightly with a lid. Cook over medium heat for 8-10 minutes, tossing every 3 minutes.',
      sensoryCue: 'A fork pierces the potato cubes with slight resistance; edges begin to show translucent tenderness and faint golden edges.',
      chefTip:
          'Why the lid? Trapping steam cooks the potato starch through to the core. Cooking uncovered from raw burns the exterior before the centers soften.',
      timerSeconds: 540,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Uncover and blast the crust',
      instruction:
          'Remove the lid and turn heat up to medium-high. Add sliced onion and bell pepper. Fry for 6-8 minutes, stirring sparingly, until potatoes develop deep golden crusts on multiple sides.',
      sensoryCue:
          'Tossing the potatoes produces a loud, dry scraping crunch against the pan floor; onions are translucent with caramelized edges.',
      chefTip: 'Resist stirring constantly! Potatoes require uninterrupted pan contact to develop that coveted crispy Maillard crust.',
      timerSeconds: 420,
      mistakeWarning: 'If potatoes stick slightly, wait another 30 seconds; they naturally release once a solid crisp crust forms.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Nest the eggs and melt cheese',
      instruction:
          'Return crisped sausage to the pan and dust with smoked paprika. Carve 4 distinct wells in the hash with a spoon, crack an egg into each well, scatter grated cheese around the whites, cover, and cook on low for 3-4 minutes.',
      sensoryCue: 'Egg whites turn completely opaque and set, yolks remain glossy and softly trembling, and cheese melts into gooey pockets.',
      chefTip: 'Keeping yolks liquid is essential: broken yolk creates an instant rich sauce that coats the crispy spiced potatoes.',
      timerSeconds: 210,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Garnish and serve skillet-side',
      instruction: 'Carry the sizzling skillet directly to the table on a trivet. Dust with cracked black pepper and fresh herbs if desired.',
      sensoryCue: 'Sizzling crackles quietly at the edges and melted cheese pulls into gooey strings when scooped.',
      chefTip: 'Pairs wonderfully with tangy pickled jalapeños or hot sauce to cut through the rich sausage drippings.',
    ),
  ],
);
