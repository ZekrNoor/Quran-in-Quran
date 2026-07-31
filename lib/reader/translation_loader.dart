import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:quran_in_quran/local/paths.dart';

class TranslationLoader {
  TranslationLoader._();

  static Map<String, String>? _cache;

  static Future<Map<String, String>> loadAll() async {
    if (_cache != null) {
      return _cache!;
    }

    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final translationFile = File(
      '$docDirPath/${LocalPaths.translationsPath}',
    );

    if (await translationFile.exists()) {
      final data = jsonDecode(await translationFile.readAsString());
      if (data is Map<String, dynamic>) {
        _cache = data.map(
          (key, value) => MapEntry(key, value.toString()),
        );
        return _cache!;
      }
    }

    _cache = {};
    return _cache!;
  }

  static Future<String?> get(String verseKey) async {
    final translations = await loadAll();
    return translations[verseKey];
  }

  static void clearCache() {
    _cache = null;
  }
}
