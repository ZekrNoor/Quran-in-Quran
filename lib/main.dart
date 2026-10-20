import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';
import 'nav_bar/nav_bar.dart';
import 'resource_manager.dart';
import 'client/zekrnoor_client.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    await windowManager.ensureInitialized();
    await windowManager.setSize(const Size(440, 956));
    await windowManager.setMinimumSize(const Size(440, 956));
    await windowManager.setMaximumSize(const Size(440, 956));
    await windowManager.setResizable(false);
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
