import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/mob_colors.dart';
import '../../../ai/providers/ai_providers.dart';
import '../../../recipes/domain/entities/recipe.dart';
import '../../../subscription/presentation/chef_pro_paywall_sheet.dart';
import '../../../subscription/providers/subscription_providers.dart';

/// Pişirme anında o anki adım bağlamında canlı sous-chef desteği sağlayan alt çekmece.
class SousChefBottomSheet extends ConsumerStatefulWidget {
  const SousChefBottomSheet({
    super.key,
    required this.recipe,
    required this.currentStepNumber,
  });

  final Recipe recipe;
  final int currentStepNumber;

  static Future<void> show({
    required BuildContext context,
    required Recipe recipe,
    required int currentStepNumber,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SousChefBottomSheet(
        recipe: recipe,
        currentStepNumber: currentStepNumber,
      ),
    );
  }

  @override
  ConsumerState<SousChefBottomSheet> createState() => _SousChefBottomSheetState();
}

class _SousChefBottomSheetState extends ConsumerState<SousChefBottomSheet> {
  final TextEditingController _questionController = TextEditingController();
  bool _isLoading = false;
  String? _answer;
  String? _errorMessage;

  static const _quickQuestions = [
    'The sauce is too runny, how do I thicken it?',
    'The chicken is sticking to the pan, what should I do?',
    'Is the heat too high, did it burn?',
    'I added too much salt, how can I balance it?',
    'The pasta water cooled down, what should I do?',
    'The consistency is off, what should I add?',
  ];

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _askSousChef(String question) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty) return;

    var allowed = await ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
    if (!allowed && mounted) {
      final unlocked = await ChefProPaywallSheet.show(
        context,
        triggerFeatureName: 'Live Sous-Chef Assistant',
      );
      if (unlocked) {
        allowed = await ref.read(subscriptionProvider.notifier).consumeAiCreditIfNeeded();
      }
    }
    if (!allowed) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _answer = null;
    });

    try {
      final aiService = ref.read(geminiRecipeServiceProvider);
      final response = await aiService.askSousChef(
        currentRecipe: widget.recipe,
        currentStepNumber: widget.currentStepNumber,
        question: trimmed,
      );

      if (mounted) {
        setState(() {
          _answer = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error connecting to Sous-Chef: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final currentStep = widget.recipe.steps.firstWhere(
      (s) => s.stepNumber == widget.currentStepNumber,
      orElse: () => widget.recipe.steps.first,
    );

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.85,
      ),
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: MobColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: MobColors.gold, width: 1.5),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tutamaç & Başlık
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
                    color: MobColors.gold.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('👨‍🍳', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'LIVE SOUS-CHEF ASSISTANT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: MobColors.gold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'Step ${widget.currentStepNumber}: ${currentStep.title}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 15,
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

          // İçerik
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hata Mesajı
                  if (_errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MobColors.redSurface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: MobColors.red.withValues(alpha: 0.4)),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Şefin Yanıtı
                  if (_isLoading) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(color: MobColors.gold),
                            SizedBox(height: 16),
                            Text(
                              'Chef is reviewing your cooking step...',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: MobColors.gold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else if (_answer != null) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: MobColors.goldSurface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: MobColors.goldBorder, width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb, size: 18, color: MobColors.gold),
                              SizedBox(width: 8),
                              Text(
                                "Chef's Solution:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: MobColors.gold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _answer!,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: MobColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Quick Question Chips
                  const Text(
                    'Common Kitchen Questions:',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: MobColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _quickQuestions.map((q) {
                      return ActionChip(
                        backgroundColor: MobColors.card,
                        side: const BorderSide(color: MobColors.border),
                        label: Text(
                          q,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: MobColors.textPrimary,
                          ),
                        ),
                        onPressed: () {
                          _questionController.text = q;
                          _askSousChef(q);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 20),

                  // Question Input Box
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
                            controller: _questionController,
                            style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
                            onSubmitted: _askSousChef,
                            decoration: const InputDecoration(
                              hintText: 'Ask the chef (e.g. Why did the sauce split?)...',
                              hintStyle: TextStyle(color: MobColors.textMuted, fontSize: 12.5),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _askSousChef(_questionController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MobColors.gold,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Icon(Icons.send_rounded, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
