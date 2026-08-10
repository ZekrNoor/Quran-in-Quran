import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_in_quran/reader/chapter.dart';

class ResourceManager {
  Future<ChaptersData> _getChaptersData() async {
    String source = await rootBundle.loadString('assets/quran/chapters.json');
    return ChaptersData.fromJson(jsonDecode(source));
  }

  late ChaptersData _chaptersData;

  ChaptersData get chaptersData {
    return _chaptersData;
  }

  Future<bool> load() async {
    try {
      _chaptersData = await _getChaptersData();
      return true;
    } catch (e) {
      return false;
    }
  }
}
