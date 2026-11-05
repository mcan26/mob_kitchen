import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/mob_colors.dart';
import '../domain/subscription_state.dart';
import '../providers/subscription_providers.dart';

/// App Store Review (Guideline 3.1.1) uyumlu, yüksek dönüşümlü "Chef Pro" abonelik ekranı.
class ChefProPaywallSheet extends ConsumerStatefulWidget {
  const ChefProPaywallSheet({
    super.key,
    this.triggerFeatureName,
  });

  final String? triggerFeatureName;

  static Future<bool> show(
    BuildContext context, {
    String? triggerFeatureName,
  }) async {
    final res = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChefProPaywallSheet(
        triggerFeatureName: triggerFeatureName,
      ),
    );
    return res ?? false;
  }

  @override
  ConsumerState<ChefProPaywallSheet> createState() => _ChefProPaywallSheetState();
}

class _ChefProPaywallSheetState extends ConsumerState<ChefProPaywallSheet> {
  SubscriptionPlan _selectedPlan = SubscriptionPlan.annual;
  bool _isProcessing = false;

  static const _proFeatures = [
    (
      Icons.camera_alt_outlined,
      'Unlimited Fridge & Pantry Vision',
      'Snap your fridge or countertops; Gemini Vision crafts chef-grade recipes in seconds.',
    ),
    (
      Icons.bolt_rounded,
      'Import from TikTok, Reels & Web URLs',
      'Paste any cooking video link; ingredients and timed steps are parsed effortlessly.',
    ),
    (
      Icons.auto_awesome,
      'Unlimited AI Remix & Smart Adaptations',
      '"Make it ovenless", "Boost protein to 45g", or "Budget adapt" with custom dietary remakes.',
    ),
    (
      Icons.record_voice_over_outlined,
      'Live AI Sous-Chef & Voice Cook Mode',
      'Hands-free voice step advancement and instant emergency fixes right at the stove.',
    ),
  ];

  Future<void> _subscribe() async {
    setState(() => _isProcessing = true);
    await ref.read(subscriptionProvider.notifier).activateChefPro(_selectedPlan);
    if (!mounted) return;
    setState(() => _isProcessing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 ${_selectedPlan.title} activated! All AI features unlocked.'),
        backgroundColor: MobColors.green,
      ),
    );
    Navigator.of(context).pop(true);
  }

  Future<void> _restore() async {
    setState(() => _isProcessing = true);
    await ref.read(subscriptionProvider.notifier).restorePurchases();
    if (!mounted) return;
    setState(() => _isProcessing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Purchases successfully restored!'),
        backgroundColor: MobColors.green,
      ),
    );
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.92,
      ),
      decoration: const BoxDecoration(
        color: MobColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(
          top: BorderSide(color: MobColors.gold, width: 1.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Üst tutamaç
              Center(
                child: Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MobColors.textMuted.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Üst Rozet ve Kapat
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [MobColors.primary, MobColors.gold],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium, size: 15, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'SIMMERLINK CHEF PRO',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: MobColors.textSecondary),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Text(
                widget.triggerFeatureName != null
                    ? 'Unlock Limits for ${widget.triggerFeatureName}'
                    : 'Unleash Your AI Kitchen Sous-Chef',
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: MobColors.textPrimary,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subState.isChefPro
                    ? 'Your Chef Pro subscription is currently active! Enjoy all premium features.'
                    : 'Free AI creations remaining: ${subState.freeAiCreditsRemaining}. Upgrade to Chef Pro for unlimited fridge vision, social media imports, and bespoke recipe remixes.',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: MobColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Features List
              for (final (icon, title, desc) in _proFeatures)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: MobColors.goldSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: MobColors.goldBorder),
                        ),
                        child: Icon(icon, size: 18, color: MobColors.gold),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: MobColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              desc,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: MobColors.textSecondary,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 12),

              // Plan Options
              for (final plan in SubscriptionPlan.values)
                _PlanOptionCard(
                  plan: plan,
                  isSelected: _selectedPlan == plan,
                  isBestValue: plan == SubscriptionPlan.annual,
                  onTap: () => setState(() => _selectedPlan = plan),
                ),

              const SizedBox(height: 16),

              // Main Purchase CTA
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _isProcessing ? null : _subscribe,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MobColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.auto_awesome, size: 20),
                  label: Text(
                    _selectedPlan == SubscriptionPlan.annual
                        ? 'Try 7 Days Free & Start Pro'
                        : 'Start Chef Pro',
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Restore Purchases & Demo Credits
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _isProcessing ? null : _restore,
                    child: const Text(
                      'Restore Purchases',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: MobColors.textSecondary,
                      ),
                    ),
                  ),
                  const Text('·', style: TextStyle(color: MobColors.textMuted)),
                  TextButton(
                    onPressed: () async {
                      await ref.read(subscriptionProvider.notifier).grantBonusCredits(3);
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('+3 Free AI trial credits added!'),
                            backgroundColor: MobColors.gold,
                          ),
                        );
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: const Text(
                      '+3 Free Trial Credits (Demo)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: MobColors.gold,
                      ),
                    ),
                  ),
                ],
              ),
              const Center(
                child: Text(
                  'Subscription renews automatically via your Apple ID / Google Play account; cancel anytime in Settings > Subscriptions. Terms of Use (EULA) and Privacy Policy apply.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: MobColors.textMuted,
                    height: 1.35,
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

class _PlanOptionCard extends StatelessWidget {
  const _PlanOptionCard({
    required this.plan,
    required this.isSelected,
    required this.isBestValue,
    required this.onTap,
  });

  final SubscriptionPlan plan;
  final bool isSelected;
  final bool isBestValue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isSelected ? MobColors.surface : MobColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? MobColors.gold : MobColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? MobColors.gold : MobColors.textMuted,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          plan.title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: MobColors.textPrimary,
                          ),
                        ),
                        if (isBestValue) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: MobColors.gold,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'SAVE 55%',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      plan.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: MobColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                plan.priceLabel,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: isSelected ? MobColors.gold : MobColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
