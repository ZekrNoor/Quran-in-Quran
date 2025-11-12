import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';

import 'package:window_manager/window_manager.dart';

import 'package:quran_in_quran/nav_bar.dart';
import 'home.dart';
import 'zekrnoor_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setSize(Size(440, 956));
    WindowManager.instance.setMinimumSize(const Size(440, 956));
    WindowManager.instance.setMaximumSize(const Size(440, 956));
    WindowManager.instance.setResizable(false);
  }

  runApp(const QiQApp());
}

class QiQApp extends StatelessWidget {
  const QiQApp({super.key});

  static ZekrnoorClient client = ZekrnoorClient();

  @override
  Widget build(BuildContext context) {
    client.login();

    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Stack(
        alignment: AlignmentGeometry.center,

        children: [
          QiQHome(),
          Positioned(bottom: 10, child: NavBar()),
        ],
      ),
    );
  }
}
