import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:provider/provider.dart';
import '../data/models/ayah.dart';
import '../providers/reflection_provider.dart';
import 'verse_reflection_modal.dart';

class VerseCard extends StatelessWidget {
  final Ayah ayah;
  final VoidCallback? onPlayAudio;

  const VerseCard({
    super.key,
    required this.ayah,
    this.onPlayAudio,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReflectionProvider>();
    final isBookmarked = provider.isBookmarked(ayah.verseKey);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.18),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top Bar (Verse indicator & Actions)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'آیه ${ayah.verseNumber}',
                  style: const TextStyle(
                    fontFamily: 'Estedad',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ),
              Row(
                children: [
                  if (ayah.audioUrl != null)
                    CupertinoButton(
                      padding: const EdgeInsets.all(6),
                      onPressed: onPlayAudio,
                      child: const Icon(
                        CupertinoIcons.play_circle,
                        color: Color(0xFFD4AF37),
                        size: 22,
                      ),
                    ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(6),
                    onPressed: () => provider.toggleBookmark(ayah.verseKey),
                    child: Icon(
                      isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                      color: const Color(0xFFD4AF37),
                      size: 20,
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(6),
                    onPressed: () {
                      // Share action placeholder
                    },
                    child: const Icon(
                      CupertinoIcons.share,
                      color: CupertinoColors.secondaryLabel,
                      size: 19,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Arabic Text
          Text(
            ayah.text,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'Uthmanic',
              fontSize: 20,
              height: 2.1,
              color: CupertinoColors.label,
            ),
          ),

          const SizedBox(height: 10),

          // Persian Translation
          Text(
            ayah.translation,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'Estedad',
              fontSize: 13.5,
              height: 1.6,
              color: CupertinoColors.secondaryLabel.resolveFrom(context),
            ),
          ),

          const SizedBox(height: 14),

          // Bottom Bar with "تدبّر در آیه >" button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stats
              Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_outline,
                    size: 16,
                    color: CupertinoColors.tertiaryLabel,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'نظرات',
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 11,
                      color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                    ),
                  ),
                ],
              ),

              // Button: تدبّر در آیه >
              CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
                onPressed: () => VerseReflectionModal.show(context, ayah),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'تدبّر در آیه',
                      style: TextStyle(
                        fontFamily: 'Estedad',
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4AF37),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      CupertinoIcons.chevron_back,
                      size: 14,
                      color: Color(0xFFD4AF37),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
