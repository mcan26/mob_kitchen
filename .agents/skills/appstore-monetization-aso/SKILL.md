---
name: appstore-monetization-aso
description: >-
  Use this skill when planning or implementing App Store submission, Apple Review
  Guideline compliance, In-App Purchases (RevenueCat / StoreKit 2), paywalls,
  viral growth loops, ASO metadata, or branding for Mob Kitchen.
---

# App Store Monetization, ASO & Compliance Skill

Use this runbook to turn the application into a profitable, App Store-compliant consumer subscription product.

## 1. Critical App Store Review Blockers to Avoid
1. **Trademark & Brand Identity (Guideline 5.2 / IP)**:
   - "Mob Kitchen" is a registered UK food media brand (`mob.co.uk`). Submitting to the App Store under the exact name `Mob Kitchen` risks immediate rejection under Guideline 5.2 (Intellectual Property).
   - **Action**: Use an original brand name for App Store distribution (e.g., *Sote*, *MutfakAI*, *Şefim*, *Kiler*, *Tava*, *Sous*) while keeping the "bold, saucy, weeknight culinary" DNA.
2. **No "Bring Your Own API Key" for Consumer Apps (Guideline 2.1 / 4.2)**:
   - Normal consumers do not know what a `GEMINI_API_KEY` is, and Apple reviewers reject consumer apps that require users to generate developer API keys to function.
   - **Action**: Route AI requests through a lightweight backend proxy (Cloudflare Workers / Supabase Edge Functions / Firebase Vertex AI) authenticated with Firebase App Check / DeviceCheck.
3. **AI Data Privacy Disclosure (Guideline 5.1.1(i) & 5.1.2)**:
   - Disclose in the Privacy Policy and before the first AI photo/prompt upload that ingredient/photo data is processed by Google Gemini AI to generate recipes.
4. **In-App Purchases (Guideline 3.1.1)**:
   - Digital unlocks (AI Pantry Generator, AI Remix, Live Sous-Chef, Social Video Import) must use Apple StoreKit 2 / RevenueCat (`purchases_flutter`). Always include a visible **"Satın Alımları Geri Yükle" (Restore Purchases)** button, Terms of Use (EULA), and Privacy Policy links on the paywall.

## 2. Freemium & Subscription Architecture ("Chef Pro")
- **Free Tier (Hook & Habit)**:
  - Built-in curated signature recipes + Portion Scaler (`PortionScaler`).
  - Basic Supermarket list for up to 2 recipes at a time.
  - **1–3 Free AI Credits** during onboarding so the user experiences the "Aha! Moment" (Fridge photo -> custom recipe or AI Remix) before hitting the paywall.
- **Pro Tier (Weekly / Monthly / Annual Subscription)**:
  - **Unlimited AI Pantry & Fridge Vision** (Fotoğraftan Tarif).
  - **TikTok / Instagram Reels / YouTube Shorts URL Recipe Importer** (Number #1 conversion driver in the recipe category).
  - **Unlimited AI Remix** ("Fırınsız yap", "Proteini artır", "Bütçe dostu yap").
  - **Live Sous-Chef Assistant** in Cook Mode + Voice Hands-Free Control.
  - **Smart Weekly Meal Planner & Unlimited Aisle Aggregator**.
- **Pricing Psychology**:
  - Offer an **Annual Plan with 3-day or 7-day Free Trial** (e.g., $29.99/yr or ₺499/yr) anchored against a Monthly Plan ($4.99/mo or ₺79.99/mo).

## 3. Viral Growth & Retention Loops
- **Social Recipe Import (Share Extension)**: Let users share a TikTok/Instagram food video directly to the app; extract ingredients, macros, and steps into the local Drift database.
- **"I Cooked This" Share Card**: At the end of [`CookModeScreen`](file:///Users/can/Desktop/mob_kitchen/lib/features/cooking/presentation/cook_mode_screen.dart), let the user snap a photo of their dish and generate an Instagram Story card with macro badges and recipe title.
