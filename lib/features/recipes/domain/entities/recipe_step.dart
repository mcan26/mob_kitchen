import 'package:equatable/equatable.dart';

/// Pişirme adımı. Kuru talimat değil: ne zaman bittiğini ([sensoryCue]) ve
/// neden yaptığımızı ([chefTip]) da anlatır.
class RecipeStep extends Equatable {
  const RecipeStep({
    required this.stepNumber,
    required this.title,
    required this.instruction,
    required this.sensoryCue,
    required this.chefTip,
    this.timerSeconds,
    this.mistakeWarning,
  });

  /// 1'den başlar.
  final int stepNumber;
  final String title;
  final String instruction;

  /// Görsel / işitsel / koku işareti: dakikaya bağlı kalmadan ne zaman hazır olduğu.
  final String sensoryCue;

  /// Kritik püf noktası ve "neden yapıyoruz?" açıklaması.
  final String chefTip;

  /// Tek dokunuşla başlatılacak sayaç (saniye). Sayaç gerektirmeyen adımlarda null.
  final int? timerSeconds;

  /// Sık yapılan hata uyarısı (isteğe bağlı).
  final String? mistakeWarning;

  factory RecipeStep.fromJson(Map<String, dynamic> json) => RecipeStep(
        stepNumber: (json['step_number'] as num?)?.toInt() ?? 1,
        title: (json['title'] as String?)?.trim() ?? 'Adım',
        instruction: (json['instruction'] as String?)?.trim() ?? '',
        sensoryCue: (json['sensory_cue'] as String?)?.trim() ?? 'Piştiğinde ocaktan al.',
        chefTip: (json['chef_tip'] as String?)?.trim() ?? 'Tavayı ısıt ve acele etme.',
        timerSeconds: (json['timer_seconds'] as num?)?.toInt(),
        mistakeWarning: json['mistake_warning'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'step_number': stepNumber,
        'title': title,
        'instruction': instruction,
        'sensory_cue': sensoryCue,
        'chef_tip': chefTip,
        'timer_seconds': timerSeconds,
        'mistake_warning': mistakeWarning,
      };

  @override
  List<Object?> get props =>
      [stepNumber, title, instruction, sensoryCue, chefTip, timerSeconds, mistakeWarning];
}
