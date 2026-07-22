import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
