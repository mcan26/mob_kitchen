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
    'Yüksek protein',
    'Hızlı (≤ 20 dk)',
    'Bütçe dostu',
    'Düşük karbonhidrat',
    'Tek tava / Az bulaşık',
    'Dengeli Ev Yemeği',
  ];

  static const _commonAllergies = [
    'Gluten',
    'Laktoz / Süt',
    'Fıstık / Kuruyemiş',
    'Yumurta',
    'Deniz Ürünleri',
    'Soya',
  ];

  static const _commonDislikes = [
    'Kişniş',
    'Mantar',
    'Kereviz',
    'Bamya',
    'Sakatat',
    'Dereotu',
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
          content: Text('Mutfak profiliniz ve tercihleriniz kaydedildi!'),
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
          'Mutfak Profilim & Ayarlar',
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
              'Kaydet',
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
              // 1. Chef Pro Durum Kartı
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
                            subState.isChefPro ? 'MOB CHEF PRO AKTİF' : 'ÜCRETSİZ PLAN',
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
                                ? 'Sınırsız AI Tarif, Fotoğraf Vizyonu ve Sous-Chef açık.'
                                : 'Kalan ücretsiz AI hakkınız: ${subState.freeAiCreditsRemaining}',
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
                          'Pro\'ya Geç',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Mutfak Ekipmanlarım
              const _SectionHeader(
                icon: Icons.kitchen_outlined,
                title: 'Mutfak Ekipmanlarım',
                subtitle: 'Seçmediğin ekipmanlar (örn. Fırın) AI tariflerinde asla kullanılmaz.',
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
                          'Fırınsız Mod Aktif: Gemini Şef tüm tarifleri sadece tava/tencere/airfryer ile pişecek şekilde kurgular.',
                          style: TextStyle(fontSize: 12, color: MobColors.gold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 24),

              // 3. Beslenme & Mutfak Hedeflerim
              const _SectionHeader(
                icon: Icons.track_changes_outlined,
                title: 'Beslenme & Mutfak Hedeflerim',
                subtitle: 'Tarif önerilerinde önceliklendirilecek hedefler.',
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

              // 4. Alerjiler & Hayati Kısıtlar
              const _SectionHeader(
                icon: Icons.health_and_safety_outlined,
                title: 'Alerjilerim (Hayati Kısıtlar)',
                subtitle: 'Bu malzemeler AI tariflerinde kesinlikle yasaklanır ve katalogda uyarı verir.',
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

              // 5. Sevmediğim Malzemeler
              const _SectionHeader(
                icon: Icons.block_outlined,
                title: 'Sevmediğim Malzemeler',
                subtitle: 'Tadını sevmediğiniz malzemeleri işaretleyin.',
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

              // 6. Acı Seviyesi & Varsayılan Porsiyon
              const _SectionHeader(
                icon: Icons.whatshot_outlined,
                title: 'Acı Toleransı & Varsayılan Porsiyon',
                subtitle: 'Evde genellikle kaç kişilik ve ne kadar acı pişiriyorsunuz?',
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
                          'Acı Seviyesi:',
                          style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: MobColors.textPrimary),
                        ),
                        Text(
                          switch (_spiceLevel) {
                            0 => '0 · Sıfır Acı',
                            1 => '1 · Hafif Tatlı Acı',
                            2 => '2 · Dengeli / Orta Acı',
                            _ => '3 · Ateşli Şef Acısı 🌶️',
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
                      'Varsayılan Porsiyon:',
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
                            '$count Kişi',
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

              // 7. Özel Notlar
              const _SectionHeader(
                icon: Icons.edit_note_outlined,
                title: 'Şefe Özel Notunuz',
                subtitle: 'Örn: "Tavuk göğsü yerine her zaman kemiksiz but tercih ederim."',
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _extraNotesController,
                maxLines: 2,
                style: const TextStyle(color: MobColors.textPrimary, fontSize: 13.5),
                decoration: const InputDecoration(
                  hintText: 'Kişisel mutfak notunuzu buraya yazın...',
                ),
              ),
              const SizedBox(height: 24),

              // 8. Geliştirici / Özel Gemini API Bağlantısı & Veri Gizliliği (Guideline 5.1.1)
              const _SectionHeader(
                icon: Icons.vpn_key_outlined,
                title: 'AI Bağlantısı & Veri Gizliliği',
                subtitle: 'Gemini 2.5 Flash AI motoru yapılandırması ve gizlilik bildirimi.',
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
                                ? 'Aktif Anahtar: ${apiKeyRepo.maskedApiKey}'
                                : 'Özel Gemini API Anahtarı (Opsiyonel / Geliştirici Modu)',
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
                            child: const Text('Sıfırla', style: TextStyle(color: MobColors.red, fontSize: 12)),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _apiKeyController,
                      obscureText: true,
                      style: const TextStyle(color: MobColors.textPrimary, fontSize: 13),
                      decoration: const InputDecoration(
                        hintText: 'AIzaSy... (Yeni anahtar girmek için yazın)',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '🔒 Gizlilik Bildirimi (Apple Guideline 5.1.1): Dolaptan Tarif Üret, AI Remix ve Canlı Sous-Chef özelliklerini kullandığınızda yalnızca girdiğiniz malzeme listesi ve seçtiğiniz yemek fotoğrafı tarif oluşturmak amacıyla Google Gemini AI servisine iletilir; kişisel kimlik verileriniz paylaşılmaz.',
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
                    'Mutfak Profilimi Kaydet',
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
