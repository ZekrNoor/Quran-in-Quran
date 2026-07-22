import 'package:flutter/material.dart';
import 'chapter.dart';
import 'reader.dart';

Route<void> createRouteQiQReader({
  Chapter? chapter,
  bool slideFromRight = true,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        QiQReader(chapter: chapter),

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
