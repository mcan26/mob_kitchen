---
name: gemini-culinary-ai-architect
description: >-
  Use this skill when working on Gemini AI features, multimodal fridge/pantry
  image recognition, social video/URL recipe parsing, Sous-Chef prompts, or
  structured JSON output schemas in `lib/features/ai/`.
---

# Gemini Culinary AI Architecture Skill

This skill governs all AI capabilities in [`lib/features/ai/`](file:///Users/can/Desktop/mob_kitchen/lib/features/ai/data/gemini_recipe_service_impl.dart).

## 1. Multimodal Fridge & Pantry Vision (`image_picker` -> `DataPart`)
Note: `pubspec.yaml` already includes `image_picker` and `GeminiRecipeService.generateRecipeFromPantry` already accepts `Uint8List? imageBytes` and `String? mimeType`, but [`PantryGeneratorScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/ai/presentation/pantry_generator_screen.dart) currently only exposes text input!
- **Workflow for Fridge Vision**:
  1. Allow users to snap a photo of their open fridge, pantry shelf, or supermarket receipt using `ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1280, imageQuality: 80)`.
  2. Resize/compress images on device (`maxWidth: 1280`, JPEG 80%) before sending to Gemini to minimize token usage and latency (<3s response).
  3. Pass `imageBytes` + `image/jpeg` to `generateRecipeFromPantry` or an intermediate ingredient-detection step so users can confirm detected items before recipe generation.

## 2. Allergen & Equipment Safety Guardrails
- Always inject [`PersonalTasteProfile`](file:///Users/can/Desktop/mob_kitchen/lib/features/profile/domain/entities/personal_taste_profile.dart) into system instructions.
- Perform a **post-generation deterministic check** in Dart: verify that none of `profile.allergies` appear in the returned `recipe.ingredients` list. If a match is found, surface a prominent safety warning badge or auto-regenerate.

## 3. Culinary Chemistry & Sensory Prompting
Every AI-generated or remixed recipe must include:
- **`sensoryCue`**: Visual, auditory, or olfactory cues (e.g., *"Sarımsaklar altın sarısı olup kokusu çıkana kadar, yakmadan 45 sn"*), never just raw minutes.
- **`chefTip`**: The *why* behind the step (emulsification with starchy pasta water, Maillard reaction on dry meat surface, deglazing fond).
- **`mistakeWarning`**: Common failure modes for tricky steps.
- **`buyingTip` & `substituteOption`**: Local supermarket equivalents (e.g., Guanciale -> Dana Bacon / Pastırma, Pecorino -> Eski Kaşar / İzmir Tulumu).

## 4. Production Security (Moving Off Client-Side API Keys)
- Keep `ApiKeyRepository` for local development (`--dart-define=GEMINI_API_KEY=...`), but in production release builds (`kReleaseMode`), route requests through an authenticated backend endpoint with per-user daily quota enforcement.
