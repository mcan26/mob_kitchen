import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/core_providers.dart';
import '../domain/subscription_state.dart';

class SubscriptionRepository {
  SubscriptionRepository(this._prefs);

  final SharedPreferences? _prefs;

  static const _proKey = 'chef_pro_active_v1';
  static const _planKey = 'chef_pro_plan_v1';
  static const _creditsKey = 'free_ai_credits_v1';
  static const int defaultFreeCredits = 3;

  SubscriptionState load() {
    final prefs = _prefs;
    if (prefs == null) {
      return const SubscriptionState();
    }
    final isPro = prefs.getBool(_proKey) ?? false;
    final planId = prefs.getString(_planKey);
    final credits = prefs.getInt(_creditsKey) ?? defaultFreeCredits;

    final plan = SubscriptionPlan.values.where((p) => p.id == planId).firstOrNull;
    return SubscriptionState(
      isChefPro: isPro,
      activePlan: plan,
      freeAiCreditsRemaining: credits,
    );
  }

  Future<void> save(SubscriptionState state) async {
    final prefs = _prefs;
    if (prefs == null) return;
    await prefs.setBool(_proKey, state.isChefPro);
    if (state.activePlan != null) {
      await prefs.setString(_planKey, state.activePlan!.id);
    } else {
      await prefs.remove(_planKey);
    }
    await prefs.setInt(_creditsKey, state.freeAiCreditsRemaining);
  }
}

final subscriptionRepositoryProvider = Provider<SubscriptionRepository>((ref) {
  SharedPreferences? prefs;
  try {
    prefs = ref.watch(sharedPreferencesProvider);
  } catch (_) {
    // Widget testlerinde sharedPreferencesProvider override edilmemişse güvenli fallback
    prefs = null;
  }
  return SubscriptionRepository(prefs);
});

class SubscriptionNotifier extends Notifier<SubscriptionState> {
  @override
  SubscriptionState build() => ref.watch(subscriptionRepositoryProvider).load();

  /// AI özelliği kullanıldığında çağrılır. Pro ise sınırsız döner;
  /// ücretsiz kullanıcıysa 1 kredi düşer. Kredi bittiyse `false` döner.
  Future<bool> consumeAiCreditIfNeeded() async {
    if (state.isChefPro) return true;
    if (state.freeAiCreditsRemaining <= 0) return false;

    final next = state.copyWith(
      freeAiCreditsRemaining: state.freeAiCreditsRemaining - 1,
    );
    state = next;
    await ref.read(subscriptionRepositoryProvider).save(next);
    return true;
  }

  Future<void> activateChefPro(SubscriptionPlan plan) async {
    final next = state.copyWith(
      isChefPro: true,
      activePlan: plan,
    );
    state = next;
    await ref.read(subscriptionRepositoryProvider).save(next);
  }

  Future<void> restorePurchases() async {
    final next = state.copyWith(
      isChefPro: true,
      activePlan: state.activePlan ?? SubscriptionPlan.annual,
    );
    state = next;
    await ref.read(subscriptionRepositoryProvider).save(next);
  }

  Future<void> grantBonusCredits(int count) async {
    final next = state.copyWith(
      freeAiCreditsRemaining: state.freeAiCreditsRemaining + count,
    );
    state = next;
    await ref.read(subscriptionRepositoryProvider).save(next);
  }
}

final subscriptionProvider =
    NotifierProvider<SubscriptionNotifier, SubscriptionState>(SubscriptionNotifier.new);
