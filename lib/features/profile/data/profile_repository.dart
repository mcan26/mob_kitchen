import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/personal_taste_profile.dart';

/// Tek kullanıcılı profil: SharedPreferences içinde tek bir JSON olarak saklanır.
class ProfileRepository {
  ProfileRepository(this._prefs);

  final SharedPreferences? _prefs;

  static const _key = 'personal_taste_profile_v1';

  bool get hasSavedProfile => _prefs?.containsKey(_key) ?? false;

  PersonalTasteProfile load() {
    final raw = _prefs?.getString(_key);
    if (raw == null) return const PersonalTasteProfile();
    try {
      return PersonalTasteProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      // Bozuk/eski şema: varsayılan profile dön, uygulama açılışını bozma.
      return const PersonalTasteProfile();
    }
  }

  Future<void> save(PersonalTasteProfile profile) async {
    final prefs = _prefs;
    if (prefs == null) return;
    await prefs.setString(_key, jsonEncode(profile.toJson()));
  }
}
