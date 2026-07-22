import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quran_in_quran/reader/chapter.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/local/paths.dart';
import 'package:quran_in_quran/main.dart';
import 'package:quran_in_quran/home/surah_menu/name.dart';
import 'word.dart';

class QPage extends StatefulWidget {
  const QPage({super.key, this.chapter, this.number = 1, this.onSelectAyah});

  final Chapter? chapter;
  final int number;
  final void Function(List<Word> ayah)? onSelectAyah;

  @override
  State<QPage> createState() => _QPageState();
}

class _QPageState extends State<QPage> {
  late List<List<Widget>> _lines;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

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

  Future<void> _loadPage(int pageNumber, {Chapter? chapter}) async {
    final pageFont = 'P${pageNumber.toString()}';

    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final pageFile = File(
      '$docDirPath/${LocalPaths.quranDir}/${pageNumber.toString()}.json',
    );

    if (await pageFile.exists()) {
      final Map<String, dynamic> page = jsonDecode(
        await pageFile.readAsString(),
      );

      lineLoop:
      for (int l = 1, v = 0, w = 0; ; l++) {
        verseLoop:
        for (; ; v++) {
          if (page["verses"].length == v) {
            break lineLoop;
          }

          wordLoop:
          for (; ; w++) {
            if (page["verses"][v]["words"].length == w) {
              w = 0;

              break wordLoop;
            }

            final word = page["verses"][v]["words"][w];

            if (word["line_number"] == (l + 1)) {
              break verseLoop;
            }

            final verse = v;
            void select() {
              List<Word> ayah = List.empty(growable: true);

              for (int i = 0; i < page["verses"][verse]["words"].length; i++) {
                final wordFromAyah = page["verses"][verse]["words"][i];
                ayah.add(
                  Word(
                    code: wordFromAyah["code_v2"],
                    pageFont: pageFont,
                    verseId: wordFromAyah["verse_id"],
                    verseKey: wordFromAyah["verse_key"],
                  ),
                );
              }

              (widget.onSelectAyah ?? (_) {})(ayah);
            }

            _addWord(
              word["line_number"],

              Word(
                code: word["code_v2"],
                pageFont: pageFont,
                verseId: word["verse_id"],
                verseKey: word["verse_key"],

                onSelect: select,
              ),
            );

            if (w == 0 && page["verses"][v]["verse_number"] == 1) {
              if (chapter != null
                  ? page["verses"][v]["chapter_id"] != (chapter.number)
                  : true) {
                _addWord(
                  page["verses"][v]["words"][0]["line_number"] - 1,

                  Padding(
                    padding: EdgeInsets.only(bottom: 40.0),

                    child: SurahName(
                      chapter: QiQApp
                          .resMan
                          .chaptersData
                          .chapters[page["verses"][v]["chapter_id"] - 1],
                    ),
                  ),
                );
              }
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

        Padding(
          padding: EdgeInsets.only(bottom: 40.0),

          child: Hero(
            tag: widget.chapter!.number,

            child: SurahName(chapter: widget.chapter!),
          ),
        ),
      );
    }

    _loadPage(
      widget.chapter != null ? widget.chapter!.page : widget.number,

      chapter: widget.chapter,
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
