import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:quran_in_quran/local/paths.dart';

class QuranDataLoader {
  QuranDataLoader._();

  static Future<Map<String, dynamic>> loadPage(int pageNumber) async {
    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final pageFile = File(
      '$docDirPath/${LocalPaths.quranDir}/$pageNumber.json',
    );

    if (await pageFile.exists()) {
      final raw = await pageFile.readAsString();
      try {
        final decoded = jsonDecode(raw);
        if (decoded is Map<String, dynamic>) {
          return normalizePagePayload(decoded);
        }
      } catch (_) {
        // fall through to remote loading
      }
    }

    final uri = Uri.parse(
      'https://api.quran.com/api/v4/verses/by_page/$pageNumber?language=fa&words=true',
    );

    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return {'verses': <Map<String, dynamic>>[]};
    }

    final normalized = normalizePagePayload(jsonDecode(response.body));
    await pageFile.create(recursive: true);
    await pageFile.writeAsString(jsonEncode(normalized), flush: true);
    return normalized;
  }

  static Map<String, dynamic> normalizePagePayload(dynamic payload) {
    final root = payload is Map<String, dynamic>
        ? payload
        : Map<String, dynamic>.from(payload as Map);

    final list = root['verses'] ?? const <dynamic>[];
    final verses = <Map<String, dynamic>>[];

    for (final rawVerse in list) {
      if (rawVerse is! Map) {
        continue;
      }

      final verse = Map<String, dynamic>.from(rawVerse);
      final verseKey = (verse['verse_key'] ?? '').toString();
      final chapterIdValue = verse['chapter_id'] ?? verse['chapter_number'];
      final chapterId = chapterIdValue is int
          ? chapterIdValue
          : int.tryParse(verseKey.split(':').first) ?? 0;
      final verseNumber = verse['verse_number'] is int
          ? verse['verse_number'] as int
          : int.tryParse((verse['verse_number'] ?? '0').toString()) ?? 0;

      final words = <Map<String, dynamic>>[];
      final rawWords = verse['words'] ?? const <dynamic>[];

      for (final rawWord in rawWords) {
        if (rawWord is! Map) {
          continue;
        }

        final word = Map<String, dynamic>.from(rawWord);
        final actualText =
            (word['text'] ?? word['code_v2'] ?? word['code_v1'] ?? '')
                .toString();
        final lineNumber = word['line_number'] is int
            ? word['line_number'] as int
            : int.tryParse((word['line_number'] ?? '0').toString()) ?? 0;

        words.add({
          ...word,
          'text': actualText,
          'code_v2': actualText,
          'code_v1': actualText,
          'line_number': lineNumber,
          'verse_id': verse['id'] ?? word['verse_id'] ?? 0,
          'verse_key': verseKey,
          'chapter_id': chapterId,
          'verse_number': verseNumber,
        });
      }

      verses.add({
        ...verse,
        'chapter_id': chapterId,
        'verse_number': verseNumber,
        'verse_key': verseKey,
        'words': words,
      });
    }

    return {'verses': verses};
  }
}
