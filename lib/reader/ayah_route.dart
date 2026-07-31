import 'package:flutter/material.dart';
import 'package:quran_in_quran/reader/ayah_reader.dart';
import 'package:quran_in_quran/reader/chapter.dart';

Route<void> createRouteQiQAyahReader({
  required Chapter chapter,
  int? initialVerse,
  bool slideFromRight = true,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => QiQAyahReader(
      chapter: chapter,
      initialVerse: initialVerse,
    ),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: Offset(slideFromRight ? 1.0 : -1.0, 0.0),
        end: Offset.zero,
      );
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
  );
}
