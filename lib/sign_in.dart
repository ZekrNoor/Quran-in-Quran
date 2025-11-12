import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route<void> createRouteQiQSignIn() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const QiQSignIn(),
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

class QiQSignIn extends StatelessWidget {
  const QiQSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoButton.filled(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('haha'),
      ),
    );
  }
}
