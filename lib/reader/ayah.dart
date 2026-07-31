class AyahWord {
  const AyahWord({
    required this.code,
    required this.pageFont,
  });

  final String code;
  final String pageFont;
}

class Ayah {
  const Ayah({
    required this.verseKey,
    required this.chapterId,
    required this.verseNumber,
    required this.words,
  });

  final String verseKey;
  final int chapterId;
  final int verseNumber;
  final List<AyahWord> words;
}
