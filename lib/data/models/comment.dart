class VerseComment {
  final String id;
  final String verseKey; // e.g. "19:21"
  final String author;
  final String content;
  final DateTime createdAt;
  final int likesCount;
  final bool isLikedByMe;
  final bool isSynced;

  const VerseComment({
    required this.id,
    required this.verseKey,
    required this.author,
    required this.content,
    required this.createdAt,
    this.likesCount = 0,
    this.isLikedByMe = false,
    this.isSynced = false,
  });

  VerseComment copyWith({
    String? id,
    String? verseKey,
    String? author,
    String? content,
    DateTime? createdAt,
    int? likesCount,
    bool? isLikedByMe,
    bool? isSynced,
  }) {
    return VerseComment(
      id: id ?? this.id,
      verseKey: verseKey ?? this.verseKey,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      likesCount: likesCount ?? this.likesCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  factory VerseComment.fromJson(Map<String, dynamic> json) {
    return VerseComment(
      id: json['id'] as String,
      verseKey: json['verse_key'] as String,
      author: json['author'] as String? ?? 'کاربر مهمان',
      content: json['content'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      likesCount: json['likes_count'] as int? ?? 0,
      isLikedByMe: json['is_liked_by_me'] as bool? ?? false,
      isSynced: json['is_synced'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'verse_key': verseKey,
    'author': author,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'likes_count': likesCount,
    'is_liked_by_me': isLikedByMe,
    'is_synced': isSynced,
  };
}
