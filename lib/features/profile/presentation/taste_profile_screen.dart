import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/mob_colors.dart';
import '../../ai/providers/ai_providers.dart';
import '../../subscription/presentation/chef_pro_paywall_sheet.dart';
import '../../subscription/providers/subscription_providers.dart';
import '../domain/entities/personal_taste_profile.dart';
import '../providers/profile_providers.dart';

/// Kullanıcının mutfak ekipmanlarını, beslenme hedeflerini, alerjilerini,
/// acı seviyesini ve Gemini AI bağlantısını yönettiği Kişisel Mutfak Profili ekranı.
class TasteProfileScreen extends ConsumerStatefulWidget {
  const TasteProfileScreen({super.key});

  @override
  ConsumerState<TasteProfileScreen> createState() => _TasteProfileScreenState();
}

class _TasteProfileScreenState extends ConsumerState<TasteProfileScreen> {
  late Set<KitchenEquipment> _equipment;
  late List<String> _dietGoals;
  late List<String> _allergies;
  late List<String> _disliked;
  late int _spiceLevel;
  late int _defaultServings;
  late final TextEditingController _extraNotesController;
  late final TextEditingController _apiKeyController;
  final TextEditingController _allergyInputController = TextEditingController();
  final TextEditingController _dislikedInputController = TextEditingController();

  static const _availableDietGoals = [
    'High-Protein',
    'Quick (≤ 20 min)',
    'Budget-Friendly',
    'Low-Carb',
    'One-Pan / Easy Cleanup',
    'Balanced Comfort Food',
  ];

  static const _commonAllergies = [
    'Gluten',
    'Dairy / Lactose',
    'Peanuts / Tree Nuts',
    'Eggs',
    'Shellfish & Seafood',
    'Soy',
  ];

  static const _commonDislikes = [
    'Coriander / Cilantro',
    'Mushrooms',
    'Celery',
    'Okra',
    'Offal',
    'Dill',
  ];

  @override
  void initState() {
    super.initState();
    final initial = ref.read(personalTasteProfileProvider);
    _equipment = Set<KitchenEquipment>.from(initial.equipment);
    _dietGoals = List<String>.from(initial.dietGoals);
    _allergies = List<String>.from(initial.allergies);
    _disliked = List<String>.from(initial.dislikedIngredients);
    _spiceLevel = initial.spiceLevel;
    _defaultServings = initial.defaultServings;
    _extraNotesController = TextEditingController(text: initial.extraNotes);
    _apiKeyController = TextEditingController();
  }

  @override
  void dispose() {
    _extraNotesController.dispose();
    _apiKeyController.dispose();
    _allergyInputController.dispose();
    _dislikedInputController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    final updated = PersonalTasteProfile(
      equipment: _equipment,
      dietGoals: _dietGoals,
      allergies: _allergies,
      dislikedIngredients: _disliked,
      spiceLevel: _spiceLevel,
      defaultServings: _defaultServings,
      extraNotes: _extraNotesController.text.trim(),
    );

    await ref.read(personalTasteProfileProvider.notifier).update(updated);

    if (_apiKeyController.text.trim().isNotEmpty) {
      await ref.read(activeApiKeyProvider.notifier).setCustomKey(_apiKeyController.text.trim());
      _apiKeyController.clear();
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kitchen profile and preferences saved!'),
          backgroundColor: MobColors.green,
        ),
      );
    }
  }

  void _toggleStringItem(List<String> list, String value) {
    setState(() {
      if (list.any((e) => e.toLowerCase() == value.toLowerCase())) {
        list.removeWhere((e) => e.toLowerCase() == value.toLowerCase());
      } else {
        list.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);
    final apiKeyRepo = ref.watch(apiKeyRepositoryProvider);
    ref.watch(activeApiKeyProvider);

    return Scaffold(
      backgroundColor: MobColors.background,
      appBar: AppBar(
        backgroundColor: MobColors.surface,
        title: const Text(
          'My Kitchen Profile & Settings',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: MobColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton.icon(
            onPressed: _saveProfile,
            icon: const Icon(Icons.check, size: 18, color: MobColors.primaryLight),
            label: const Text(
              'Save',
              style: TextStyle(
                color: MobColors.primaryLight,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Chef Pro Status Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: subState.isChefPro
                        ? [const Color(0xFF2E381E), const Color(0xFF1A1E24)]
                        : [const Color(0xFF3B2314), const Color(0xFF1A1A24)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: subState.isChefPro ? MobColors.green : MobColors.gold,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.workspace_premium,
                        color: subState.isChefPro ? MobColors.green : MobColors.gold,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subState.isChefPro ? 'SIMMERLINK CHEF PRO ACTIVE' : 'FREE PLAN',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: subState.isChefPro ? MobColors.green : MobColors.gold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subState.isChefPro
                                ? 'Unlimited AI Recipes, Fridge Vision, and Sous-Chef active.'
                                : 'Free AI creations remaining: ${subState.freeAiCreditsRemaining}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: MobColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!subState.isChefPro)
                      ElevatedButton(
                        onPressed: () => ChefProPaywallSheet.show(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MobColors.gold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Upgrade',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Kitchen Equipment
              const _SectionHeader(
                icon: Icons.kitchen_outlined,
                title: 'My Kitchen Equipment',
                subtitle: 'Unchecked equipment (e.g., Oven) will never be required in AI recipes.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: KitchenEquipment.values.map((eq) {
                  final selected = _equipment.contains(eq);
                  return FilterChip(
                    selected: selected,
                    backgroundColor: MobColors.card,
                    selectedColor: MobColors.primary.withValues(alpha: 0.25),
                    checkmarkColor: MobColors.primaryLight,
                    side: BorderSide(
                      color: selected ? MobColors.primary : MobColors.border,
                    ),
                    label: Text(
                      eq.label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: selected ? MobColors.textPrimary : MobColors.textSecondary,
                      ),
                    ),
                    onSelected: (val) {
                      setState(() {
                        if (val) {
                          _equipment.add(eq);
                        } else if (_equipment.length > 1) {
                          _equipment.remove(eq);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              if (!_equipment.contains(KitchenEquipment.oven)) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: MobColors.goldSurface,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MobColors.goldBorder),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: MobColors.gold),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Ovenless Mode Active: Gemini Chef crafts all recipes exclusively for stovetop, skillet, or air fryer.',
                          style: TextStyle(fontSize: 12, color: MobColors.gold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // 3. Nutrition & Culinary Goals
              const _SectionHeader(
                icon: Icons.track_changes_outlined,
                title: 'Nutrition & Cooking Goals',
                subtitle: 'Prioritized dietary goals for AI recipe recommendations.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableDietGoals.map((goal) {
                  final selected = _dietGoals.contains(goal);
                  return FilterChip(
                    selected: selected,
                    backgroundColor: MobColors.card,
                    selectedColor: MobColors.green.withValues(alpha: 0.25),
                    checkmarkColor: MobColors.green,
                    side: BorderSide(color: selected ? MobColors.green : MobColors.border),
                    label: Text(
                      goal,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: selected ? MobColors.textPrimary : MobColors.textSecondary,
                      ),
                    ),
                    onSelected: (_) => _toggleStringItem(_dietGoals, goal),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 4. Allergies & Vital Dietary Constraints
              const _SectionHeader(
                icon: Icons.health_and_safety_outlined,
                title: 'Allergies & Vital Restrictions',
                subtitle: 'These ingredients are strictly barred from AI recipes and flagged in the catalog.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _commonAllergies.map((item) {
                  final selected = _allergies.any((e) => e.toLowerCase() == item.toLowerCase());
                  return FilterChip(
                    selected: selected,
                    backgroundColor: MobColors.card,
                    selectedColor: MobColors.redSurface,
                    checkmarkColor: MobColors.red,
                    side: BorderSide(color: selected ? MobColors.red : MobColors.border),
                    label: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: selected ? MobColors.red : MobColors.textSecondary,
                      ),
                    ),
                    onSelected: (_) => _toggleStringItem(_allergies, item),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 5. Disliked Ingredients
              const _SectionHeader(
                icon: Icons.block_outlined,
                title: 'Disliked Ingredients',
                subtitle: 'Tag flavours or textures you prefer to avoid.',
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _commonDislikes.map((item) {
                  final selected = _disliked.any((e) => e.toLowerCase() == item.toLowerCase());
                  return FilterChip(
                    selected: selected,
                    backgroundColor: MobColors.card,
                    selectedColor: MobColors.goldSurface,
                    checkmarkColor: MobColors.gold,
                    side: BorderSide(color: selected ? MobColors.gold : MobColors.border),
                    label: Text(
                      item,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: selected ? MobColors.gold : MobColors.textSecondary,
                      ),
                    ),
                    onSelected: (_) => _toggleStringItem(_disliked, item),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // 6. Spice Tolerance & Default Portions
              const _SectionHeader(
                icon: Icons.whatshot_outlined,
                title: 'Spice Tolerance & Default Servings',
                subtitle: 'How spicy do you like your dishes and for how many people do you usually cook?',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: MobColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Spice Level:',
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: MobColors.textPrimary),
                        ),
                        Text(
                          switch (_spiceLevel) {
                            0 => '0 · Mild / Zero Heat',
                            1 => '1 · Gentle Warmth',
                            2 => '2 · Balanced Kick',
                            _ => '3 · Fiery Chef Heat 🌶️',
                          },
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: MobColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: _spiceLevel.toDouble(),
                      min: 0,
                      max: 3,
                      divisions: 3,
                      activeColor: MobColors.primary,
                      onChanged: (val) => setState(() => _spiceLevel = val.round()),
                    ),
                    const Divider(color: MobColors.border),
                    const SizedBox(height: 8),
                    const Text(
                      'Default Servings:',
                      style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: MobColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [1, 2, 4, 6].map((count) {
                        final isSelected = _defaultServings == count;
                        return ChoiceChip(
                          selected: isSelected,
                          selectedColor: MobColors.primary,
                          backgroundColor: MobColors.card,
                          label: Text(
                            '$count Servings',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isSelected ? Colors.white : MobColors.textSecondary,
                            ),
                          ),
                          onSelected: (_) => setState(() => _defaultServings = count),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 7. Chef's Notes
              const _SectionHeader(
                icon: Icons.edit_note_outlined,
                title: 'Personal Chef Notes',
                subtitle: 'e.g., "I prefer boneless chicken thighs instead of breast."',
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _extraNotesController,
                maxLines: 2,
                style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
                decoration: const InputDecoration(
                  hintText: 'Enter any personal kitchen notes or cooking style...',
                ),
              ),
              const SizedBox(height: 24),

              // 8. Gemini API & Privacy Notice (Guideline 5.1.1)
              const _SectionHeader(
                icon: Icons.vpn_key_outlined,
                title: 'AI Connection & Privacy Notice',
                subtitle: 'Gemini 2.5 Flash AI configuration and data privacy statement.',
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: MobColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          apiKeyRepo.hasValidApiKey ? Icons.verified_user : Icons.info_outline,
                          size: 18,
                          color: apiKeyRepo.hasValidApiKey ? MobColors.green : MobColors.gold,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            apiKeyRepo.hasValidApiKey
                                ? 'Active Key: ${apiKeyRepo.maskedApiKey}'
                                : 'Custom Gemini API Key (Optional / Developer Mode)',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: MobColors.textPrimary,
                            ),
                          ),
                        ),
                        if (apiKeyRepo.hasCustomKey)
                          TextButton(
                            onPressed: () async {
                              await ref.read(activeApiKeyProvider.notifier).clearCustomKey();
                            },
                            child: const Text('Reset', style: TextStyle(color: MobColors.red, fontSize: 12)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _apiKeyController,
                      obscureText: true,
                      style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'AIzaSy... (Type to enter a custom key)',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '🔒 Privacy Statement (Apple Guideline 5.1.1): When utilizing Pantry Recipe Generation, AI Remix, or Live Sous-Chef, only input ingredient lists and dish photos are transmitted to Google Gemini AI for recipe synthesis. No personal identity data is shared.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: MobColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: const Icon(Icons.save_outlined, size: 20),
                  label: const Text(
                    'Save Kitchen Profile',
                    style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: MobColors.primaryLight),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: MobColors.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            color: MobColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
