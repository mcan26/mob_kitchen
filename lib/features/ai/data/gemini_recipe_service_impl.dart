import 'dart:convert';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

import '../../profile/domain/entities/personal_taste_profile.dart';
import '../../recipes/domain/entities/recipe.dart';
import '../domain/services/gemini_recipe_service.dart';
import 'api_key_repository.dart';
import 'gemini_schemas.dart';

import 'package:http/http.dart' as http;

class GeminiRecipeServiceImpl implements GeminiRecipeService {
  GeminiRecipeServiceImpl({
    required ApiKeyRepository apiKeyRepository,
    required PersonalTasteProfile Function() getTasteProfile,
    String modelName = 'gemini-2.5-flash',
    http.Client? httpClient,
  })  : _apiKeyRepo = apiKeyRepository,
        _getTasteProfile = getTasteProfile,
        _modelName = modelName,
        _httpClient = httpClient;

  final ApiKeyRepository _apiKeyRepo;
  final PersonalTasteProfile Function() _getTasteProfile;
  final String _modelName;
  final http.Client? _httpClient;
  final Uuid _uuid = const Uuid();

  GenerativeModel _createModel({
    required GenerationConfig config,
    required String systemPrompt,
  }) {
    final apiKey = _apiKeyRepo.getApiKey();
    if (apiKey.isEmpty) {
      throw StateError(
        'Gemini API anahtarı ayarlanmamış. Lütfen uygulama ayarlarından veya '
        '--dart-define=GEMINI_API_KEY=... ile geçerli bir API anahtarı sağlayın.',
      );
    }

    final systemInstruction = Content.system(systemPrompt);

    return GenerativeModel(
      model: _modelName,
      apiKey: apiKey,
      systemInstruction: systemInstruction,
      generationConfig: config,
      httpClient: _httpClient,
    );
  }

  @override
  Future<Recipe> generateRecipeFromPantry({
    required List<String> ingredients,
    Uint8List? imageBytes,
    String? mimeType,
    String? additionalPrompt,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.7,
      ),
    );

    final parts = <Part>[];
    final userPrompt = StringBuffer();
    if (ingredients.isNotEmpty) {
      userPrompt
        ..writeln('Elimdeki mevcut malzemeler şunlar:')
        ..writeln(ingredients.map((e) => '- $e').join('\n'));
    } else if (imageBytes != null && imageBytes.isNotEmpty) {
      userPrompt.writeln(
        'Ekteki buzdolabı / tezgah / malzeme fotoğrafındaki tüm yenilebilir gıda malzemelerini tespit et.',
      );
    }

    if (additionalPrompt != null && additionalPrompt.trim().isNotEmpty) {
      userPrompt.writeln('\nÖzel istek / odak: ${additionalPrompt.trim()}');
    }
    userPrompt.writeln(
      '\nBu malzemeleri (ve varsa fotoğraftaki ürünleri) temel alan, eksik temel kiler ürünlerini '
      '(tuz, yağ, un, baharat vb.) akıllıca tamamlayan, Mob Kitchen ruhuna uygun ultra lezzetli, '
      'çıtır/kremsi dokulu bir tarif üret.',
    );

    parts.add(TextPart(userPrompt.toString()));

    if (imageBytes != null && imageBytes.isNotEmpty) {
      parts.add(DataPart(mimeType ?? 'image/jpeg', imageBytes));
    }

    final response = await model.generateContent([Content.multi(parts)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API boş yanıt döndürdü.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'ai_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<Recipe> remixRecipe({
    required Recipe sourceRecipe,
    required String remixInstruction,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.6,
      ),
    );

    final sourceJsonStr = jsonEncode(sourceRecipe.toJson());
    final prompt = '''
Mevcut bir Mob Kitchen tarifini kullanıcının isteği doğrultusunda yeniden kurgula (AI Remix).

MEVCUT KAYNAK TARİF:
$sourceJsonStr

KULLANICININ REMİX İSTEĞİ:
"$remixInstruction"

GÖREV:
1. Kaynak tarifin ruhunu ve lezzet dengesini koru ancak kullanıcının istek ve kısıtlarına tam uyum sağla.
2. Malzeme listesini, porsiyonu, reyonları, market ipuçlarını (buying_tip) ve alternatifleri (substitute_option) güncelle.
3. Adımları yeni tekniğe göre yeniden yaz (örn. fırından tavaya geçtiyse süreler, duyusal işaretler ve şef ipuçları buna göre güncellenmeli).
4. Altın kuralları (chef_golden_rules) yeni tekniğe göre revize et.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API boş yanıt döndürdü.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'remix_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      sourceRecipeId: sourceRecipe.id,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<String> askSousChef({
    required Recipe currentRecipe,
    required int currentStepNumber,
    required String question,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = '''
Sen mutfakta yemek pişiren kullanıcının yanında duran kıdemli bir Mob Kitchen Sous-Chef'isin.
Kullanıcının mutfak ekipmanları: ${profile.equipment.map((e) => e.label).join(', ')}.
Kullanıcı şu an yemek yapıyor, elleri kirli ve tavası ocakta!
Cevapların:
- Çok hızlı, pratik ve doğrudan uygulanabilir olmalı (en fazla 2-4 kısa cümle).
- Panik yapmasını engellemeli, sorunu mutfak kimyasıyla çözmeli (örn: sos kesildiyse soğuk su ekle, et yapıştıysa 30 saniye dokunma).
- Sadece soruya odaklan; gereksiz tebrik veya uzun giriş cümleleri kurma.
''';

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        temperature: 0.4,
      ),
    );

    final step = currentRecipe.steps.firstWhere(
      (s) => s.stepNumber == currentStepNumber,
      orElse: () => currentRecipe.steps.first,
    );

    final prompt = '''
Şu an yapılan tarif: "${currentRecipe.title}"
Kullanıcının bulunduğu adım (#${step.stepNumber} - ${step.title}):
Talimat: "${step.instruction}"
Duyusal İşaret: "${step.sensoryCue}"
Şef İpucu: "${step.chefTip}"

Kullanıcının acil sorusu:
"$question"

Ne yapması gerektiğini tek bir şef refleksiyle kısaca söyle:
''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text?.trim() ?? 'Ateşi hafifçe kısıp malzemeyi kontrol edin ve tavaya biraz sıvı ekleyin.';
  }

  @override
  Future<Recipe> importRecipeFromSocialOrText({
    required String urlOrText,
  }) async {
    final profile = _getTasteProfile();
    final systemPrompt = _buildChefSystemPrompt(profile);

    final model = _createModel(
      systemPrompt: systemPrompt,
      config: GenerationConfig(
        responseMimeType: 'application/json',
        responseSchema: GeminiSchemas.recipeSchema,
        temperature: 0.5,
      ),
    );

    final prompt = '''
Kullanıcı sosyal medyadan (Instagram Reels, TikTok, YouTube Shorts), bir yemek blogu linkinden veya açıklama metninden bir tarif aktarmak istiyor.

KULLANICININ GİRDİSİ (LİNK VEYA METİN):
"""
${urlOrText.trim()}
"""

GÖREV:
1. Girdideki yemeği, malzemeleri, oranları ve pişirme adımlarını analiz et. Eksik bırakılmış gramajları veya süreleri profesyonel şef bilginle tamamla.
2. Kullanıcının kişisel mutfak profilindeki ekipman ve alerji kurallarına tam uyum sağla.
3. Her adıma mutlaka duyusal işaret (sensory_cue), şef sırrı (chef_tip) ve kritik adımlara zamanlayıcı (timer_seconds) ekle.
4. Her malzemeye uygun süpermarket reyonu (aisle_category), market tüyosu (buying_tip) ve alternatif (substitute_option) ata.
''';

    final response = await model.generateContent([Content.text(prompt)]);
    final rawText = response.text;
    if (rawText == null || rawText.trim().isEmpty) {
      throw StateError('Gemini API boş yanıt döndürdü.');
    }

    final recipeJson = jsonDecode(rawText) as Map<String, dynamic>;
    final newId = 'social_${_uuid.v4()}';
    return Recipe.fromJson(
      recipeJson,
      id: newId,
      isBuiltIn: false,
      createdAt: DateTime.now(),
    );
  }

  static String _buildChefSystemPrompt(PersonalTasteProfile profile) {
    final buffer = StringBuffer()
      ..writeln('Sen "Mob Kitchen" (Mob) ekolünün Baş Ar-Ge Şefisin.')
      ..writeln('Tariflerin daima: cesur, bol soslu, çıtır/ipeksi doku kontrastlı, haftaiçine uygun ve yüksek lezzet odaklıdır.')
      ..writeln('Asla kuru talimat verme; her adımda ne zaman hazır olduğunu duyusal işaretle (sensory_cue) ve neden yaptığımızı (chef_tip) açıkla.')
      ..writeln('\nKULLANICININ KİŞİSEL MUTFAK PROFİLİ VE ZORUNLU KISITLARI:');

    // Ekipman kısıtları
    final eqLabels = profile.equipment.map((e) => e.label).join(', ');
    buffer.writeln('- Mevcut Ekipmanlar: $eqLabels');
    if (!profile.hasOven) {
      buffer.writeln('  * KRİTİK: Kullanıcının evinde FIRIN YOKTUR! ASLA fırın gerektiren tarif önerme; tüm pişirme tava, tencere veya airfryer\'da bitecek şekilde kurgulanmalı.');
    }

    // Beslenme hedefleri
    if (profile.dietGoals.isNotEmpty) {
      buffer.writeln('- Beslenme Hedefleri: ${profile.dietGoals.join(', ')}');
    }

    // Alerjiler
    if (profile.allergies.isNotEmpty) {
      buffer.writeln('- ALERJİLER (KESİNLİKLE YASAK, HAYATİ TEHLİKE): ${profile.allergies.join(', ')}');
    }

    // Sevmediği malzemeler
    if (profile.dislikedIngredients.isNotEmpty) {
      buffer.writeln('- Kullanıcının Kesinlikle Sevmediği Malzemeler (ASLA KULLANMA): ${profile.dislikedIngredients.join(', ')}');
    }

    // Acı toleransı
    final spiceDesc = switch (profile.spiceLevel) {
      0 => 'Sıfır acı (hiç acı biber kullanma)',
      1 => 'Hafif acı',
      2 => 'Orta / dengeli acı',
      _ => 'Yüksek acı toleransı (cesurca acı kullanabilirsin)',
    };
    buffer.writeln('- Acı Seviyesi: $spiceDesc');

    if (profile.extraNotes.isNotEmpty) {
      buffer.writeln('- Özel Notlar: ${profile.extraNotes}');
    }

    buffer.writeln('\nTüm çıktıları Türkçe üret. Ölçü birimlerini ve reyonları kesinlikle izin verilen enum listesinden seç.');
    return buffer.toString();
  }
}
