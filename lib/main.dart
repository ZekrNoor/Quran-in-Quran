import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';
import 'nav_bar/nav_bar.dart';
import 'resource_manager.dart';
import 'client/zekrnoor_client.dart';
import 'home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();
    if (Platform.isWindows) {
      WindowManager.instance.setSize(Size(440, 956));
      WindowManager.instance.setMinimumSize(const Size(440, 956));
      WindowManager.instance.setMaximumSize(const Size(440, 956));
      WindowManager.instance.setResizable(false);
    }
  }

  runApp(const QiQApp());
}

class QiQApp extends StatefulWidget {
  const QiQApp({super.key});

  static ZekrnoorClient client = ZekrnoorClient();
  static ResourceManager resMan = ResourceManager();

  @override
  State<QiQApp> createState() => _QiQAppState();
}

class _QiQAppState extends State<QiQApp> {
  @override
  void initState() {
    super.initState();
    QiQApp.client.login();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: Column(
        children: [
          Expanded(
            child: FutureBuilder<bool>(
              future: QiQApp.resMan.load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CupertinoActivityIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error loading resources: ${snapshot.error}'),
                  );
                } else if (snapshot.data ?? false) {
                  return QiQHome();
                } else {
                  return Center(child: Text('Failed to load resources'));
                }
              },
            ),
          ),
          NavBar(),
        ],
      ),
    );
  }
}
