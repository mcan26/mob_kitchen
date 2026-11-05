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
      'Buzdolabı Fotoğrafından Sınırsız Tarif',
      'Dolabının veya malzemelerinin fotoğrafını çek, Gemini Vision saniyeler içinde şef reçetesi çıkarsın.',
    ),
    (
      Icons.bolt_rounded,
      'TikTok, Reels & Web Linkinden Tarif Aktar',
      'Kaydettiğin yemek videolarının linkini yapıştır, malzemeleri ve adımları anında ayıklasın.',
    ),
    (
      Icons.auto_awesome,
      'Sınırsız AI Remix & Fırınsız Uyarlama',
      '"Fırınsız yap", "Proteini 45g\'a çıkar" veya "Öğrenci bütçesine uyarla" komutlarıyla her tarifi kişiselleştir.',
    ),
    (
      Icons.record_voice_over_outlined,
      'Canlı Sous-Chef & Sesli Komut Modu',
      'Ellerin kirliyken sesle adım değiştir, sosun kesildiğinde ocağın başında canlı şefe sor.',
    ),
  ];

  Future<void> _subscribe() async {
    setState(() => _isProcessing = true);
    await ref.read(subscriptionProvider.notifier).activateChefPro(_selectedPlan);
    if (!mounted) return;
    setState(() => _isProcessing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🎉 ${_selectedPlan.title} aktif edildi! Tüm AI özellikleri sınırsız açıldı.'),
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
        content: Text('Satın alımlarınız başarıyla geri yüklendi!'),
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
                          'MOB CHEF PRO',
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
                    ? '${widget.triggerFeatureName} İçin Sınırları Kaldır'
                    : 'Mutfağındaki Yapay Zeka Şefini Tam Güçle Aç',
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
                    ? 'Chef Pro aboneliğiniz şu an aktif! Tüm özelliklerin keyfini çıkarın.'
                    : 'Kalan ücretsiz AI hakkınız: ${subState.freeAiCreditsRemaining}. Chef Pro ile dolabındaki malzemeleri, sosyal medya videolarını ve tüm tarifleri sınırsızca dönüştür.',
                style: const TextStyle(
                  fontSize: 13.5,
                  color: MobColors.textSecondary,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),

              // Özellik Listesi
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

              // Plan Seçenekleri
              for (final plan in SubscriptionPlan.values)
                _PlanOptionCard(
                  plan: plan,
                  isSelected: _selectedPlan == plan,
                  isBestValue: plan == SubscriptionPlan.annual,
                  onTap: () => setState(() => _selectedPlan = plan),
                ),

              const SizedBox(height: 16),

              // Ana Satın Alma CTA
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
                        ? '7 Gün Ücretsiz Dene & Pro\'ya Geç'
                        : 'Chef Pro\'yu Başlat',
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Alt Bilgilendirme & Restore Purchases (App Store Guideline 3.1.1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _isProcessing ? null : _restore,
                    child: const Text(
                      'Satın Alımları Geri Yükle',
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
                            content: Text('+3 Ücretsiz AI Deneme Hakkı tanımlandı!'),
                            backgroundColor: MobColors.gold,
                          ),
                        );
                        Navigator.of(context).pop(true);
                      }
                    },
                    child: const Text(
                      '+3 Ücretsiz Hak Al (Demo)',
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
                  'Abonelik App Store hesabınız üzerinden otomatik yenilenir; Ayarlar > Abonelikler menüsünden dilediğiniz an iptal edebilirsiniz. Gizlilik Politikası & Kullanım Koşulları (EULA) geçerlidir.',
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
                              '%55 TASARRUF',
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
