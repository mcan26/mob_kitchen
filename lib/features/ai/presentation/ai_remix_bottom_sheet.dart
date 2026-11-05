import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/mob_colors.dart';
import '../../recipes/domain/entities/recipe.dart';
import '../../recipes/presentation/widgets/macro_badge_row.dart';
import '../../recipes/providers/recipe_providers.dart';
import '../../subscription/presentation/chef_pro_paywall_sheet.dart';
import '../../subscription/providers/subscription_providers.dart';
import '../providers/ai_providers.dart';

/// Tarif detayından açılan AI Remix Bottom Sheet.
/// Hızlı komut çipleri, serbest metin alanı, canlı Gemini önizlemesi ve kaydetme seçenekleri sunar.
class AiRemixBottomSheet extends ConsumerStatefulWidget {
  const AiRemixBottomSheet({
    super.key,
    required this.sourceRecipe,
  });

  final Recipe sourceRecipe;

  static Future<Recipe?> show(BuildContext context, Recipe sourceRecipe) {
    return showModalBottomSheet<Recipe>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AiRemixBottomSheet(sourceRecipe: sourceRecipe),
    );
  }

  @override
  ConsumerState<AiRemixBottomSheet> createState() => _AiRemixBottomSheetState();
}

class _AiRemixBottomSheetState extends ConsumerState<AiRemixBottomSheet> {
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  Recipe? _remixedRecipe;

  static const _quickPrompts = [
    'Make it ovenless (skillet only)',
    'Boost protein content',
    'Budget-friendly adaptation',
    'Lighter / lower calorie',
    'Convert to vegetarian',
    'Spicier with bold heat',
  ];

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  Future<void> _executeRemix(String prompt) async {
    if (prompt.trim().isEmpty) return;

    var allowed = await ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
    if (!allowed && mounted) {
      final unlocked = await ChefProPaywallSheet.show(
        context,
        triggerFeatureName: 'AI Remix',
      );
      if (unlocked) {
        allowed = await ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
      }
    }
    if (!allowed) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _remixedRecipe = null;
    });

    try {
      final aiService = ref.read(geminiRecipeServiceProvider);
      final result = await aiService.remixRecipe(
        sourceRecipe: widget.sourceRecipe,
        remixInstruction: prompt.trim(),
      );

      if (mounted) {
        setState(() {
          _remixedRecipe = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'An error occurred creating the remix: $e';
        });
      }
    }
  }

  Future<void> _saveAsVariation() async {
    if (_remixedRecipe == null) return;
    final repo = ref.read(recipeRepositoryProvider);
    await repo.save(_remixedRecipe!);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${_remixedRecipe!.title}" saved as a custom variation!'),
          backgroundColor: MobColors.green,
        ),
      );
      Navigator.of(context).pop(_remixedRecipe);
    }
  }

  Future<void> _overwriteCurrent() async {
    if (_remixedRecipe == null) return;

    // Built-in recipes cannot be overwritten
    if (widget.sourceRecipe.isBuiltIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Built-in classics cannot be overwritten. Saved as a new variation!'),
          backgroundColor: MobColors.gold,
        ),
      );
      await _saveAsVariation();
      return;
    }

    final repo = ref.read(recipeRepositoryProvider);
    final updated = _remixedRecipe!.copyWith(
      id: widget.sourceRecipe.id,
      isBuiltIn: false,
    );
    await repo.save(updated);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('"${updated.title}" updated!'),
          backgroundColor: MobColors.green,
        ),
      );
      Navigator.of(context).pop(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: MobColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: MobColors.primaryLight, width: 1.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Üst Tutamaç & Başlık
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: MobColors.textMuted.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: MobColors.primaryLight,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'AI RE-MIX & CUSTOMIZE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: MobColors.primaryLight,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        widget.sourceRecipe.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: MobColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: MobColors.textSecondary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: MobColors.border),

          // Content Body
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: _isLoading
                  ? _buildLoadingState()
                  : _remixedRecipe != null
                      ? _buildPreviewState()
                      : _buildInputState(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const CircularProgressIndicator(color: MobColors.primary),
          const SizedBox(height: 24),
          const Text(
            'Gemini AI Chef Balancing Your Recipe...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: MobColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Rebalancing ingredient proportions, cooking techniques, and golden rules for your kitchen profile.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: MobColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputState() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_errorMessage != null) ...[
          Container(
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
          const SizedBox(height: 16),
        ],

        const Text(
          'Quick Transformation Prompts',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _quickPrompts.map((prompt) {
            return ActionChip(
              backgroundColor: MobColors.card,
              side: const BorderSide(color: MobColors.border),
              label: Text(
                prompt,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: MobColors.textSecondary,
                ),
              ),
              onPressed: () {
                _promptController.text = prompt;
                _executeRemix(prompt);
              },
            );
          }).toList(),
        ),

        const SizedBox(height: 20),
        const Text(
          'Or Describe Your Custom Twist',
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: MobColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: MobColors.border),
          ),
          child: TextField(
            controller: _promptController,
            maxLines: 3,
            style: const TextStyle(color: MobColors.textPrimary, fontSize: 14),
            decoration: const InputDecoration(
              hintText: 'e.g., Replace heavy cream with Greek yogurt, use turkey breast instead of beef...',
              hintStyle: TextStyle(color: MobColors.textMuted, fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
        const SizedBox(height: 16),

        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => _executeRemix(_promptController.text),
            style: ElevatedButton.styleFrom(
              backgroundColor: MobColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            icon: const Icon(Icons.auto_awesome, size: 18),
            label: const Text(
              'Generate Remixed Recipe',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewState() {
    final recipe = _remixedRecipe!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Success Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: MobColors.greenSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: MobColors.green.withValues(alpha: 0.4)),
          ),
          child: const Row(
            children: [
              Icon(Icons.check_circle_outline, color: MobColors.green, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'New Recipe Successfully Balanced!',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: MobColors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // New Title & Subtitle
        Text(
          recipe.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: MobColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          recipe.subtitle,
          style: const TextStyle(
            fontSize: 13.5,
            color: MobColors.textSecondary,
          ),
        ),
        const SizedBox(height: 12),

        // New Macros
        MacroBadgeRow(macros: recipe.macros),
        const SizedBox(height: 16),

        // Ingredients Summary
        const Text(
          'Updated Ingredients:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: MobColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        for (final ing in recipe.ingredients)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              children: [
                const Icon(Icons.check, size: 14, color: MobColors.primaryLight),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    '${ing.amount > 0 ? '${ing.amount} ' : ''}${ing.unit.label} ${ing.name}',
                    style: const TextStyle(fontSize: 13, color: MobColors.textPrimary),
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(height: 16),
        // Step Count & Time
        Text(
          'Prep & Cook: ${recipe.steps.length} steps  ·  Total: ${recipe.totalTimeMinutes} min',
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: MobColors.gold,
          ),
        ),

        const SizedBox(height: 24),
        // Action Buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => _remixedRecipe = null),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: MobColors.border),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Try Again',
                  style: TextStyle(color: MobColors.textSecondary, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: _saveAsVariation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MobColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Save as Variation',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
        if (!widget.sourceRecipe.isBuiltIn) ...[
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: _overwriteCurrent,
              child: const Text(
                'Overwrite Current Recipe',
                style: TextStyle(
                  color: MobColors.textMuted,
                  fontSize: 12.5,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
