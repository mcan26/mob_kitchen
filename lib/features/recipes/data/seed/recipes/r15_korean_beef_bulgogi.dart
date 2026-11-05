import '../../../../../core/domain/aisle_category.dart';
import '../../../../../core/domain/measurement_unit.dart';
import '../../../domain/entities/macros.dart';
import '../../../domain/entities/recipe.dart';
import '../../../domain/entities/recipe_enums.dart';
import '../../../domain/entities/recipe_ingredient.dart';
import '../../../domain/entities/recipe_step.dart';

const Recipe mobKoreanBeefBulgogi = Recipe(
  id: 'mob_classic_015',
  title: 'Korean Sesame Beef Bulgogi Rice Bowl',
  subtitle: 'Paper-thin marinated beef caramelized with sweet pear, soy, toasted sesame oil, and crunchy kimchi.',
  category: RecipeCategory.quickDinner,
  prepTimeMinutes: 10,
  cookTimeMinutes: 8,
  baseServings: 2,
  difficulty: Difficulty.easy,
  macros: Macros(kcal: 710, proteinG: 45, carbsG: 65, fatG: 30),
  tags: ['Korean', 'Bulgogi', 'Beef', 'Rice Bowl', '15-Minute', 'High-Protein'],
  chefGoldenRules: [
    'Freeze your beef for 20 minutes before slicing; firm chilled meat allows you to carve wafer-thin, translucent ribbons.',
    'Grated Asian pear contains natural proteolytic enzymes (calpain) that tenderize beef fibers into melt-in-your-mouth tenderness.',
    'Sear in a scorching hot cast-iron pan in single uncrowded batches so the sweet soy glaze caramelizes into charred smoky edges rather than boiling.',
  ],
  storageAndReheatingTip:
      'Raw marinated beef keeps in an airtight container in the fridge for up to 24 hours, or in the freezer for 1 month. Cooked beef keeps refrigerated for up to 3 days; flash-sear in a hot pan for 90 seconds to preserve tenderness.',
  ingredients: [
    RecipeIngredient(
      name: 'Beef ribeye, sirloin, or flank steak',
      amount: 300,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.butcherDeli,
      preparationNote: 'sliced wafer-thin against the grain',
      buyingTip: 'Well-marbled ribeye or sirloin yields the juiciest bulgogi; pre-sliced "shabu-shabu" beef also saves slicing time.',
      substituteOption: 'Thinly sliced pork loin, chicken thighs, or king oyster mushrooms.',
    ),
    RecipeIngredient(
      name: 'Asian pear or Bosc pear',
      amount: 0.5,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'peeled and grated',
      buyingTip: 'Crisp Asian pears possess natural tenderizing enzymes; sweet Gala or Bosc apples work equally well.',
      substituteOption: '1/2 grated sweet apple, kiwi fruit (use sparingly), or 1 tbsp brown sugar with grated pineapple.',
    ),
    RecipeIngredient(
      name: 'Soy sauce',
      amount: 3,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Naturally brewed low-sodium soy sauce delivers savory umami without harsh saltiness.',
      substituteOption: 'Tamari (gluten-free) or coconut aminos.',
    ),
    RecipeIngredient(
      name: 'Toasted sesame oil',
      amount: 1.5,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Dark amber Korean toasted sesame oil provides rich, roasty aromatic perfume.',
    ),
    RecipeIngredient(
      name: 'Brown sugar',
      amount: 1,
      unit: MeasurementUnit.tablespoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Soft dark or light brown sugar assists rapid pan caramelization and smoky charred spots.',
      substituteOption: 'Honey or maple syrup.',
    ),
    RecipeIngredient(
      name: 'Garlic',
      amount: 4,
      unit: MeasurementUnit.clove,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely grated or minced',
      buyingTip: 'Fresh tight heads with unblemished cloves.',
    ),
    RecipeIngredient(
      name: 'Fresh ginger',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'finely grated',
      buyingTip: 'Plump ginger rhizome with smooth taut skin.',
    ),
    RecipeIngredient(
      name: 'Scallions / Spring onions',
      amount: 3,
      unit: MeasurementUnit.piece,
      aisleCategory: AisleCategory.produce,
      preparationNote: 'cut into 4 cm batons',
      buyingTip: 'Crisp green stalks and firm white bulbs.',
    ),
    RecipeIngredient(
      name: 'Steamed short-grain rice',
      amount: 160,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Short-grain or medium-grain sushi rice provides sticky, tender grains ideal for catching savory beef sauce.',
    ),
    RecipeIngredient(
      name: 'Toasted sesame seeds',
      amount: 1,
      unit: MeasurementUnit.teaspoon,
      aisleCategory: AisleCategory.pantry,
      buyingTip: 'Golden toasted seeds for nutty crunch and aromatic garnish.',
    ),
    RecipeIngredient(
      name: 'Kimchi (for serving)',
      amount: 80,
      unit: MeasurementUnit.gram,
      aisleCategory: AisleCategory.produce,
      buyingTip: 'Naturally fermented sour, spicy Napa cabbage kimchi to cut through rich beef fat.',
    ),
  ],
  steps: [
    RecipeStep(
      stepNumber: 1,
      title: 'Whisk bulgogi marinade',
      instruction:
          'In a medium bowl, combine grated pear, soy sauce, toasted sesame oil, brown sugar, grated garlic, grated ginger, and black pepper. Whisk until sugar is completely dissolved.',
      sensoryCue: 'The marinade is dark, glistening, and releases an enticing sweet toasted sesame and garlic aroma.',
      chefTip: 'The grated pear acts as a natural enzymatic meat tenderizer while adding delicate natural sweetness.',
    ),
    RecipeStep(
      stepNumber: 2,
      title: 'Marinate beef ribbons',
      instruction:
          'Tumble wafer-thin beef slices and scallion batons into the marinade. Massage with clean hands for 30 seconds to ensure every slice is coated. Let rest for 10 minutes at room temperature.',
      sensoryCue: 'Beef absorbs the glossy dark marinade, relaxing into tender, succulent ribbons.',
      chefTip: 'Because the beef is sliced paper-thin, 10 minutes of marinating is plenty of time for full flavor penetration.',
      timerSeconds: 600,
    ),
    RecipeStep(
      stepNumber: 3,
      title: 'Get the skillet smoking hot',
      instruction:
          'Set a large cast-iron skillet or heavy grill pan over high heat for 3 minutes until wisps of smoke rise. Lightly brush with a paper towel dipped in neutral oil.',
      sensoryCue: 'Dry heat radiates intensely from the skillet and flicked water drops instantly vaporize.',
      chefTip: 'High heat is mandatory: thin bulgogi beef cooks in under 3 minutes; high heat produces delicious char without overcooking.',
      timerSeconds: 180,
      mistakeWarning: 'Never crowd the pan; cook in two rapid batches to avoid steaming the meat.',
    ),
    RecipeStep(
      stepNumber: 4,
      title: 'Flash-sear and caramelize',
      instruction:
          'Lay half the marinated beef across the smoking skillet in a single flat layer. Cook undisturbed for 90 seconds until charred on the underside, then toss briskly for 60 seconds. Repeat with second batch.',
      sensoryCue: 'Violent sizzling erupts; sugar and soy caramelize into dark, appetizing charred edges and smoky barbecue aroma.',
      chefTip: 'Letting the beef sit flat without stirring at first creates authentic wok-hei or barbecue char marks.',
      timerSeconds: 150,
    ),
    RecipeStep(
      stepNumber: 5,
      title: 'Assemble bulgogi bowls',
      instruction:
          'Scoop warm steamed rice into wide bowls. Arrange caramelized beef and scallions over half the bowl, place crunchy chilled kimchi on the side, and dust generously with toasted sesame seeds.',
      sensoryCue: 'Piping hot caramelized beef meets cool, tangy, fizzy kimchi and warm, sticky rice.',
      chefTip: 'Wrap a forkful of beef, rice, and kimchi together for the ultimate balanced balance of sweet, savory, and spicy crunch.',
    ),
  ],
);
