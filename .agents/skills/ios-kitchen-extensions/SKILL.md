---
name: ios-kitchen-extensions
description: >-
  Use this skill when implementing iOS-native differentiating features such as
  Dynamic Island / Live Activities for cooking timers, iOS Share Extension for
  importing recipes from TikTok/Instagram Reels, Home Screen Widgets, or voice
  hands-free controls.
---

# iOS Native Kitchen Extensions Skill

In the App Store Food & Drink category, deep iOS platform integration is the #1 differentiator that earns **Apple Editorial Featuring ("App of the Day")** and drives high subscription conversion.

## 1. Dynamic Island & Lock Screen Live Activities (`ActivityKit`)
When a user starts a timer in [`CookModeScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/cooking/presentation/cook_mode_screen.dart):
- Surface the active step title, sensory cue, and countdown timer in the **iOS Dynamic Island** and **Lock Screen Live Activity**.
- Why it matters: Users lock their phones or switch to music/podcasts while cooking. Seeing *"Adım 3: Guanciale Çıtırdatma — 02:45"* live on the Lock Screen makes the app feel magical and indispensable.

## 2. iOS Share Sheet Extension (TikTok / Instagram Reels / Web Importer)
Users discover 80% of new recipes on TikTok, Instagram Reels, and YouTube Shorts, where recipes get buried in "Saved" folders and are never cooked:
- Register an iOS Share Extension (`NSExtensionActivationSupportsWebURLWithMaxCount`).
- When a user shares a Reel/TikTok/Web link to the app:
  1. Fetch the post caption / oEmbed metadata / transcript.
  2. Pass it to Gemini with `GeminiSchemas.recipeSchema` to convert unstructured social captions into a full structured `Recipe` (with `buyingTip`, `sensoryCue`, `chefTip`, and `AisleCategory`).
  3. Save directly to the local Drift SQLite database and open `RecipeDetailScreen`.

## 3. Hands-Free Voice Control in `CookModeScreen`
When cooking with messy hands:
- Use `speech_to_text` + `flutter_tts` for hands-free commands:
  - *"Sonraki adım"* -> `_nextStep()`
  - *"Tekrar oku"* -> Reads `step.instruction` + `step.sensoryCue` aloud
  - *"Sayacı başlat"* -> Starts step timer
  - *"Şefe sor: ..."* -> Sends voice query directly to `askSousChef()` and speaks the 2-sentence answer back!
