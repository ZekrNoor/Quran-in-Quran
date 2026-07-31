import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quran_in_quran/local/paths.dart';
import 'package:quran_in_quran/main.dart';
import 'package:quran_in_quran/reader/ayah.dart';

class AyahLoader {
  AyahLoader._();

  static final Map<int, List<Ayah>> _cache = {};

  static Future<List<Ayah>> loadChapter(int chapterNumber) async {
    if (_cache.containsKey(chapterNumber)) {
      return _cache[chapterNumber]!;
    }

    final chapters = QiQApp.resMan.chaptersData.chapters;
    final chapter = chapters[chapterNumber - 1];
    final startPage = chapter.page;
    final endPage = chapterNumber < chapters.length
        ? chapters[chapterNumber].page - 1
        : 604;

    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final ayahsByKey = <String, Ayah>{};

    for (var page = startPage; page <= endPage; page++) {
      final pageFont = 'P$page';
      final pageFile = File(
        '$docDirPath/${LocalPaths.quranDir}/$page.json',
      );

      if (!await pageFile.exists()) {
        continue;
      }

      final pageData =
          jsonDecode(await pageFile.readAsString()) as Map<String, dynamic>;
      final verses = pageData['verses'] as List<dynamic>;

      for (final verse in verses) {
        final verseMap = verse as Map<String, dynamic>;
        final chapterId = verseMap['chapter_id'] as int;

        if (chapterId != chapterNumber) {
          continue;
        }

        final wordsJson = verseMap['words'] as List<dynamic>;
        if (wordsJson.isEmpty) {
          continue;
        }

        final firstWord = wordsJson.first as Map<String, dynamic>;
        final verseKey = firstWord['verse_key'] as String;
        final verseNumber = verseMap['verse_number'] as int;

        final words = wordsJson
            .map(
              (word) => AyahWord(
                code: (word as Map<String, dynamic>)['code_v2'] as String,
                pageFont: pageFont,
              ),
            )
            .toList();

        ayahsByKey[verseKey] = Ayah(
          verseKey: verseKey,
          chapterId: chapterId,
          verseNumber: verseNumber,
          words: words,
        );
      }
    }

    final ayahs = ayahsByKey.values.toList()
      ..sort((a, b) => a.verseNumber.compareTo(b.verseNumber));

    _cache[chapterNumber] = ayahs;
    return ayahs;
  }

  static void clearCache() {
    _cache.clear();
  }
}
