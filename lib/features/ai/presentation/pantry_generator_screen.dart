import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme/mob_colors.dart';
import '../../recipes/domain/entities/recipe.dart';
import '../../recipes/presentation/widgets/golden_rules_card.dart';
import '../../recipes/presentation/widgets/macro_badge_row.dart';
import '../../recipes/providers/recipe_providers.dart';
import '../../subscription/presentation/chef_pro_paywall_sheet.dart';
import '../../subscription/providers/subscription_providers.dart';
import '../providers/ai_providers.dart';

enum AiCreationMode {
  pantryAndPhoto('Pantry & Photo', Icons.kitchen_outlined),
  socialImport('Reels / TikTok URL', Icons.bolt_rounded);

  const AiCreationMode(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Instant culinary recipe generator from pantry staples, fridge photos (Gemini Vision),
/// or social media cooking clips.
class PantryGeneratorScreen extends ConsumerStatefulWidget {
  const PantryGeneratorScreen({
    super.key,
    this.initialMode = AiCreationMode.pantryAndPhoto,
  });

  final AiCreationMode initialMode;

  @override
  ConsumerState<PantryGeneratorScreen> createState() => _PantryGeneratorScreenState();
}

class _PantryGeneratorScreenState extends ConsumerState<PantryGeneratorScreen> {
  late AiCreationMode _mode;
  final List<String> _ingredients = [];
  final TextEditingController _ingredientInputController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _socialInputController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  Uint8List? _selectedImageBytes;
  String? _selectedImageName;

  bool _isLoading = false;
  String? _errorMessage;
  Recipe? _generatedRecipe;

  static const _pantrySuggestions = [
    'Eggs',
    'Pasta',
    'Minced Beef',
    'Chicken Breast',
    'Garlic',
    'Onion',
    'Mushrooms',
    'Heavy Cream',
    'Parmesan',
    'Canned Tomatoes',
    'Rice',
    'Olive Oil',
    'Tomato Paste',
    'Lemon',
  ];

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  @override
  void dispose() {
    _ingredientInputController.dispose();
    _noteController.dispose();
    _socialInputController.dispose();
    super.dispose();
  }

  void _addIngredient(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return;
    if (!_ingredients.any((i) => i.toLowerCase() == trimmed.toLowerCase())) {
      setState(() {
        _ingredients.add(trimmed);
      });
    }
    _ingredientInputController.clear();
  }

  void _removeIngredient(String name) {
    setState(() {
      _ingredients.remove(name);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1280,
        imageQuality: 82,
      );
      if (file == null) return;
      final bytes = await file.readAsBytes();
      if (mounted) {
        setState(() {
          _selectedImageBytes = bytes;
          _selectedImageName = file.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select image: $e'),
            backgroundColor: MobColors.red,
          ),
        );
      }
    }
  }

  Future<bool> _ensureAiAccess(String featureLabel) async {
    final allowed = await ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
    if (allowed) return true;
    if (!mounted) return false;
    final unlocked = await ChefProPaywallSheet.show(
      context,
      triggerFeatureName: featureLabel,
    );
    if (unlocked) {
      return ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
    }
    return false;
  }

  Future<void> _generateRecipe() async {
    if (_ingredients.isEmpty && _selectedImageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one ingredient or snap a photo of your fridge.'),
          backgroundColor: MobColors.gold,
        ),
      );
      return;
    }

    final hasAccess = await _ensureAiAccess('Pantry & Photo AI Recipe');
    if (!hasAccess) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _generatedRecipe = null;
    });

    try {
      final aiService = ref.read(geminiRecipeServiceProvider);
      final recipe = await aiService.generateRecipeFromPantry(
        ingredients: _ingredients,
        imageBytes: _selectedImageBytes,
        mimeType: 'image/jpeg',
        additionalPrompt: _noteController.text.trim().isNotEmpty ? _noteController.text.trim() : null,
      );

      if (mounted) {
        setState(() {
          _generatedRecipe = recipe;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'An error occurred generating the recipe: $e';
        });
      }
    }
  }

  Future<void> _importFromSocial() async {
    final text = _socialInputController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please paste an Instagram Reels / TikTok URL or recipe text.'),
          backgroundColor: MobColors.gold,
        ),
      );
      return;
    }

    final hasAccess = await _ensureAiAccess('Social Media Recipe Import');
    if (!hasAccess) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _generatedRecipe = null;
    });

    try {
      final aiService = ref.read(geminiRecipeServiceProvider);
      final recipe = await aiService.importRecipeFromSocialOrText(urlOrText: text);

      if (mounted) {
        setState(() {
          _generatedRecipe = recipe;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Failed to parse social media recipe: $e';
        });
      }
    }
  }

  Future<void> _saveAndOpenRecipe() async {
    if (_generatedRecipe == null) return;
    final repo = ref.read(recipeRepositoryProvider);
    await repo.save(_generatedRecipe!);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${_generatedRecipe!.title}" saved to your cookbook!'),
          backgroundColor: MobColors.green,
        ),
      );
      context.go('/recipe/${_generatedRecipe!.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);

    return Scaffold(
      backgroundColor: MobColors.background,
      appBar: AppBar(
        backgroundColor: MobColors.surface,
        title: const Text(
          'AI Pantry Chef',
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
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => ChefProPaywallSheet.show(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: subState.isChefPro ? MobColors.greenSurface : MobColors.goldSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: subState.isChefPro ? MobColors.green : MobColors.goldBorder,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium,
                      size: 14,
                      color: subState.isChefPro ? MobColors.green : MobColors.gold,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      subState.isChefPro ? 'CHEF PRO' : '${subState.freeAiCreditsRemaining} Left',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: subState.isChefPro ? MobColors.green : MobColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: _isLoading
              ? _buildLoadingState()
              : _generatedRecipe != null
                  ? _buildGeneratedRecipeState()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mode Selector (Pantry & Photo vs Social Media URL)
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: MobColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: MobColors.border),
                          ),
                          child: Row(
                            children: AiCreationMode.values.map((m) {
                              final selected = _mode == m;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(() => _mode = m),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      color: selected ? MobColors.primary : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          m.icon,
                                          size: 16,
                                          color: selected ? Colors.white : MobColors.textSecondary,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          m.label,
                                          style: TextStyle(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.w800,
                                            color: selected ? Colors.white : MobColors.textSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 18),
                        if (_mode == AiCreationMode.pantryAndPhoto)
                          _buildInputState()
                        else
                          _buildSocialImportState(),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(color: MobColors.primary),
            const SizedBox(height: 24),
            const Text(
              'Gemini AI Chef Thinking...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: MobColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _mode == AiCreationMode.socialImport
                  ? 'Extracting ingredients, metrics, and step timings into a SimmerLink recipe.'
                  : 'Synthesizing a balanced, flavorful recipe from your ingredients${_selectedImageBytes != null ? ' and fridge photo' : ''}.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.5,
                color: MobColors.textSecondary,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialImportState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_errorMessage != null) _buildErrorBanner(),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: MobColors.border),
          ),
          child: const Row(
            children: [
              Icon(Icons.bolt_rounded, color: MobColors.gold, size: 28),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Paste an Instagram Reel, TikTok, or YouTube Shorts link or text description; Gemini parses ingredients and generates an interactive cooking card!',
                  style: TextStyle(fontSize: 13, height: 1.4, color: MobColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Video URL or Recipe Text',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: MobColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: MobColors.border),
          ),
          child: TextField(
            controller: _socialInputController,
            maxLines: 4,
            style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
            decoration: const InputDecoration(
              hintText: 'e.g., https://www.instagram.com/reel/... or "200g pasta, 3 garlic cloves, chili flakes..."',
              hintStyle: TextStyle(color: MobColors.textMuted, fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: _importFromSocial,
            style: ElevatedButton.styleFrom(
              backgroundColor: MobColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.bolt_rounded, size: 20),
            label: const Text(
              'Extract & Generate Recipe',
              style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorBanner() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: MobColors.redSurface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: MobColors.red.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: MobColors.red, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputState() {
    final canGenerate = _ingredients.isNotEmpty || _selectedImageBytes != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_errorMessage != null) _buildErrorBanner(),

        // Info Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: MobColors.border),
          ),
          child: const Row(
            children: [
              Icon(Icons.kitchen_outlined, color: MobColors.primaryLight, size: 28),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Snap a photo of your fridge or select staple ingredients below; Gemini AI will craft a bespoke SimmerLink recipe tailored to your kitchen profile.',
                  style: TextStyle(fontSize: 13, height: 1.4, color: MobColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Multimodal Fridge Photo Card
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: MobColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _selectedImageBytes != null ? MobColors.green : MobColors.border,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.camera_enhance_outlined, size: 18, color: MobColors.gold),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Fridge / Countertop Photo (Gemini Vision)',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: MobColors.textPrimary,
                      ),
                    ),
                  ),
                  if (_selectedImageBytes != null)
                    IconButton(
                      tooltip: 'Remove Photo',
                      icon: const Icon(Icons.delete_outline, size: 18, color: MobColors.red),
                      onPressed: () => setState(() {
                        _selectedImageBytes = null;
                        _selectedImageName = null;
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              if (_selectedImageBytes != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Image.memory(
                        _selectedImageBytes!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        left: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '📸 ${_selectedImageName ?? "Photo Added"}',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.photo_camera_outlined, size: 17, color: MobColors.primaryLight),
                        label: const Text('Take Photo', style: TextStyle(fontSize: 12.5)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library_outlined, size: 17, color: MobColors.gold),
                        label: const Text('From Gallery', style: TextStyle(fontSize: 12.5)),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Ingredient Input Area
        const Text(
          'Add Ingredients',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: MobColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: MobColors.border),
                ),
                child: TextField(
                  controller: _ingredientInputController,
                  style: const TextStyle(color: MobColors.textPrimary, fontSize: 14),
                  onSubmitted: _addIngredient,
                  decoration: const InputDecoration(
                    hintText: 'Type ingredient name (e.g. Chicken, Cream)...',
                    hintStyle: TextStyle(color: MobColors.textMuted, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _addIngredient(_ingredientInputController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: MobColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Icon(Icons.add, size: 20),
            ),
          ],
        ),

        // Selected Ingredients
        if (_ingredients.isNotEmpty) ...[
          const SizedBox(height: 16),
          const Text(
            'In Your Fridge:',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: MobColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _ingredients.map((ing) {
              return Chip(
                backgroundColor: MobColors.cardSubtle,
                side: const BorderSide(color: MobColors.primaryLight),
                label: Text(
                  ing,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: MobColors.textPrimary,
                  ),
                ),
                deleteIcon: const Icon(Icons.close, size: 16, color: MobColors.primaryLight),
                onDeleted: () => _removeIngredient(ing),
              );
            }).toList(),
          ),
        ],

        // Quick Suggestions
        const SizedBox(height: 20),
        const Text(
          'Quick Pantry Staples',
          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: MobColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _pantrySuggestions.map((item) {
            final isAdded = _ingredients.contains(item);
            return ActionChip(
              backgroundColor: isAdded ? MobColors.primary.withValues(alpha: 0.2) : MobColors.card,
              side: BorderSide(color: isAdded ? MobColors.primary : MobColors.border),
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isAdded) const Icon(Icons.check, size: 14, color: MobColors.primary),
                  if (isAdded) const SizedBox(width: 4),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: isAdded ? MobColors.primaryLight : MobColors.textSecondary,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                if (isAdded) {
                  _removeIngredient(item);
                } else {
                  _addIngredient(item);
                }
              },
            );
          }).toList(),
        ),

        // Custom Notes & Requests
        const SizedBox(height: 20),
        const Text(
          'Special Request / Note (Optional)',
          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: MobColors.textPrimary),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: MobColors.border),
          ),
          child: TextField(
            controller: _noteController,
            maxLines: 2,
            style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
            decoration: const InputDecoration(
              hintText: 'e.g., One-pan, under 20 minutes, minimal cleanup...',
              hintStyle: TextStyle(color: MobColors.textMuted, fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),

        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: canGenerate ? _generateRecipe : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: MobColors.primary,
              foregroundColor: Colors.white,
              disabledBackgroundColor: MobColors.card,
              disabledForegroundColor: MobColors.textMuted,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            icon: const Icon(Icons.auto_awesome, size: 20),
            label: const Text(
              'Generate SimmerLink Recipe',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGeneratedRecipeState() {
    final recipe = _generatedRecipe!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Success Banner
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: MobColors.greenSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MobColors.green.withValues(alpha: 0.5)),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle, color: MobColors.green, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Recipe Successfully Generated!',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: MobColors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Title
        Text(
          recipe.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: MobColors.textPrimary,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          recipe.subtitle,
          style: const TextStyle(
            fontSize: 14,
            height: 1.4,
            color: MobColors.textSecondary,
          ),
        ),
        const SizedBox(height: 14),

        // Macros
        MacroBadgeRow(macros: recipe.macros),
        const SizedBox(height: 16),

        // Golden Rules
        if (recipe.chefGoldenRules.isNotEmpty) ...[
          GoldenRulesCard(rules: recipe.chefGoldenRules),
          const SizedBox(height: 16),
        ],

        // Ingredients
        const Text(
          'Required Ingredients:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        for (final ing in recipe.ingredients)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.check, size: 16, color: MobColors.primaryLight),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${ing.amount > 0 ? '${ing.amount} ' : ''}${ing.unit.label} ${ing.name}',
                    style: const TextStyle(fontSize: 13.5, color: MobColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 24),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _generatedRecipe = null),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: MobColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text(
                  'Adjust & Retry',
                  style: TextStyle(color: MobColors.textSecondary, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                onPressed: _saveAndOpenRecipe,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MobColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.bookmark_add_outlined, size: 18),
                label: const Text(
                  'Save & Cook',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
