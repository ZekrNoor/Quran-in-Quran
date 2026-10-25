class Ayah {
  final int surahNumber;
  final int verseNumber;
  final String verseKey; // e.g. "19:21"
  final String text; // Uthmanic Arabic text
  final String translation; // Persian translation
  final int pageNumber;
  final int juzNumber;
  final int hizbNumber;
  final String? audioUrl;

  const Ayah({
    required this.surahNumber,
    required this.verseNumber,
    required this.verseKey,
    required this.text,
    required this.translation,
    required this.pageNumber,
    required this.juzNumber,
    required this.hizbNumber,
    this.audioUrl,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      surahNumber: json['surah_number'] as int? ?? 1,
      verseNumber: json['verse_number'] as int? ?? 1,
      verseKey: json['verse_key'] as String? ?? '1:1',
      text: json['text'] as String? ?? '',
      translation: json['translation'] as String? ?? '',
      pageNumber: json['page_number'] as int? ?? 1,
      juzNumber: json['juz_number'] as int? ?? 1,
      hizbNumber: json['hizb_number'] as int? ?? 1,
      audioUrl: json['audio_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'surah_number': surahNumber,
    'verse_number': verseNumber,
    'verse_key': verseKey,
    'text': text,
    'translation': translation,
    'page_number': pageNumber,
    'juz_number': juzNumber,
    'hizb_number': hizbNumber,
    'audio_url': audioUrl,
  };
}
