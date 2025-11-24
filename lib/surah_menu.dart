import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';

const Map<int, String> surahMap = {
  1: '1',
  2: '2',
  3: '3',
  4: '4',
  5: '5',
  6: '6',
  7: '7',
  8: '8',
  9: '9',
  10: 'a',
  11: 'b',
  12: 'c',
  13: 'd',
  14: 'e',
  15: 'f',
  16: 'g',
  17: 'h',
  18: 'i',
  19: 'j',
  20: 'k',
  21: 'l',
  22: 'm',
  23: 'n',
  24: 'o',
  25: 'p',
  26: 'q',
  27: 'r',
  28: 's',
  29: 't',
  30: 'u',
  31: 'v',
  32: 'w',
  33: 'x',
  34: 'A',
  35: 'B',
  36: 'C',
  37: 'D',
  38: 'E',
  39: 'F',
  40: 'G',
  41: 'H',
  42: 'I',
  43: 'J',
  44: 'K',
  45: 'L',
  46: 'M',
  47: 'N',
  48: 'O',
  49: 'P',
  50: 'Q',
  51: 'R',
  52: 'S',
  53: 'T',
  54: 'U',
  55: 'V',
  56: 'W',
  57: 'X',
  58: 'Y',
  59: 'Z',
  60: 'a',
  61: 'b',
  62: 'c',
  63: 'd',
  64: 'e',
  65: 'f',
  66: 'g',
  67: 'h',
  68: 'i',
  69: 'j',
  70: 'k',
  71: 'l',
  72: 'm',
  73: 'n',
  74: 'o',
  75: 'p',
  76: 'q',
  77: 'r',
  78: 's',
  79: 't',
  80: 'u',
  81: 'v',
  82: 'w',
  83: 'x',
  84: 'y',
  85: 'z',
  86: 'G',
  87: 'H',
  88: 'I',
  89: 'J',
  90: 'K',
  91: 'L',
  92: 'M',
  93: 'N',
  94: 'O',
  95: 'P',
  96: 'Q',
  97: 'R',
  98: 'S',
  99: 'T',
  100: 'U',
  101: 'V',
  102: 'W',
  103: 'X',
  104: 'Y',
  105: 'Z',
  106: '1',
  107: '2',
  108: '3',
  109: '4',
  110: '5',
  111: '6',
  112: '7',
  113: '8',
  114: '9',
};

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

class SurahContainer extends StatelessWidget {
  const SurahContainer({super.key, this.children = const <Widget>[]});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LocalColors.surahMenuSurahContainerBg,

        border: Border.all(
          color: LocalColors.surahMenuSurahContainerBorder,
          width: LocalConsts.surahMenuSurahContainerBorderWidth,
        ),

        borderRadius: BorderRadius.circular(
          LocalConsts.surahMenuSurahContainerRadius,
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.all(
          LocalConsts.surahMenuSurahContainerPadding,
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,

          children: children,
        ),
      ),
    );
  }
}

class SurahIcon extends StatelessWidget {
  const SurahIcon({super.key, this.isMeccan = false});

  final bool isMeccan;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          LocalConsts.surahMenuSurahIconRadius,
        ),

        image: DecorationImage(
          image: isMeccan
              ? AssetImage('assets/images/meccan.png')
              : AssetImage('assets/images/medinan.png'),
        ),

        shape: BoxShape.rectangle,

        gradient: LinearGradient(
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter,

          colors: [
            LocalColors.surahMenuSurahIconGradientStart,
            LocalColors.surahMenuSurahIconGradientEnd,
          ],
        ),
      ),

      child: SizedBox(
        width: LocalConsts.surahMenuSurahIconSize,
        height: LocalConsts.surahMenuSurahIconSize,
      ),
    );
  }
}

class SurahName extends StatelessWidget {
  const SurahName({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    final String fontFamily;
    if (surahNumber > 59) {
      fontFamily = 'QuranSurah2';
    } else {
      fontFamily = 'QuranSurah1';
    }

    return SizedBox(
      height: LocalConsts.surahMenuSurahIconSize,
      width: 100,

      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.fitWidth,

        child: Text(
          surahMap[surahNumber] ?? '',

          style: TextStyle(
            color: LocalColors.surahMenuSurahName,

            height: 0.0,

            fontFamily: fontFamily,
            fontSize: 82,
          ),
        ),
      ),
    );
  }
}

class Surah extends StatelessWidget {
  const Surah({super.key, required this.surahNumber});

  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(createRouteQiQSurah(surahNumber));
        },

        child: SurahContainer(
          children: [
            Row(
              textDirection: TextDirection.rtl,

              children: [
                SurahIcon(isMeccan: true),

                SizedBox(width: 20),

                Hero(
                  tag: surahNumber,

                  child: SurahName(surahNumber: surahNumber),
                ),
              ],
            ),

            Icon(
              PhosphorIconsRegular.caretLeft,

              color: LocalColors.surahMenuSurahName,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}

Route<void> createRouteQiQSurah(int surahNumber) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        QiQSurah(surahNumber: surahNumber),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(begin: Offset(-1.0, 0.0), end: Offset.zero);
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

class QiQSurah extends StatelessWidget {
  const QiQSurah({super.key, this.surahNumber});

  final int? surahNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),

            child: Column(
              children: [
                SizedBox(height: 40),

                Hero(
                  tag: surahNumber!,

                  child: SurahName(surahNumber: surahNumber!),
                ),

                const Spacer(),

                CupertinoButton.filled(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                  child: Text('return'),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QiQSurahMenu extends StatelessWidget {
  const QiQSurahMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColors.surahMenuBg,

      body: SafeArea(
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(
                context,
              ).copyWith(scrollbars: false),

              child: ListView(
                physics: ClampingScrollPhysics(),

                children: [
                  for (int i = 1; i <= 114; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 4,
                      ),

                      child: Surah(surahNumber: i),
                    ),

                  SizedBox(height: 400),
                ],
              ),
            ),

            Column(
              children: [
                const Spacer(),

                Row(
                  children: [
                    const Spacer(),

                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: LocalColors.surahMenuSurahContainerBorder,

                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(45),

                        color: LocalColors.quranAppWidgetBg,
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(6),

                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },

                              padding: EdgeInsets.zero,

                              icon: Ink(
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,

                                    colors: [
                                      LocalColors.surahMenuNavGradientStart,
                                      LocalColors.surahMenuNavGradientEnd,
                                    ],
                                  ),

                                  shape: CircleBorder(),
                                ),

                                padding: EdgeInsets.all(7),

                                child: Icon(
                                  PhosphorIconsRegular.arrowBendUpLeft,

                                  color: LocalColors.quranAppText,
                                ),
                              ),
                              iconSize: 30,
                            ),

                            SizedBox(width: 7),

                            IconButton(
                              onPressed: () {},

                              padding: EdgeInsets.zero,

                              icon: Ink(
                                decoration: const ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,

                                    colors: [
                                      LocalColors.surahMenuNavGradientStart,
                                      LocalColors.surahMenuNavGradientEnd,
                                    ],
                                  ),

                                  shape: CircleBorder(),
                                ),

                                padding: EdgeInsets.all(7),

                                child: Icon(
                                  PhosphorIconsRegular.house,

                                  color: LocalColors.quranAppText,
                                ),
                              ),
                              iconSize: 30,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),
                  ],
                ),

                SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
