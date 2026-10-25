class VerseTafsir {
  final String tafsirId; // e.g. "nemouneh", "noor", "al_mizan"
  final String tafsirName; // "تفسیر نمونه", "تفسیر نور"
  final String scholar; // "آیت‌الله مکارم شیرازی", "حجت‌الاسلام قرائتی"
  final String content;

  const VerseTafsir({
    required this.tafsirId,
    required this.tafsirName,
    required this.scholar,
    required this.content,
  });

  factory VerseTafsir.fromJson(Map<String, dynamic> json) {
    return VerseTafsir(
      tafsirId: json['tafsir_id'] as String? ?? 'nemouneh',
      tafsirName: json['tafsir_name'] as String? ?? 'تفسیر نمونه',
      scholar: json['scholar'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'tafsir_id': tafsirId,
    'tafsir_name': tafsirName,
    'scholar': scholar,
    'content': content,
  };
}

class VerseTranslation {
  final String translatorId; // e.g. "makarem", "fooladvand", "ansarian"
  final String translatorName; // "مکارم شیرازی", "فولادوند"
  final String text;

  const VerseTranslation({
    required this.translatorId,
    required this.translatorName,
    required this.text,
  });

  factory VerseTranslation.fromJson(Map<String, dynamic> json) {
    return VerseTranslation(
      translatorId: json['translator_id'] as String,
      translatorName: json['translator_name'] as String,
      text: json['text'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'translator_id': translatorId,
    'translator_name': translatorName,
    'text': text,
  };
}
