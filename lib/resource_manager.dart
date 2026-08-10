import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:quran_in_quran/reader/chapter.dart';

class ResourceManager {
  Future<ChaptersData> _getChaptersData() async {
    try {
      String source = await rootBundle.loadString('assets/quran/chapters.json');
      print('📖 Successfully loaded chapters.json');
      return ChaptersData.fromJson(jsonDecode(source));
    } catch (e) {
      print('❌ Error loading chapters.json: $e');
      rethrow;
    }
  }

  late ChaptersData _chaptersData;

  ChaptersData get chaptersData {
    return _chaptersData;
  }

  Future<bool> load() async {
    try {
      print('⏳ Starting resource load...');
      _chaptersData = await _getChaptersData();
      print('✅ Resources loaded successfully');
      return true;
    } catch (e) {
      print('❌ Resource loading failed: $e');
      return false;
    }
  }
}
