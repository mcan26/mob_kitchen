import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobSmashBurger = Recipe(
  id: 'mob_classic_010',
  title: 'Crispy Double Smash Cheeseburger with Secret Sauce',
  subtitle: 'No grill needed. Cast-iron smashed patties with paper-thin lace edges, molten cheddar, and tangy secret burger sauce.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 10,
  cookTimeMinutes: 12,
  baseServings: 2,
  difficulty: Difficulty.medium,
  macros: Macros(kcal: 820, proteinG: 48, carbsG: 52, fatG: 46),
  tags: ['Smash Burger', '20-Minute Dinner', 'Cast Iron', 'Ground Beef', 'Weekend Comfort'],
  chefGoldenRules: [
    'Get the cast-iron skillet smoking hot before adding the beef: extreme contact heat and heavy downward smashing build the prized crispy lacy crust.',
    'Smash the cold beef balls paper-thin immediately upon hitting the pan, then leave completely untouched until ready for a single decisive scrape-and-flip.',
    'Never knead or overwork the ground beef; keep it cold and loose so patties stay tender and succulent rather than dense and tough.',
  ],
  storageAndReheatingTip:
      'Smash burgers are best eaten piping hot from the skillet. Cooked patties keep in the fridge for up to 2 days; reheat in a dry hot pan for 1 minute per side. The secret sauce keeps refrigerated for 5 days.',
  ingredients: [
    RecipeIngredient(
      name: '80/20 Ground beef chuck',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'portioned into 4 loose balls (75 g each)',
      buyingTip: 'High fat content (80/20 ground chuck) is essential; lean beef will dry out and lack the fat needed to fry crispy lacy edges.',
      substituteOption: 'Ground brisket and chuck blend, or 85/15 beef with a dab of cold butter in each ball.',
    ),
    RecipeIngredient(
      name: 'Brioche hamburger buns',
      amount: 2,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.bakery,
      buyingTip: 'Choose soft, golden, slightly sweet brioche or potato buns; crusty hard rolls overpower the delicate crispy patties.',
      substituteOption: 'Soft potato rolls or toasted square brioche bread.',
    ),
    RecipeIngredient(
      name: 'American or Cheddar cheese slices',
      amount: 4,
      unit: MeasurementUnit.slice,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'Pick authentic melting American cheese or young mild cheddar slices that melt smoothly without separating into oil.',
      substituteOption: 'Sharp white cheddar, Monterey Jack, or mild provolone slices.',
    ),
    RecipeIngredient(
      name: 'Yellow onion',
      amount: 1,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'shaved paper-thin into translucent rings',
      buyingTip: 'Select a firm, heavy yellow onion with dry paper skin.',
    ),
    RecipeIngredient(
      name: 'Dill pickle slices',
      amount: 4,
      unit: MeasurementUnit.slice,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Choose crisp, tangy dill pickle chips; sharp acidity cuts through rich beef drippings.',
      substituteOption: 'Bread & butter sweet pickles or pickled jalapeño rings.',
    ),
    RecipeIngredient(
      name: 'Crisp iceberg lettuce',
      amount: 4,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'leaves washed, dried, and torn to bun size',
      buyingTip: 'Look for tight, heavy heads of iceberg with cold, shatteringly crisp leaves.',
      substituteOption: 'Romaine lettuce hearts or peppery baby arugula.',
    ),
    RecipeIngredient(
      name: 'Mayonnaise',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Whole egg rich mayonnaise provides the velvety base for the secret burger sauce.',
      substituteOption: 'Thick Greek yogurt for a lighter, tangier sauce.',
    ),
    RecipeIngredient(
      name: 'Ketchup',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
    ),
    RecipeIngredient(
      name: 'Yellow or Dijon mustard',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Classic yellow ballpark mustard provides signature burger shack tang.',
    ),
    RecipeIngredient(
      name: 'Fine sea salt',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Freshly cracked black pepper',
      amount: 0.5,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.spices,
    ),
    RecipeIngredient(
      name: 'Unsalted butter',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.dairy,
      buyingTip: 'High-fat pure butter ensures a golden-brown toasted barrier on the buns.',
      substituteOption: 'A thin smear of mayonnaise on the cut bun surfaces before toasting.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Whisk secret sauce & shape patties',
      instruction:
          'In a bowl, stir together mayonnaise, ketchup, mustard, and 1 tablespoon of pickle brine. Thinly slice the onion, pickles, and lettuce. Divide ground beef into 4 loose 75 g balls; do not season yet. Keep cold in the fridge.',
      sensoryCue: 'The secret sauce is salmon-pink, glossy, and spoonable; beef balls are cold, airy, and gently shaped without compression.',
      chefTip: 'Why season later? Salt draws moisture from raw ground beef and dissolves proteins into a sausage-like bounce; we want tender, crumbly steak texture.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Toast the buns golden',
      instruction:
          'Melt butter in a cast-iron skillet over medium heat. Place buns cut-side down and toast for 60 seconds until deep golden. Transfer to plates and keep the skillet on the heat.',
      sensoryCue: 'Bun surfaces turn golden-brown with a light, buttery crunch that protects bread from getting soggy.',
      chefTip: 'Toasted bun surfaces act as a moisture barrier preventing sauce and meat juices from making the bread soggy.',
      timerSeconds: 60,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Heat cast iron until smoking',
      instruction: 'Crank heat to the highest setting for 3-4 minutes until faint wisps of smoke rise from the skillet. Do not add oil.',
      sensoryCue: 'A drop of water flicked onto the pan vaporizes instantly with a sharp hiss; dry heat radiates intensely.',
      chefTip: 'Why dry and blazing hot? Beef fat renders instantly to lubricate the pan, while extreme heat produces immediate deep caramelization.',
      timerSeconds: 210,
      mistakeWarning: 'If the pan isn\'t smoking hot, the beef will steam in its juices and turn grey instead of developing a crust.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Smash and sear lace edges',
      instruction:
          'Place two beef balls into the smoking skillet. Top each with parchment paper and press down with maximum force using a heavy metal spatula for 10 seconds until paper-thin with ragged edges. Discard paper. Season generously with salt and pepper. Cook undisturbed for 90 seconds.',
      sensoryCue: 'Loud violent sizzling crackles as lacy edges crisp into dark mahogany; small beads of moisture appear on top.',
      chefTip: 'Heavy smashing maximizes surface contact with the pan, unleashing intense Maillard browning and crispy lace fringes.',
      timerSeconds: 100,
      mistakeWarning: 'Never smash again after the initial press; subsequent pressing squeezes out trapped savory juices.',
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Scrape, flip & melt cheese',
      instruction:
          'Slide a sharp spatula firmly under the patty, scraping every bit of browned crust off the pan floor, and flip. Immediately crown with a cheese slice. Cook for 30-45 seconds until cheese softens and melts down the sides.',
      sensoryCue: 'The flipped side displays an even, crackling dark bronze crust; cheese drapes smoothly over the hot ridges.',
      chefTip: 'Scrape aggressively: that browned crust stuck to the pan contains the most concentrated umami flavor.',
      timerSeconds: 45,
    ),
    RecipeStep(
      stepNumber: 6,
      title: 'Stack and serve double burger',
      instruction:
          'Spread secret sauce on both bun halves. Layer bottom bun with crisp iceberg lettuce, sliced pickles, and shaved onions. Stack two cheesy patties on top, crown with the toasted bun top, and serve immediately.',
      sensoryCue: 'Warm melted cheese drapes down crispy charred edges, contrasting with cool crisp lettuce and buttery toasted brioche.',
      chefTip: 'Placing lettuce beneath the patties creates a crisp barrier that stops hot beef drippings from softening the bottom bun.',
    ),
  ],
);
