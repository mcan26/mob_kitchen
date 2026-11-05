import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../core/domain/aisle_category.dart';
import '../../../../core/domain/measurement_unit.dart';
import '../../recipes/domain/entities/recipe_enums.dart';

/// Gemini Structured Outputs için katı JSON şeması tanımları.
class GeminiSchemas {
  const GeminiSchemas._();

  /// Tek bir malzemenin şeması.
  static final Schema ingredientSchema = Schema.object(
    description: 'Tarif malzemesi, market ipucu ve alternatifleri',
    properties: {
      'name': Schema.string(description: 'Malzemenin adı (örn. Kemiksiz tavuk but)'),
      'amount': Schema.number(description: 'Miktar (sayısal, örn. 300 veya 1.5)'),
      'unit': Schema.enumString(
        enumValues: MeasurementUnit.jsonValues,
        description: 'Ölçü birimi',
      ),
      'aisle_category': Schema.enumString(
        enumValues: AisleCategory.jsonValues,
        description: 'Market reyonu',
      ),
      'preparation_note': Schema.string(
        description: 'Ön hazırlık notu (örn. ince dilimlenmiş, oda sıcaklığında)',
        nullable: true,
      ),
      'buying_tip': Schema.string(
        description: 'Markette raftan nasıl seçileceğine dair şef tüyosu',
        nullable: true,
      ),
      'substitute_option': Schema.string(
        description: 'Bu malzeme bulunamazsa veya pahalıysa alternatif malzeme önerisi',
        nullable: true,
      ),
    },
    requiredProperties: ['name', 'amount', 'unit', 'aisle_category'],
  );

  /// Tek bir pişirme adımının şeması.
  static final Schema stepSchema = Schema.object(
    description: 'Pişirme adımı, duyusal işaretler ve şef ipucu',
    properties: {
      'step_number': Schema.integer(description: '1\'den başlayan adım numarası'),
      'title': Schema.string(description: 'Adım başlığı (örn. Tavuğu kurula ve mühürle)'),
      'instruction': Schema.string(description: 'Detaylı yapılış talimatı'),
      'sensory_cue': Schema.string(
        description: 'Görsel, işitsel veya koku işareti (ne zaman hazır olduğunu nasıl anlarım?)',
      ),
      'chef_tip': Schema.string(
        description: 'Kritik püf noktası ve neden yapıyoruz bilimsel/teknik açıklaması',
      ),
      'timer_seconds': Schema.integer(
        description: 'Adımda geçen sayaç süresi (saniye cinsinden, gerekmiyorsa null)',
        nullable: true,
      ),
      'mistake_warning': Schema.string(
        description: 'Sık yapılan hata uyarısı',
        nullable: true,
      ),
    },
    requiredProperties: ['step_number', 'title', 'instruction', 'sensory_cue', 'chef_tip'],
  );

  /// Makro değerleri şeması.
  static final Schema macrosSchema = Schema.object(
    description: 'Porsiyon başına tahmini makro değerleri',
    properties: {
      'kcal': Schema.integer(description: 'Porsiyon başına kalori (kcal)'),
      'protein': Schema.integer(description: 'Protein (gram)'),
      'carbs': Schema.integer(description: 'Karbonhidrat (gram)'),
      'fat': Schema.integer(description: 'Yağ (gram)'),
    },
    requiredProperties: ['kcal', 'protein', 'carbs', 'fat'],
  );

  /// Tam Mob Kitchen tarifi için strict şema.
  static final Schema recipeSchema = Schema.object(
    description: 'Eksiksiz Mob Kitchen tarzı tarif çıktısı',
    properties: {
      'title': Schema.string(description: 'İştah açıcı ve vurucu tarif başlığı'),
      'subtitle': Schema.string(description: 'Tarifin tek cümlelik özeti ve cazibesi'),
      'category': Schema.enumString(
        enumValues: RecipeCategory.jsonValues,
        description: 'Tarif kategorisi',
      ),
      'prep_time': Schema.integer(description: 'Hazırlık süresi (dakika)'),
      'cook_time': Schema.integer(description: 'Pişirme süresi (dakika)'),
      'base_servings': Schema.integer(description: 'Kaç kişilik olduğu (varsayılan porsiyon)'),
      'difficulty': Schema.enumString(
        enumValues: Difficulty.jsonValues,
        description: 'Zorluk derecesi',
      ),
      'macros': macrosSchema,
      'tags': Schema.array(
        items: Schema.string(),
        description: 'Tarif etiketleri (örn. tek tava, yüksek protein, 20 dakika)',
      ),
      'chef_golden_rules': Schema.array(
        items: Schema.string(),
        description: 'Bu yemeğin başarılı olması için gereken 2-3 altın kural',
      ),
      'storage_and_reheating_tip': Schema.string(
        description: 'Buzdolabı/dondurucu saklama ve tekrar çıtırlığını/kıvamını koruyarak ısıtma tüyosu',
      ),
      'ingredients': Schema.array(
        items: ingredientSchema,
        description: 'Malzeme listesi',
      ),
      'steps': Schema.array(
        items: stepSchema,
        description: 'Detaylı pişirme adımları',
      ),
    },
    requiredProperties: [
      'title',
      'subtitle',
      'category',
      'prep_time',
      'cook_time',
      'base_servings',
      'difficulty',
      'macros',
      'tags',
      'chef_golden_rules',
      'storage_and_reheating_tip',
      'ingredients',
      'steps',
    ],
  );
}
