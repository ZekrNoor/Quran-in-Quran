import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/chapter.dart';
import 'package:quran_in_quran/gold_button.dart';
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

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: LocalColors.surahMenuSurahContainerBorder,

          width: 1,
        ),
        borderRadius: BorderRadius.circular(45),

        color: LocalColors.quranAppWidgetBg,
      ),

      child: child,
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

class GoldBar extends StatelessWidget {
  const GoldBar({super.key, this.spacing = 4});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: EdgeInsets.all(6),

        child: Row(
          children: [
            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.listBullets,
            ),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.binoculars),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.globe),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.textT),

            SizedBox(width: spacing),

            GoldButton(
              onPressed: () {
                Navigator.of(context).pop();
              },

              icon: PhosphorIconsRegular.house,
            ),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.play),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.sliders),

            SizedBox(width: spacing),

            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.magnifyingGlassPlus,
            ),
          ],
        ),
      ),
    );
  }
}

class InfoBar extends StatelessWidget {
  const InfoBar({super.key, required this.chapter});

  final int chapter;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),

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

            const Spacer(),

            Text(
              chapter.toHindi(),

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
    );
  }
}

class PageNumber extends StatelessWidget {
  const PageNumber(this.pageNumber, {super.key});

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
        ),
        borderRadius: BorderRadius.circular(36),
      ),

      child: SizedBox(
        width: 50,

        child: Text(
          pageNumber.toHindi(),

          textAlign: TextAlign.center,

          style: TextStyle(
            color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),

            fontFamily: 'Sindhi',
            fontSize: 18,

            height: 1.0,
          ),
        ),
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

      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 14.0,
                  ),

                  child: InfoBar(chapter: _chapter),
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

                PageNumber(_pageNumber),

                SizedBox(height: 10),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,

            child: Padding(
              padding: EdgeInsets.only(bottom: 40),

              child: Row(
                children: [const Spacer(), const GoldBar(), const Spacer()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
