import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'nav_bar/nav_bar.dart';
import 'resource_manager.dart';
import 'client/zekrnoor_client.dart';
import 'home/home.dart';

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
  static ResourceManager resMan = ResourceManager();

  @override
  Widget build(BuildContext context) {
    client.login();

    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Stack(
        alignment: AlignmentGeometry.center,

        children: [
          FutureBuilder(
            future: resMan.load(),

            builder: (context, snapshot) {
              if (snapshot.data ?? false) {
                return QiQHome();
              } else {
                return SizedBox();
              }
            },
          ),

          Positioned(bottom: 10, child: NavBar()),
        ],
      ),
    );
  }
}
