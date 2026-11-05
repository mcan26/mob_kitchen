import 'dart:convert';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

import '../../profile/domain/entities/personal_taste_profile.dart';
import '../../recipes/domain/entities/recipe.dart';
import '../domain/services/gemini_recipe_service.dart';
import 'api_key_repository.dart';
import 'gemini_schemas.dart';

import 'package:http/http.dart' as http;

class GeminiRecipeServiceImpl implements GeminiRecipeService {
  GeminiRecipeServiceImpl({
    required ApiKeyRepository apiKeyRepository,
    required PersonalTasteProfile Function() getTasteProfile,
    String modelName = 'gemini-2.5-flash',
    http.Client? httpClient,
  })  : _apiKeyRepo = apiKeyRepository,
        _getTasteProfile = getTasteProfile,
        _modelName = modelName,
        _httpClient = httpClient;

  final ApiKeyRepository _apiKeyRepo;
  final PersonalTasteProfile Function() _getTasteProfile;
  final String _modelName;
  final http.Client? _httpClient;
  final Uuid _uuid = const Uuid();

  GenerativeModel _createModel({
    required GenerationConfig config,
    required String systemPrompt,
  }) {
    final apiKey = _apiKeyRepo.getApiKey();
    if (apiKey.isEmpty) {
      throw StateError(
        'Gemini API key is not configured. Please provide a valid key in settings or via '
        '--dart-define=GEMINI_API_KEY=...',
      );
    }

    final systemInstruction = Content.system(systemPrompt);

    return GenerativeModel(
      model: _modelName,
      apiKey: apiKey,
      systemInstruction: systemInstruction,
      generationConfig: config,
      httpClient: _httpClient,
    );
  }

  @override
  Future<Recipe> generateRecipeFromPantry({
    required List<String> ingredients,
    Uint8List? imageBytes,
    String? mimeType,
    String? additionalPrompt,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.7,
      ),
    );

    final parts = <Part>[];
    final userPrompt = StringBuffer();
    if (ingredients.isNotEmpty) {
      userPrompt
        ..writeln('Available ingredients in my kitchen:')
        ..writeln(ingredients.map((e) => '- $e').join('\n'));
    } else if (imageBytes != null && imageBytes.isNotEmpty) {
      userPrompt.writeln(
        'Identify all edible ingredients visible in this fridge / countertop / pantry photograph.',
      );
    }

    if (additionalPrompt != null && additionalPrompt.trim().isNotEmpty) {
      userPrompt.writeln('\nSpecial request / culinary focus: ${additionalPrompt.trim()}');
    }
    userPrompt.writeln(
      '\nBased on these ingredients (and any items in the photo), complete pantry staples '
      '(salt, oil, flour, spices, etc.) thoughtfully, creating a vibrant, delicious, '
      'SimmerLink-style meal with rich textures and deep flavor.',
    );

    parts.add(TextPart(userPrompt.toString()));

    if (imageBytes != null && imageBytes.isNotEmpty) {
      parts.add(DataPart(mimeType ?? 'image/jpeg', imageBytes));
    }

    final response = await model.generateContent([Content.multi(parts)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API returned an empty response.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'ai_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<Recipe> remixRecipe({
    required Recipe sourceRecipe,
    required String remixInstruction,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.6,
      ),
    );

    final sourceJsonStr = jsonEncode(sourceRecipe.toJson());
    final prompt = '''
Re-imagine and customize an existing SimmerLink recipe according to user preferences (AI Remix).

ORIGINAL SOURCE RECIPE:
$sourceJsonStr

USER'S REMIX INSTRUCTION:
"$remixInstruction"

MISSION:
1. Preserve the soul and flavor harmony of the original dish while fully complying with the user's constraints.
2. Update ingredient quantities, supermarket aisles, buying tips, and substitute options.
3. Rewrite the steps to match the adapted technique (e.g. if switching from oven to pan, adjust timings, sensory cues, and chef tips accordingly).
4. Revise chef golden rules (chef_golden_rules) for the new technique.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API returned an empty response.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'remix_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      sourceRecipeId: sourceRecipe.id,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<String> askSousChef({
    required Recipe currentRecipe,
    required int currentStepNumber,
    required String question,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = '''
You are the veteran Sous-Chef at SimmerLink, standing right next to the user in the kitchen.
User equipment available: ${profile.equipment.map((e) => e.label).join(', ')}.
The user is actively cooking right now with sauce simmering or food in the hot pan!
Your answers must:
- Be fast, practical, and immediately actionable (at most 2-4 short sentences).
- Prevent panic with real kitchen chemistry (e.g., if sauce broke add 1 tbsp cold liquid, if meat stuck wait 30 seconds for Maillard release).
- Focus 100% on the solution; no fluff, verbose greetings, or filler.
''';

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        temperature: 0.4,
      ),
    );

    final step = currentRecipe.steps.firstWhere(
      (s) => s.stepNumber == currentStepNumber,
      orElse: () => currentRecipe.steps.first,
    );

    final prompt = '''
Current Recipe: "${currentRecipe.title}"
User's Current Step (#${step.stepNumber} - ${step.title}):
Instruction: "${step.instruction}"
Sensory Cue: "${step.sensoryCue}"
Chef Tip: "${step.chefTip}"

User's Urgent Kitchen Question:
"$question"

Explain exactly what they should do right now:
''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? 'Lower heat slightly, check pan liquid level, and stir gently.';
  }

  @override
  Future<Recipe> importRecipeFromSocialOrText({
    required String urlOrText,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.5,
      ),
    );

    final prompt = '''
The user wants to import a recipe from social media (Instagram Reels, TikTok, YouTube Shorts), food blog URL, or raw text.

USER INPUT:
"""
${urlOrText.trim()}
"""

MISSION:
1. Analyze the dish, ingredients, ratios, and cooking steps. Fill in any missing metric grammages or timings with professional chef knowledge.
2. Comply strictly with user kitchen equipment and allergy restrictions.
3. Supply sensory cues, chef tips, and timer_seconds for timed cooking steps.
4. Categorize all ingredients into appropriate aisle_category with buying tips and substitute options.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API returned an empty response.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'social_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      createdAt: DateTime.now(),
    );
  }

  static String _buildChefSystemPrompt(PersonalTasteProfile profile) {
    final buffer = StringBuffer()
      ..writeln('You are the Lead Culinary R&D Chef at "SimmerLink".')
      ..writeln('Your recipes are always: bold, generously sauced, texture-contrasted (crispy/silky), weeknight-friendly, and packed with umami.')
      ..writeln('Never output dry instructions; always include sensory cues (when is it ready?) and chef tips (why this technique works).')
      ..writeln('\nUSER PERSONAL KITCHEN PROFILE & MANDATORY RESTRICTIONS:');

    // Equipment constraints
    final eqLabels = profile.equipment.map((e) => e.label).join(', ');
    buffer.writeln('- Available Equipment: $eqLabels');
    if (!profile.hasOven) {
      buffer.writeln('  * CRITICAL: User has NO OVEN! NEVER suggest recipes requiring baking; all cooking must conclude on stovetop, pan, pot, or air fryer.');
    }

    // Dietary goals
    if (profile.dietGoals.isNotEmpty) {
      buffer.writeln('- Dietary Goals: ${profile.dietGoals.join(', ')}');
    }

    // Allergies
    if (profile.allergies.isNotEmpty) {
      buffer.writeln('- ALLERGIES (STRICTLY FORBIDDEN, VITAL SAFETY HAZARD): ${profile.allergies.join(', ')}');
    }

    // Dislikes
    if (profile.dislikedIngredients.isNotEmpty) {
      buffer.writeln('- Disliked Ingredients (DO NOT USE): ${profile.dislikedIngredients.join(', ')}');
    }

    // Spice tolerance
    final spiceDesc = switch (profile.spiceLevel) {
      0 => 'Zero heat (no chili peppers or hot spices)',
      1 => 'Mild heat',
      2 => 'Medium / balanced kick',
      _ => 'High spice tolerance (bold chili heat welcome)',
    };
    buffer.writeln('- Spice Level: $spiceDesc');

    if (profile.extraNotes.isNotEmpty) {
      buffer.writeln('- Personal Notes: ${profile.extraNotes}');
    }

    buffer.writeln('\nAlways output all recipe text in English. Select measurement units and aisle categories strictly from allowed enum schemas.');
    return buffer.toString();
  }
}
