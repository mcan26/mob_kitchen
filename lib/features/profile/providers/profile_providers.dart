import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/core_providers.dart';
import '../data/profile_repository.dart';
import '../domain/entities/personal_taste_profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  try {
    return ProfileRepository(ref.watch(sharedPreferencesProvider));
  } catch (_) {
    return ProfileRepository(null);
  }
});

class ProfileNotifier extends Notifier<PersonalTasteProfile> {
  @override
  PersonalTasteProfile build() => ref.read(profileRepositoryProvider).load();

  Future<void> update(PersonalTasteProfile profile) async {
    state = profile;
    await ref.read(profileRepositoryProvider).save(profile);
  }
}

final personalTasteProfileProvider =
    NotifierProvider<ProfileNotifier, PersonalTasteProfile>(ProfileNotifier.new);
