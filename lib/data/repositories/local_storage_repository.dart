import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/comment.dart';

class LocalStorageRepository {
  static const String _commentsKey = 'qiq_local_comments';
  static const String _bookmarksKey = 'qiq_local_bookmarks';
  static const String _lastReadPageKey = 'qiq_last_read_page';
  static const String _lastReadSurahKey = 'qiq_last_read_surah';
  static const String _lastReadAyahKey = 'qiq_last_read_ayah';

  SharedPreferences? _prefs;

  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  // --- COMMENTS / REFLECTIONS ---

  Future<List<VerseComment>> getCommentsForVerse(String verseKey) async {
    final prefs = await _getPrefs();
    final rawJson = prefs.getString(_commentsKey);
    if (rawJson == null || rawJson.isEmpty) {
      return _getSeedComments(verseKey);
    }

    try {
      final List<dynamic> list = jsonDecode(rawJson);
      final allComments = list.map((item) => VerseComment.fromJson(item as Map<String, dynamic>)).toList();
      final filtered = allComments.where((c) => c.verseKey == verseKey).toList();
      if (filtered.isEmpty) {
        return _getSeedComments(verseKey);
      }
      return filtered;
    } catch (_) {
      return _getSeedComments(verseKey);
    }
  }

  Future<void> addComment(VerseComment comment) async {
    final prefs = await _getPrefs();
    final rawJson = prefs.getString(_commentsKey);
    List<VerseComment> all = [];
    if (rawJson != null && rawJson.isNotEmpty) {
      try {
        final List<dynamic> list = jsonDecode(rawJson);
        all = list.map((item) => VerseComment.fromJson(item as Map<String, dynamic>)).toList();
      } catch (_) {}
    }

    all.insert(0, comment);
    await prefs.setString(_commentsKey, jsonEncode(all.map((c) => c.toJson()).toList()));
  }

  Future<void> toggleLikeComment(String commentId) async {
    final prefs = await _getPrefs();
    final rawJson = prefs.getString(_commentsKey);
    if (rawJson == null) return;

    try {
      final List<dynamic> list = jsonDecode(rawJson);
      final all = list.map((item) => VerseComment.fromJson(item as Map<String, dynamic>)).toList();
      final index = all.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        final current = all[index];
        final newIsLiked = !current.isLikedByMe;
        final newLikes = newIsLiked ? current.likesCount + 1 : (current.likesCount > 0 ? current.likesCount - 1 : 0);
        all[index] = current.copyWith(
          isLikedByMe: newIsLiked,
          likesCount: newLikes,
        );
        await prefs.setString(_commentsKey, jsonEncode(all.map((c) => c.toJson()).toList()));
      }
    } catch (_) {}
  }

  // --- LAST READ PROGRESS ---

  Future<Map<String, int>> getLastRead() async {
    final prefs = await _getPrefs();
    return {
      'page': prefs.getInt(_lastReadPageKey) ?? 1,
      'surah': prefs.getInt(_lastReadSurahKey) ?? 1,
      'ayah': prefs.getInt(_lastReadAyahKey) ?? 1,
    };
  }

  Future<void> saveLastRead({required int page, required int surah, required int ayah}) async {
    final prefs = await _getPrefs();
    await prefs.setInt(_lastReadPageKey, page);
    await prefs.setInt(_lastReadSurahKey, surah);
    await prefs.setInt(_lastReadAyahKey, ayah);
  }

  // --- BOOKMARKS ---

  Future<List<String>> getBookmarks() async {
    final prefs = await _getPrefs();
    return prefs.getStringList(_bookmarksKey) ?? [];
  }

  Future<bool> toggleBookmark(String verseKey) async {
    final prefs = await _getPrefs();
    final bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    bool isBookmarked = false;
    if (bookmarks.contains(verseKey)) {
      bookmarks.remove(verseKey);
      isBookmarked = false;
    } else {
      bookmarks.add(verseKey);
      isBookmarked = true;
    }
    await prefs.setStringList(_bookmarksKey, bookmarks);
    return isBookmarked;
  }

  // Seed default community reflections for demonstration
  List<VerseComment> _getSeedComments(String verseKey) {
    return [
      VerseComment(
        id: 'seed-1',
        verseKey: verseKey,
        author: 'محمد سپهری',
        content: 'تدبر در این آیه نشان‌دهنده آرامش عمیق و توکل به رحمت پروردگار است. کلمات با ظرافت خاصی بار معنایی امید را منتقل می‌کنند.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        likesCount: 14,
      ),
      VerseComment(
        id: 'seed-2',
        verseKey: verseKey,
        author: 'احمد سلطانی',
        content: 'درک شخصی من این بود که صبر در کنار امید، کلید اصلی گشایش در تنگناهاست.',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        likesCount: 5,
      ),
    ];
  }
}
