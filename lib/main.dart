import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'local_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
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

class EventsNearYou extends StatelessWidget {
  const EventsNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        color: CupertinoColors.systemYellow,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Text(
              LocalStrings.events,
              style: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 12.0,
                fontVariations: [
                  FontVariation('wght', 600.0),
                  FontVariation('KSHD', 100.0),
                ],
              ),
            ),
            Icon(Icons.place_outlined, color: CupertinoColors.black),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          Icons.account_circle_outlined,
          color: CupertinoColors.black,
          size: 32,
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
          child: EventsNearYou(),
        ),
        const Spacer(),
        // TODO: implement menu animation & functionality
        Icon(Icons.menu, color: CupertinoColors.black, size: 32),
        // IconButton(onPressed: onPressed, icon: icon)
      ],
    );
  }
}

class TodaysAyah extends StatelessWidget {
  const TodaysAyah({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // opacity: 0.18,
          // scale: 1.0,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/desert.jpg'),
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              LocalStrings.todaysAyah,
              style: TextStyle(
                color: CupertinoColors.white,
                fontFamily: 'Estedad',
                // fontWeight: FontWeight.w100,
                fontSize: 16,
                fontVariations: [
                  FontVariation('wght', 400.0),
                  FontVariation('KSHD', 180.0),
                ],
              ),
            ),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}

class AlQuranAlKarim extends StatelessWidget {
  const AlQuranAlKarim({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.18,
          scale: 1.0,
          fit: BoxFit.none,
          image: AssetImage('assets/images/al_quran_al_karim.png'),
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(44)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 240, 180),
            blurRadius: 28,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color.fromARGB(16, 0, 0, 0),
            blurRadius: 28,
            spreadRadius: 0,
          ),
        ],
        color: CupertinoColors.white,
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/al_quran_al_karim.png',
                width: 203.0,
                height: 170.52,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 119, 119, 119),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 244, 244, 246),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          LocalStrings.quranMenu,
                          style: TextStyle(
                            color: CupertinoColors.black,
                            fontFamily: 'Estedad',
                            fontSize: 12.0,
                            fontVariations: [
                              FontVariation('wght', 500.0),
                              FontVariation('KSHD', 100.0),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.menu, color: CupertinoColors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 196, 155, 0),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    borderRadius: BorderRadius.circular(100),
                    color: Color.fromARGB(255, 255, 219, 79),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Text(
                          LocalStrings.resumeReading,
                          style: TextStyle(
                            color: CupertinoColors.black,
                            fontFamily: 'Estedad',
                            fontSize: 12.0,
                            fontVariations: [
                              FontVariation('wght', 500.0),
                              FontVariation('KSHD', 100.0),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.play_arrow, color: CupertinoColors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DailyMeditation extends StatelessWidget {
  const DailyMeditation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: CupertinoColors.systemYellow, width: 4),
        ),
      ),
      child: Row(
        children: [
          const Text(
            LocalStrings.dailyMeditation2,
            style: TextStyle(
              fontFamily: 'Estedad',
              fontSize: 24.0,
              fontVariations: [
                FontVariation('wght', 600.0),
                FontVariation('KSHD', 200.0),
              ],
            ),
          ),
          SizedBox(width: 6),
          const Text(
            LocalStrings.dailyMeditation1,
            style: TextStyle(
              fontFamily: 'Estedad',
              fontSize: 24.0,
              fontVariations: [
                FontVariation('wght', 600.0),
                FontVariation('KSHD', 100.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QiQHome extends StatelessWidget {
  const QiQHome({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar.large(
      //   largeTitle: Text(
      //     LocalStrings.welcome,
      //     style: TextStyle(
      //       fontFamily: 'Estedad',
      //       fontSize: 42.0,
      //       fontVariations: [
      //         FontVariation('wght', 800.0),
      //         FontVariation('KSHD', 100.0),
      //       ],
      //     ),
      //   ),
      // ),
      child: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),
                child: HomeHeader(),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: AlQuranAlKarim(),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsetsGeometry.only(right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const Spacer(), DailyMeditation()],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: TodaysAyah(),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
