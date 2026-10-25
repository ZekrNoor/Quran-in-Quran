import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:provider/provider.dart';
import '../data/repositories/quran_repository.dart';
import '../providers/reflection_provider.dart';
import '../reader/verse_reflection_modal.dart';
import '../local/consts.dart';

class TodaysAyah extends StatelessWidget {
  const TodaysAyah({super.key});

  @override
  Widget build(BuildContext context) {
    final quranRepo = QuranRepository();
    final todaysAyah = quranRepo.getTodaysAyah();
    final provider = context.watch<ReflectionProvider>();
    final isBookmarked = provider.isBookmarked(todaysAyah.verseKey);

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(LocalConsts.todaysAyahRadius),
        ),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/desert.jpg'),
        ),
        shape: BoxShape.rectangle,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(LocalConsts.todaysAyahRadius),
          ),
          gradient: LinearGradient(
            colors: <Color>[
              const Color.fromRGBO(18, 24, 22, 0.45),
              const Color.fromRGBO(10, 15, 13, 0.88),
            ],
            stops: const [0.0, 1.0],
            transform: const GradientRotation(pi / 2),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Tag (آیه امروز + تیک)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.check_mark_circled_solid,
                          color: Color(0xFFD4AF37),
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'آیه امروز (مریم ۲۱)',
                          style: TextStyle(
                            color: Color(0xFFD4AF37),
                            fontFamily: 'Estedad',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => provider.toggleBookmark(todaysAyah.verseKey),
                    child: Icon(
                      isBookmarked ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
                      color: const Color(0xFFD4AF37),
                      size: 20,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Arabic Verse
              Text(
                todaysAyah.text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: CupertinoColors.white,
                  fontFamily: 'Uthmanic',
                  fontSize: 18,
                  height: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 4,
                      color: CupertinoColors.black,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Persian Translation
              Text(
                todaysAyah.translation,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontFamily: 'Estedad',
                  fontSize: 12.5,
                  height: 1.6,
                ),
              ),

              const SizedBox(height: 18),

              // Action Buttons Row (نظرات و تدبر / لایک / اشتراک‌گذاری)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // التدبر و نظرات
                  GestureDetector(
                    onTap: () => VerseReflectionModal.show(context, todaysAyah),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4AF37),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 15,
                            color: CupertinoColors.black,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'تدبّر و نظرات',
                            style: TextStyle(
                              fontFamily: 'Estedad',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: CupertinoColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // لایک
                  Row(
                    children: const [
                      Icon(Icons.favorite_border, size: 16, color: CupertinoColors.white),
                      SizedBox(width: 4),
                      Text(
                        '۴۰۱',
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),

                  // اشتراک
                  const Row(
                    children: [
                      Icon(CupertinoIcons.share, size: 16, color: CupertinoColors.white),
                      SizedBox(width: 4),
                      Text(
                        'اشتراک',
                        style: TextStyle(
                          fontFamily: 'Estedad',
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
