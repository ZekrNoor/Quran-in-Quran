import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:provider/provider.dart';
import '../data/models/ayah.dart';
import '../data/repositories/quran_repository.dart';
import '../providers/reflection_provider.dart';

class VerseReflectionModal extends StatefulWidget {
  final Ayah ayah;

  const VerseReflectionModal({super.key, required this.ayah});

  static void show(BuildContext context, Ayah ayah) {
    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => VerseReflectionModal(ayah: ayah),
    );
  }

  @override
  State<VerseReflectionModal> createState() => _VerseReflectionModalState();
}

class _VerseReflectionModalState extends State<VerseReflectionModal> {
  int _activeSegment = 0; // 0: نظرات, 1: تفسیر, 2: ترجمه
  final TextEditingController _commentController = TextEditingController();
  final QuranRepository _quranRepo = QuranRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReflectionProvider>().loadComments(widget.ayah.verseKey);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final provider = context.watch<ReflectionProvider>();

    return Container(
      height: mediaQuery.size.height * 0.9,
      decoration: const BoxDecoration(
        color: CupertinoColors.systemBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Handle bar
            const SizedBox(height: 12),
            Container(
              width: 44,
              height: 5,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey4,
                borderRadius: BorderRadius.circular(3),
              ),
            ),

            // Top Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Icon(
                      CupertinoIcons.chevron_down,
                      color: CupertinoColors.label,
                      size: 24,
                    ),
                  ),
                  Text(
                    'تدبّر در آیه (${widget.ayah.verseKey})',
                    style: const TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.label,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => provider.toggleBookmark(widget.ayah.verseKey),
                    child: Icon(
                      provider.isBookmarked(widget.ayah.verseKey)
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
                      color: const Color(0xFFD4AF37),
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),

            // Verse preview mini-card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: CupertinoColors.secondarySystemBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.ayah.text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Uthmanic',
                      fontSize: 17,
                      height: 1.8,
                      color: CupertinoColors.label,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.ayah.translation,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 13,
                      height: 1.5,
                      color: CupertinoColors.secondaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),
            ),

            // Segmented Control Tabs (نظرات / تفسیر / ترجمه)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl<int>(
                  groupValue: _activeSegment,
                  backgroundColor: CupertinoColors.tertiarySystemFill,
                  thumbColor: const Color(0xFFD4AF37),
                  children: {
                    0: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'نظرات',
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 14,
                          fontWeight: _activeSegment == 0 ? FontWeight.bold : FontWeight.normal,
                          color: _activeSegment == 0 ? CupertinoColors.black : CupertinoColors.label,
                        ),
                      ),
                    ),
                    1: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'تفسیر',
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 14,
                          fontWeight: _activeSegment == 1 ? FontWeight.bold : FontWeight.normal,
                          color: _activeSegment == 1 ? CupertinoColors.black : CupertinoColors.label,
                        ),
                      ),
                    ),
                    2: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'ترجمه',
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 14,
                          fontWeight: _activeSegment == 2 ? FontWeight.bold : FontWeight.normal,
                          color: _activeSegment == 2 ? CupertinoColors.black : CupertinoColors.label,
                        ),
                      ),
                    ),
                  },
                  onValueChanged: (val) {
                    if (val != null) setState(() => _activeSegment = val);
                  },
                ),
              ),
            ),

            // Content Body based on active tab
            Expanded(
              child: _buildTabContent(context, provider),
            ),

            // Bottom Input bar (Only for comments tab)
            if (_activeSegment == 0) _buildCommentInput(context, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, ReflectionProvider provider) {
    if (_activeSegment == 0) {
      return _buildCommentsTab(context, provider);
    } else if (_activeSegment == 1) {
      return _buildTafsirTab(context, provider);
    } else {
      return _buildTranslationTab(context, provider);
    }
  }

  // --- TAB 1: COMMENTS ---
  Widget _buildCommentsTab(BuildContext context, ReflectionProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }

    if (provider.comments.isEmpty) {
      return Center(
        child: Text(
          'هنوز نظری برای این آیه ثبت نشده است.\nاولین نفری باشید که دیدگاه خود را می‌نویسد.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Estedad',
            fontSize: 14,
            color: CupertinoColors.secondaryLabel.resolveFrom(context),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: provider.comments.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final comment = provider.comments[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: CupertinoColors.secondarySystemBackground,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: CupertinoColors.separator.resolveFrom(context),
              width: 0.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Author row
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      comment.author.isNotEmpty ? comment.author[0] : 'U',
                      style: const TextStyle(
                        color: Color(0xFFD4AF37),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comment.author,
                          style: const TextStyle(
                            fontFamily: 'Estedad',
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '${comment.createdAt.hour}:${comment.createdAt.minute.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            fontFamily: 'Estedad',
                            fontSize: 11,
                            color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Like action
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    onPressed: () => provider.toggleLike(comment.id),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${comment.likesCount}',
                          style: TextStyle(
                            fontFamily: 'Estedad',
                            fontSize: 12,
                            color: comment.isLikedByMe ? const Color(0xFFD4AF37) : CupertinoColors.secondaryLabel,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          comment.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: comment.isLikedByMe ? const Color(0xFFD4AF37) : CupertinoColors.secondaryLabel,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                comment.content,
                style: const TextStyle(
                  fontFamily: 'Estedad',
                  fontSize: 13.5,
                  height: 1.6,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- TAB 2: TAFSIR ---
  Widget _buildTafsirTab(BuildContext context, ReflectionProvider provider) {
    final tafsirs = _quranRepo.getTafsirsForVerse(widget.ayah.verseKey);
    final activeTafsir = tafsirs.firstWhere(
      (t) => t.tafsirId == provider.activeTafsirId,
      orElse: () => tafsirs.first,
    );

    return Column(
      children: [
        // Tafsir Source Selector
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: tafsirs.map((tafsir) {
              final isSelected = tafsir.tafsirId == provider.activeTafsirId;
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: isSelected ? const Color(0xFFD4AF37) : CupertinoColors.secondarySystemBackground,
                  borderRadius: BorderRadius.circular(20),
                  onPressed: () => provider.setActiveTafsir(tafsir.tafsirId),
                  child: Text(
                    tafsir.tafsirName,
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? CupertinoColors.black : CupertinoColors.label,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        // Tafsir Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CupertinoColors.secondarySystemBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activeTafsir.tafsirName,
                        style: const TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFD4AF37),
                        ),
                      ),
                      Text(
                        activeTafsir.scholar,
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 12,
                          color: CupertinoColors.secondaryLabel.resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  Text(
                    activeTafsir.content,
                    style: const TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 14.5,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- TAB 3: TRANSLATION ---
  Widget _buildTranslationTab(BuildContext context, ReflectionProvider provider) {
    final translations = _quranRepo.getTranslationsForVerse(widget.ayah.verseKey);

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: translations.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = translations[index];
        final isSelected = item.translatorId == provider.activeTranslatorId;

        return GestureDetector(
          onTap: () => provider.setActiveTranslator(item.translatorId),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFFD4AF37).withValues(alpha: 0.08)
                  : CupertinoColors.secondarySystemBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? const Color(0xFFD4AF37) : CupertinoColors.separator.resolveFrom(context),
                width: isSelected ? 1.5 : 0.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.translatorName,
                      style: TextStyle(
                        fontFamily: 'Estedad',
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isSelected ? const Color(0xFFD4AF37) : CupertinoColors.label,
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        CupertinoIcons.checkmark_circle_fill,
                        color: Color(0xFFD4AF37),
                        size: 20,
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.text,
                  style: const TextStyle(
                    fontFamily: 'Estedad',
                    fontSize: 13.5,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- BOTTOM COMMENT INPUT ---
  Widget _buildCommentInput(BuildContext context, ReflectionProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemBackground,
        border: Border(
          top: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CupertinoTextField(
              controller: _commentController,
              placeholder: 'نظر و تأمل خود را در مورد این آیه بنویسید...',
              placeholderStyle: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 13,
                color: CupertinoColors.placeholderText.resolveFrom(context),
              ),
              style: const TextStyle(fontFamily: 'Estedad', fontSize: 14),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: CupertinoColors.tertiarySystemFill,
                borderRadius: BorderRadius.circular(20),
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(width: 8),
          CupertinoButton(
            padding: const EdgeInsets.all(10),
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(24),
            onPressed: () {
              if (_commentController.text.trim().isNotEmpty) {
                provider.addComment(
                  verseKey: widget.ayah.verseKey,
                  content: _commentController.text,
                );
                _commentController.clear();
              }
            },
            child: const Icon(
              CupertinoIcons.arrow_up,
              color: CupertinoColors.black,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class Divider extends StatelessWidget {
  final double height;
  const Divider({super.key, this.height = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      margin: EdgeInsets.symmetric(vertical: height / 2),
      color: CupertinoColors.separator.resolveFrom(context),
    );
  }
}
