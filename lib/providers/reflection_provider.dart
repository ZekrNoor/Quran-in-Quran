import 'package:flutter/foundation.dart';
import '../data/models/comment.dart';
import '../data/repositories/local_storage_repository.dart';

class ReflectionProvider extends ChangeNotifier {
  final LocalStorageRepository _storageRepo;

  ReflectionProvider({LocalStorageRepository? storageRepo})
      : _storageRepo = storageRepo ?? LocalStorageRepository();

  List<VerseComment> _comments = [];
  bool _isLoading = false;
  String _activeTafsirId = 'nemouneh';
  String _activeTranslatorId = 'makarem';
  List<String> _bookmarks = [];

  List<VerseComment> get comments => _comments;
  bool get isLoading => _isLoading;
  String get activeTafsirId => _activeTafsirId;
  String get activeTranslatorId => _activeTranslatorId;
  List<String> get bookmarks => _bookmarks;

  bool isBookmarked(String verseKey) => _bookmarks.contains(verseKey);

  Future<void> init() async {
    _bookmarks = await _storageRepo.getBookmarks();
    notifyListeners();
  }

  Future<void> loadComments(String verseKey) async {
    _isLoading = true;
    notifyListeners();

    _comments = await _storageRepo.getCommentsForVerse(verseKey);
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addComment({
    required String verseKey,
    required String content,
    String author = 'شما (کاربر)',
  }) async {
    if (content.trim().isEmpty) return;

    final newComment = VerseComment(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      verseKey: verseKey,
      author: author,
      content: content.trim(),
      createdAt: DateTime.now(),
      likesCount: 0,
      isLikedByMe: false,
      isSynced: false,
    );

    await _storageRepo.addComment(newComment);
    _comments.insert(0, newComment);
    notifyListeners();
  }

  Future<void> toggleLike(String commentId) async {
    final index = _comments.indexWhere((c) => c.id == commentId);
    if (index != -1) {
      final current = _comments[index];
      final newIsLiked = !current.isLikedByMe;
      final newLikes = newIsLiked
          ? current.likesCount + 1
          : (current.likesCount > 0 ? current.likesCount - 1 : 0);

      _comments[index] = current.copyWith(
        isLikedByMe: newIsLiked,
        likesCount: newLikes,
      );
      notifyListeners();

      await _storageRepo.toggleLikeComment(commentId);
    }
  }

  void setActiveTafsir(String id) {
    _activeTafsirId = id;
    notifyListeners();
  }

  void setActiveTranslator(String id) {
    _activeTranslatorId = id;
    notifyListeners();
  }

  Future<void> toggleBookmark(String verseKey) async {
    final isAdded = await _storageRepo.toggleBookmark(verseKey);
    if (isAdded) {
      if (!_bookmarks.contains(verseKey)) _bookmarks.add(verseKey);
    } else {
      _bookmarks.remove(verseKey);
    }
    notifyListeners();
  }
}
