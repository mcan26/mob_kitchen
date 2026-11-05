---
name: culinary-ux-design-system
description: >-
  Use this skill when designing, critiquing, or building UI/UX screens, widgets,
  animations, onboarding flows, or kitchen-ergonomic interfaces (Cook Mode,
  Supermarket Mode, Recipe Cards) for Mob Kitchen.
---

# Culinary UI/UX & Kitchen Ergonomics Skill

This skill defines the design standards required to make a recipe and kitchen assistant app compete with Apple Design Award winners (NYT Cooking, Crouton, ReciMe, Mob).

## 1. Visual Appetite & Editorial Hierarchy (`MobColors` & `MobTheme`)
- **Never Ship Icon-Only Hero Cards in Production**: Food is bought with the eyes. Every [`Recipe`](file:///Users/can/Desktop/mob_kitchen/lib/features/recipes/domain/entities/recipe.dart) card and detail header must support high-resolution food photography (`imageUrl` / local asset) with a warm dark vignette overlay (`LinearGradient` from transparent to `#121214`) so typography remains high-contrast.
- **Typography**: Use `Plus Jakarta Sans` with tight letter-spacing (`-0.4` to `-0.8`) for display titles and generous line-height (`1.5`–`1.6`) for cooking instructions.
- **Color Semantics**:
  - `MobColors.primary` (`#E84A27` Chili Orange): Primary CTAs, active timers, appetite triggers.
  - `MobColors.gold` (`#F5A623` Egg Yolk Gold): Chef's Golden Rules, Sous-Chef tips, sensory cues.
  - `MobColors.green` (`#27AE60` Fresh Herb Green): Completed steps, checked supermarket items, dietary safety badges.

## 2. Wet-Hand / Distance Kitchen Ergonomics (`CookModeScreen`)
When the user is in [`CookModeScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/cooking/presentation/cook_mode_screen.dart), assume **their hands are covered in flour, oil, or raw chicken** and the phone is **60–90 cm away on the counter**:
1. **Countertop Legibility**: Step instructions must be at least `18sp–20sp`, with inline ingredient pills (`_InStepIngredientsBar`) scaled dynamically to the user's selected `targetServings` (never hardcoded to `baseServings`).
2. **Large Tap Targets**: Minimum `56dp` height for Next/Prev/Timer buttons.
3. **Tactile & Audio Feedback**: Trigger `HapticFeedback.lightImpact()` on step transitions, `HapticFeedback.mediumImpact()` on ingredient check-off, and persistent alarm + local notification when a timer finishes.
4. **Hands-Free Progression**: Support voice commands (Speech-to-Text / TTS read-aloud) or proximity/air gestures where possible.

## 3. Supermarket Mode UX (`SupermarketScreen`)
In [`SupermarketScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/shopping/presentation/supermarket_screen.dart), the user is walking through aisles with one hand holding a basket:
- **One-Thumb Checkoff**: Smooth strikethrough animation + `HapticFeedback.selectionClick()`.
- **Auto-Collapse Completed Aisles**: Visually dim completed aisles (`checkedInAisle == items.length`) so the user immediately sees the next aisle.
- **Custom Quick-Add**: Allow users to type arbitrary non-recipe items (e.g., "Kağıt Havlu", "Süt") directly into the shopping list.

## 4. High-Converting Onboarding & Taste Profile Flow
First-time users should never land on a cold screen without personalization:
- **Interactive 4-Step Taste Quiz**:
  1. *What equipment do you have?* (Airfryer, Fırın, Tava, Blender...)
  2. *Any allergies or hated ingredients?* (Kişniş, Gluten, Laktoz...)
  3. *What's your weekday goal?* (≤20 dk Hızlı, Yüksek Protein, Bütçe Dostu)
  4. *How many people are you cooking for?* (1, 2, 4+)
- Persist directly into [`PersonalTasteProfile`](file:///Users/can/Desktop/mob_kitchen/lib/features/profile/domain/entities/personal_taste_profile.dart) via `ProfileRepository`.
