import 'package:equatable/equatable.dart';

enum SubscriptionPlan {
  annual('annual', 'Chef Pro Annual', '€39.99 / year', 'Just €3.33 / month · 7-day free trial'),
  monthly('monthly', 'Chef Pro Monthly', '€6.99 / month', 'Cancel anytime');

  const SubscriptionPlan(this.id, this.title, this.priceLabel, this.subtitle);
  final String id;
  final String title;
  final String priceLabel;
  final String subtitle;
}

class SubscriptionState extends Equatable {
  const SubscriptionState({
    this.isChefPro = false,
    this.activePlan,
    this.freeAiCreditsRemaining = 3,
  });

  final bool isChefPro;
  final SubscriptionPlan? activePlan;
  final int freeAiCreditsRemaining;

  bool get canUseAiFeatures => isChefPro || freeAiCreditsRemaining > 0;

  SubscriptionState copyWith({
    bool? isChefPro,
    SubscriptionPlan? activePlan,
    int? freeAiCreditsRemaining,
  }) {
    return SubscriptionState(
      isChefPro: isChefPro ?? this.isChefPro,
      activePlan: activePlan ?? this.activePlan,
      freeAiCreditsRemaining: freeAiCreditsRemaining ?? this.freeAiCreditsRemaining,
    );
  }

  @override
  List<Object?> get props => [isChefPro, activePlan, freeAiCreditsRemaining];
}
