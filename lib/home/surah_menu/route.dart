import 'package:flutter/material.dart';
import 'menu.dart';

Route<void> createRouteQiQSurahMenu() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const QiQSurahMenu(),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
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
