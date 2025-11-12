import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';
import 'package:quran_in_quran/local_strings.dart';

/* range of glyphs (1 <= `from`/`to`) to be rendered for a single page of the quran */
String glyphRange(int from, int to) {
  return String.fromCharCodes(
    // List.generate(to - from + 1, (index) => 0xfb50 + from + index),
    List.generate(to - from + 1, (index) => 0xfc40 + from + index),
  );
}

Route<void> createRouteQiQReader() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const QiQReader(),

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

class QiQReaderContainer extends StatelessWidget {
  const QiQReaderContainer({
    super.key,
    this.child,
    this.height = 50,
    this.width = 412,
  });

  final double height;
  final double width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LocalColors.quranAppWidgetBg,

        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
        border: Border.all(color: LocalColors.quranAppBorder, width: 1.0),

        shape: BoxShape.rectangle,
      ),

      child: SizedBox(height: height, width: width, child: child),
    );
  }
}

class QiQReader extends StatefulWidget {
  const QiQReader({super.key});

  @override
  State<QiQReader> createState() => _QiQReaderState();
}

class _QiQReaderState extends State<QiQReader> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColors.quranAppReaderBg,

      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 8.0,
                horizontal: 14.0,
              ),

              child: QiQReaderContainer(
                child: Row(
                  children: [
                    SizedBox(width: 12.0),

                    Icon(
                      PhosphorIconsRegular.bookmarks,

                      size: 32.0,
                      color: Color.fromRGBO(0xfc, 0xc8, 0x00, 1.0),
                    ),

                    SizedBox(width: 4.0),

                    Text(
                      LocalStrings.bookmark,

                      style: TextStyle(
                        fontFamily: 'Sindhi',
                        fontSize: 20.0,
                        color: LocalColors.quranAppText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    Spacer(),

                    Text(
                      '۱۹ . مریم',

                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        fontFamily: 'Sindhi',
                        fontSize: 20.0,
                        color: LocalColors.quranAppText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(width: 12.0),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Text(
                glyphRange(1, 80),

                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,

                style: TextStyle(
                  color: LocalColors.quranAppText,

                  fontFamily: 'P283',
                  fontSize: 30,

                  height: 1.6,
                  letterSpacing: 7.0,
                ),
              ),
            ),

            const Spacer(),

            QiQReaderContainer(
              height: 56,
              width: 392,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 2.0),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.listBullets,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.binoculars,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.globe,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.textT,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.house,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.play,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.sliders,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  CircleAvatar(
                    backgroundColor: LocalColors.quranAppAvatarBg,

                    radius: LocalConsts.readerAvatarRadius,

                    child: Icon(
                      PhosphorIconsRegular.magnifyingGlassPlus,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),

                  SizedBox(width: 2.0),
                ],
              ),
            ),

            SizedBox(height: 10.0),

            CupertinoButton.filled(
              onPressed: () {
                Navigator.of(context).pop();
              },

              child: Text('return'),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
