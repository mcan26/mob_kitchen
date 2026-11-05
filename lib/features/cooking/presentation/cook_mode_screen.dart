import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/theme/mob_colors.dart';
import '../../recipes/domain/entities/recipe.dart';
import '../../recipes/domain/entities/recipe_ingredient.dart';
import '../../recipes/domain/entities/recipe_step.dart';
import '../../recipes/domain/services/portion_scaler.dart';
import '../../recipes/providers/recipe_providers.dart';
import '../../wireless/presentation/smart_kitchen_hub_screen.dart';
import '../../wireless/providers/wireless_providers.dart';
import '../providers/cook_timer_provider.dart';
import 'widgets/floating_timer_bar.dart';
import 'widgets/sous_chef_bottom_sheet.dart';

/// Eller serbest, ekranı açık tutan ve paralel sayaç destekli tam ekran pişirme modu.
class CookModeScreen extends ConsumerStatefulWidget {
  const CookModeScreen({
    super.key,
    required this.recipeId,
    this.targetServings,
  });

  final String recipeId;
  final int? targetServings;

  @override
  ConsumerState<CookModeScreen> createState() => _CookModeScreenState();
}

class _CookModeScreenState extends ConsumerState<CookModeScreen> with WidgetsBindingObserver {
  late final PageController _pageController;
  int _currentStepIndex = 0;
  bool _isApplyingRemoteStepSync = false;

  void _applyRemoteCookStepSync(String? syncedStepSpec, int totalSteps) {
    if (syncedStepSpec == null || totalSteps <= 0 || !mounted) return;
    final prefix = '${widget.recipeId}:';
    if (!syncedStepSpec.startsWith(prefix)) return;
    final stepPart = syncedStepSpec.substring(prefix.length).split('/').first;
    final stepNumber = int.tryParse(stepPart);
    if (stepNumber == null) return;
    final targetIdx = (stepNumber - 1).clamp(0, totalSteps - 1);
    if (targetIdx == _currentStepIndex) return;

    _isApplyingRemoteStepSync = true;
    setState(() => _currentStepIndex = targetIdx);
    if (_pageController.hasClients) {
      _pageController.jumpToPage(targetIdx);
    }
    _isApplyingRemoteStepSync = false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
    // Yemek yaparken ekranın kapanmasını önle
    _enableWakelock();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      // iOS arka plandan döndüğünde zamanlayıcıları gerçek duvar saatiyle senkronize et
      ref.read(cookTimersProvider.notifier).syncWithWallClock();
    }
  }

  Future<void> _enableWakelock() async {
    try {
      await WakelockPlus.enable();
    } catch (_) {
      // Test ortamında veya desteklenmeyen cihazlarda sessizce devam et
    }
  }

  Future<void> _disableWakelock() async {
    try {
      await WakelockPlus.disable();
    } catch (_) {
      // Test ortamı koruması
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disableWakelock();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep(int totalSteps) {
    if (_currentStepIndex < totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    } else {
      _showCompletionDialog();
    }
  }

  void _prevStep() {
    if (_currentStepIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: MobColors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Text('🎉', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text(
              'Great Job, Chef!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: MobColors.textPrimary,
              ),
            ),
          ],
        ),
        content: const Text(
          'You successfully completed the recipe! Serve hot and enjoy your SimmerLink meal.',
          style: TextStyle(fontSize: 14, color: MobColors.textSecondary, height: 1.4),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MobColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Complete & Exit', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipeAsync = ref.watch(recipeByIdProvider(widget.recipeId));

    return Scaffold(
      backgroundColor: MobColors.background,
      body: recipeAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: MobColors.primary),
        ),
        error: (err, _) => Center(
          child: Text('Could not load recipe: $err', style: const TextStyle(color: MobColors.red)),
        ),
        data: (recipe) {
          if (recipe == null || recipe.steps.isEmpty) {
            return const Center(
              child: Text('No cooking steps found.', style: TextStyle(color: MobColors.textSecondary)),
            );
          }

          final totalSteps = recipe.steps.length;
          ref.listen<String?>(
            smartKitchenHubProvider.select((s) => s.lastSyncedCookStep),
            (prev, next) {
              if (next != prev) {
                _applyRemoteCookStepSync(next, totalSteps);
              }
            },
          );
          final currentStep = recipe.steps[_currentStepIndex];
          final progress = (_currentStepIndex + 1) / totalSteps;
          final wirelessHub = ref.watch(smartKitchenHubProvider);

          return SafeArea(
            child: Column(
              children: [
                // 1. Üst Bar: Kapat Butonu + İlerleme + Sayaçlar
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: MobColors.textPrimary, size: 24),
                        onPressed: () => context.pop(),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: MobColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Step ${_currentStepIndex + 1} / $totalSteps',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: MobColors.primaryLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Live Sous-Chef Icon
                      IconButton(
                        tooltip: 'Ask Sous-Chef',
                        onPressed: () => SousChefBottomSheet.show(
                          context: context,
                          recipe: recipe,
                          currentStepNumber: currentStep.stepNumber,
                        ),
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: MobColors.goldSurface,
                            shape: BoxShape.circle,
                            border: Border.all(color: MobColors.goldBorder),
                          ),
                          child: const Text('👨‍🍳', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: MobColors.card,
                      valueColor: const AlwaysStoppedAnimation<Color>(MobColors.primary),
                      minHeight: 4,
                    ),
                  ),
                ),

                // Floating Timer Bar
                const FloatingTimerBar(),

                // Live BLE Smart Thermometer & Scale Telemetry Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => const SmartKitchenHubScreen(
                            initialTab: WirelessHubTab.telemetry,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: MobColors.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: wirelessHub.isTargetTempReached
                              ? MobColors.green
                              : MobColors.border,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.bluetooth_connected,
                            size: 16,
                            color: wirelessHub.isTargetTempReached
                                ? MobColors.green
                                : MobColors.primaryLight,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'BLE Probe: ${wirelessHub.probeCurrentTempC.toStringAsFixed(1)}°C / ${wirelessHub.probeTargetTempC.toStringAsFixed(0)}°C  •  Scale: ${wirelessHub.scaleNetWeightG.toStringAsFixed(0)}g',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: MobColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text(
                            'Sensor Hub',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: MobColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // 2. Step Cards (Swipeable PageView)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (idx) {
                      setState(() => _currentStepIndex = idx);
                      if (_isApplyingRemoteStepSync) return;
                      ref.read(smartKitchenHubProvider.notifier).broadcastCoOpEvent(
                            'cook_step_sync',
                            '${recipe.title} -> Advanced to Step ${idx + 1}/$totalSteps',
                            payload: {
                              'recipeId': recipe.id,
                              'stepIndex': idx + 1,
                              'totalSteps': totalSteps,
                            },
                          );
                    },
                    itemCount: totalSteps,
                    itemBuilder: (context, index) {
                      final step = recipe.steps[index];
                      return _CookStepView(
                        step: step,
                        recipe: recipe,
                        targetServings: widget.targetServings ?? recipe.baseServings,
                      );
                    },
                  ),
                ),

                // 3. Bottom Control Bar
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  decoration: const BoxDecoration(
                    color: MobColors.surface,
                    border: Border(top: BorderSide(color: MobColors.border)),
                  ),
                  child: Row(
                    children: [
                      // Back Button
                      IconButton.filledTonal(
                        onPressed: _currentStepIndex > 0 ? _prevStep : null,
                        style: IconButton.styleFrom(
                          backgroundColor: MobColors.card,
                          disabledBackgroundColor: MobColors.card.withValues(alpha: 0.3),
                          padding: const EdgeInsets.all(14),
                        ),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      ),
                      const SizedBox(width: 12),
                      // Sous-Chef Button
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => SousChefBottomSheet.show(
                            context: context,
                            recipe: recipe,
                            currentStepNumber: currentStep.stepNumber,
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: MobColors.goldBorder, width: 1.5),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          icon: const Text('👨‍🍳', style: TextStyle(fontSize: 16)),
                          label: const Text(
                            'Ask Chef',
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w800,
                              color: MobColors.gold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Forward / Complete Button
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: () => _nextStep(totalSteps),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MobColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          icon: Icon(
                            _currentStepIndex == totalSteps - 1 ? Icons.check_circle : Icons.arrow_forward,
                            size: 18,
                          ),
                          label: Text(
                            _currentStepIndex == totalSteps - 1 ? 'Finish 🎉' : 'Next Step',
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CookStepView extends ConsumerWidget {
  const _CookStepView({
    required this.step,
    required this.recipe,
    required this.targetServings,
  });

  final RecipeStep step;
  final Recipe recipe;
  final int targetServings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerId = 'step_${step.stepNumber}';
    final timers = ref.watch(cookTimersProvider);
    final activeTimer = timers[timerId];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Adım Başlığı
          Text(
            step.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: MobColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 14),

          // Adım İçi Malzeme Göstergesi (In-Step Ingredients - Porsiyona Göre Ölçekli)
          _InStepIngredientsBar(
            step: step,
            allIngredients: recipe.ingredients,
            baseServings: recipe.baseServings,
            targetServings: targetServings,
          ),
          const SizedBox(height: 16),

          // Büyük ve Rahat Okunabilir Talimat
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: MobColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: MobColors.border),
            ),
            child: Text(
              step.instruction,
              style: const TextStyle(
                fontSize: 17,
                height: 1.6,
                fontWeight: FontWeight.w500,
                color: MobColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Zamanlayıcı Varsa Başlat / Duraklat Butonu
          if (step.timerSeconds != null && step.timerSeconds! > 0) ...[
            _TimerActionButton(
              step: step,
              activeTimer: activeTimer,
            ),
            const SizedBox(height: 16),
          ],

          // Duyusal İşaret (Sensory Cue)
          if (step.sensoryCue.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MobColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MobColors.primaryLight.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.remove_red_eye_outlined, size: 20, color: MobColors.primaryLight),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SENSORY CUE (WHEN IS IT DONE?)',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: MobColors.primaryLight,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.sensoryCue,
                          style: const TextStyle(
                            fontSize: 13.5,
                            height: 1.45,
                            color: MobColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Şefin Sırrı (Chef Tip)
          if (step.chefTip.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MobColors.goldSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MobColors.goldBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, size: 20, color: MobColors.gold),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "CHEF'S SECRET & WHY WE DO IT",
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: MobColors.gold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.chefTip,
                          style: const TextStyle(
                            fontSize: 13.5,
                            height: 1.45,
                            color: MobColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Hata Uyarısı (Mistake Warning)
          if (step.mistakeWarning != null && step.mistakeWarning!.trim().isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: MobColors.redSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MobColors.red.withValues(alpha: 0.4)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, size: 20, color: MobColors.red),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'COMMON MISTAKE TO AVOID',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: MobColors.red,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          step.mistakeWarning!,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: MobColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TimerActionButton extends ConsumerWidget {
  const _TimerActionButton({
    required this.step,
    required this.activeTimer,
  });

  final RecipeStep step;
  final ActiveTimerState? activeTimer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRunning = activeTimer?.isRunning ?? false;
    final isFinished = activeTimer?.isFinished ?? false;
    final remainingText = activeTimer != null ? activeTimer!.formattedRemaining : '${step.timerSeconds! ~/ 60} min';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MobColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isFinished
              ? MobColors.green
              : isRunning
                  ? MobColors.gold
                  : MobColors.border,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ref.read(cookTimersProvider.notifier).startOrToggleTimer(
                  stepNumber: step.stepNumber,
                  label: step.title,
                  durationSeconds: step.timerSeconds!,
                );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  isFinished
                      ? Icons.check_circle
                      : isRunning
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                  size: 26,
                  color: isFinished
                      ? MobColors.green
                      : isRunning
                          ? MobColors.gold
                          : MobColors.primaryLight,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isFinished
                            ? 'Timer Finished!'
                            : isRunning
                                ? 'Timer Counting Down...'
                                : 'Start Timer (${step.timerSeconds! ~/ 60} Minutes)',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: isFinished ? MobColors.green : MobColors.textPrimary,
                        ),
                      ),
                      if (activeTimer != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Remaining: $remainingText',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isRunning ? MobColors.gold : MobColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  isFinished ? 'Reset ↺' : isRunning ? 'Pause' : 'Start',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: isRunning ? MobColors.gold : MobColors.primaryLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InStepIngredientsBar extends StatelessWidget {
  const _InStepIngredientsBar({
    required this.step,
    required this.allIngredients,
    required this.baseServings,
    required this.targetServings,
  });

  final RecipeStep step;
  final List<RecipeIngredient> allIngredients;
  final int baseServings;
  final int targetServings;

  List<RecipeIngredient> _resolveIngredients() {
    final text = '${step.title} ${step.instruction}'.toLowerCase();
    final matched = allIngredients.where((ing) {
      final name = ing.name.toLowerCase();
      if (text.contains(name)) return true;
      final tokens = name.split(RegExp(r'\s+')).where((t) => t.length > 2);
      return tokens.any((t) => text.contains(t));
    }).toList();

    final list = matched.isNotEmpty ? matched : allIngredients;
    return list
        .map((ing) => PortionScaler.scaleIngredient(
              ing,
              baseServings: baseServings,
              targetServings: targetServings,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ingredients = _resolveIngredients();
    if (ingredients.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.kitchen, size: 14, color: MobColors.primaryLight),
            const SizedBox(width: 6),
            const Text(
              'INGREDIENTS FOR THIS STEP:',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: MobColors.primaryLight,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '(${ingredients.length})',
              style: const TextStyle(fontSize: 11, color: MobColors.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ingredients.map((ing) {
              final amountStr = PortionScaler.formatAmount(ing.amount, ing.unit);
              final unitStr = ing.unit.label;

              return Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: MobColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MobColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: MobColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        unitStr.isEmpty ? amountStr : '$amountStr $unitStr',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: MobColors.primaryLight,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      ing.name,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: MobColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
