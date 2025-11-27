import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/chapter.dart';
import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';
import 'package:quran_in_quran/local_paths.dart';
import 'package:quran_in_quran/local_strings.dart';
import 'package:quran_in_quran/main.dart';
import 'package:quran_in_quran/surah_menu.dart';
import 'package:quran_in_quran/to_hindi.dart';

Route<void> createRouteQiQReader({
  Chapter? chapter,
  bool slideFromRight = true,
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        QiQReader(chapter: chapter),

    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: Offset(slideFromRight ? 1.0 : -1.0, 0.0),
        end: Offset.zero,
      );
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
        fontSize: LocalConsts.readerFontSize,

        height: LocalConsts.readerFontSize / LocalConsts.readerLineHeight,
      ),
    );
  }
}

class QiQReader extends StatefulWidget {
  const QiQReader({super.key, this.chapter});

  final Chapter? chapter;

  @override
  State<QiQReader> createState() => _QiQReaderState();
}

class _QiQReaderState extends State<QiQReader> {
  int _pageNumber = 1;
  int _chapter = 1;

  late List<List<Widget>> _lines;

  void _addWord(int line, Widget word) {
    _lines[line - 1].add(word);
  }

  void _clearLines() {
    _lines = List.generate(
      15,

      (index) => List.empty(growable: true),

      growable: false,
    );
  }

  Future<void> _loadPage(int pageNumber) async {
    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final pageFile = File(
      '$docDirPath/${LocalPaths.quranDir}/${pageNumber.toString()}.json',
    );

    if (await pageFile.exists()) {
      final Map<String, dynamic> page = jsonDecode(
        await pageFile.readAsString(),
      );

      lineLoop:
      for (int line = 1, verse = 0, word = 0; ; line++) {
        verseLoop:
        for (; ; verse++) {
          if (page["verses"].length == verse) {
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

            _addWord(
              page["verses"][verse]["words"][word]["line_number"],

              Word(page["verses"][verse]["words"][word]["code_v2"], pageNumber),
            );

            if (word == 0 &&
                page["verses"][verse]["verse_number"] == 1 &&
                page["verses"][verse]["chapter_id"] !=
                    (widget.chapter?.number ?? 0)) {
              _addWord(
                page["verses"][verse]["words"][0]["line_number"] - 1,

                SurahName(
                  chapter: QiQApp
                      .resMan
                      .chaptersData
                      .chapters[page["verses"][verse]["chapter_id"] - 1],
                ),
              );
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();

    _clearLines();

    if (widget.chapter != null) {
      _addWord(
        widget.chapter!.position,

        Hero(
          tag: widget.chapter!.number,

          child: SurahName(chapter: widget.chapter!),
        ),
      );
    }

    _pageNumber = widget.chapter?.page ?? _pageNumber;
    _loadPage(_pageNumber).then((_) {
      setState(() {});
    });
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

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                for (final line in _lines)
                  SizedBox(
                    height: LocalConsts.readerLineHeight,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      textDirection: TextDirection.rtl,

                      children: line,
                    ),
                  ),
              ],
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
                      _pageNumber--;

                      _clearLines();
                      _loadPage(_pageNumber).then((_) {
                        setState(() {});
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
                      _pageNumber++;

                      _clearLines();
                      _loadPage(_pageNumber).then((_) {
                        setState(() {});
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
