import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

import 'home_main_layout.dart';
import 'profile_overview.dart';

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

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: QiQHome(),
    );
  }
}

class QiQHome extends StatefulWidget {
  const QiQHome({super.key});

  @override
  State<QiQHome> createState() => _QiQHomeState();
}

class _QiQHomeState extends State<QiQHome> {
  bool _isProfileOverviewInFocus = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: _isProfileOverviewInFocus,
          child: HomeMainLayout(
            onProfileSelected: () {
              setState(() {
                _isProfileOverviewInFocus = true;
              });
            },
          ),
        ),
        IgnorePointer(
          ignoring: !_isProfileOverviewInFocus,
          child: ProfileOverview(
            isInFocus: _isProfileOverviewInFocus,
            onReturn: () {
              setState(() {
                _isProfileOverviewInFocus = false;
              });
            },
          ),
        ),
        // TODO: implement menu animation & functionality
      ],
    );
  }
}
