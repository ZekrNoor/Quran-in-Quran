class Chapter {
  final bool isMeccan;
  final String transliteratedName;
  final int numberOfVerses;
  final String englishName;
  final String easyTransliteratedName;
  final String glyphCode;
  final int number;
  final int page;
  final int position;

  Chapter(
    this.isMeccan,
    this.transliteratedName,
    this.numberOfVerses,
    this.englishName,
    this.easyTransliteratedName,
    this.glyphCode,
    this.number,
    this.page,
    this.position,
  );

  Chapter.fromJson(Map<String, dynamic> json)
    : isMeccan = json['isMeccan'],
      transliteratedName = json['litName'],
      numberOfVerses = json['nVerses'],
      englishName = json['enName'],
      easyTransliteratedName = json['eLitName'],
      glyphCode = json['gCode'],
      number = json['n'],
      page = json['page'],
      position = json['pos'];
}

class ChaptersData {
  final List<Chapter> chapters;

  ChaptersData(this.chapters);

  ChaptersData.fromJson(Map<String, dynamic> json)
    : chapters = List<Chapter>.from(
        json["chapters"].map((model) => Chapter.fromJson(model)),
      );
}
