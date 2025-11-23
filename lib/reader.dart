import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';
import 'package:quran_in_quran/local_paths.dart';
import 'package:quran_in_quran/local_strings.dart';

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

extension IntExtension on int {
  String toHindi() {
    int number = this;
    int numberOfDigits = 0;

    for (int i = 1; ; i++) {
      number ~/= 10;

      if (number == 0) {
        numberOfDigits = i;
        break;
      }
    }

    number = this;

    final chars = List.filled(numberOfDigits, 0);

    for (int i = 0; i < numberOfDigits; i++) {
      chars[numberOfDigits - 1 - i] = 0x06F0 + (number % 10);
      number ~/= 10;
    }

    return String.fromCharCodes(chars);
  }
}

class Word extends StatelessWidget {
  const Word(this.code, this.page, {super.key});

  final String code;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Text(
      code,

      style: TextStyle(
        color: LocalColors.quranAppText,

        fontFamily: 'P${page.toString()}',
        fontSize: 22,

        height: 2.1,
      ),
    );
  }
}

class Line extends StatelessWidget {
  const Line(this.words, {super.key});

  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textDirection: TextDirection.rtl,

      children: words,
    );
  }
}

class Page extends StatelessWidget {
  const Page(this.lines, {super.key});

  final List<Line> lines;

  @override
  Widget build(BuildContext context) {
    return Column(children: lines);
  }
}

class QiQReader extends StatefulWidget {
  const QiQReader({super.key});

  @override
  State<QiQReader> createState() => _QiQReaderState();
}

class _QiQReaderState extends State<QiQReader> {
  int _page = 3;
  int _chapter = 17;
  late Future<Page?> _loadPage;

  Future<Page?> loadPage(int pageNumber) async {
    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final pageFile = File(
      '$docDirPath/${LocalPaths.quranDir}/${pageNumber.toString()}.json',
    );

    if (await pageFile.exists()) {
      final Map<String, dynamic> page = jsonDecode(
        await pageFile.readAsString(),
      );

      final List<Line> lines = List.empty(growable: true);

      lineLoop:
      for (
        int line = page["verses"][0]["words"][0]["line_number"],
            verse = 0,
            word = 0;
        ;
        line++
      ) {
        final List<Word> words = List.empty(growable: true);

        verseLoop:
        for (; ; verse++) {
          if (page["verses"].length == verse) {
            lines.add(Line(words));

            break lineLoop;
          }

          wordLoop:
          for (; ; word++) {
            if (page["verses"][verse]["words"].length == word) {
              word = 0;

              break wordLoop;
            }

            if (page["verses"][verse]["words"][word]["line_number"] ==
                (line + 1)) {
              break verseLoop;
            }

            words.add(
              Word(page["verses"][verse]["words"][word]["code_v2"], pageNumber),
            );
          }
        }

        lines.add(Line(words));
      }

      return Page(lines);
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    _loadPage = loadPage(_page);
  }

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
                      _chapter.toHindi(),

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

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),

              child: FutureBuilder(
                future: _loadPage,

                builder: (BuildContext context, AsyncSnapshot<Page?> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  } else {
                    return SizedBox();
                  }
                },
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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: LocalColors.quranAppAvatarBg,

                  radius: LocalConsts.readerAvatarRadius,

                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _page--;
                        _loadPage = loadPage(_page);
                      });
                    },

                    icon: Icon(
                      PhosphorIconsRegular.arrowLeft,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),
                ),

                CupertinoButton.filled(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },

                  child: Text('return'),
                ),

                CircleAvatar(
                  backgroundColor: LocalColors.quranAppAvatarBg,

                  radius: LocalConsts.readerAvatarRadius,

                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _page++;
                        _loadPage = loadPage(_page);
                      });
                    },

                    icon: Icon(
                      PhosphorIconsRegular.arrowRight,

                      color: LocalColors.quranAppText,
                      size: LocalConsts.readerAvatarSize,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
