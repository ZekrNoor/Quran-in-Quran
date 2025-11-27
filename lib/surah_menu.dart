import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:quran_in_quran/chapter.dart';
import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';
import 'package:quran_in_quran/local_strings.dart';
import 'package:quran_in_quran/main.dart';
import 'package:quran_in_quran/reader.dart';
import 'package:quran_in_quran/to_hindi.dart';

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
  const SurahName({super.key, required this.chapter});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final String fontFamily;
    if (chapter.number > 59) {
      fontFamily = 'QuranSurah2';
    } else {
      fontFamily = 'QuranSurah1';
    }

    return SizedBox(
      height: LocalConsts.surahMenuSurahIconSize,
      width: LocalConsts.surahMenuSurahNameSize,

      child: FittedBox(
        alignment: Alignment.center,
        fit: BoxFit.none,

        child: Text(
          chapter.glyphCode,

          style: TextStyle(
            color: LocalColors.surahMenuSurahName,

            height: 0.0,

            fontFamily: fontFamily,
            fontSize: LocalConsts.surahMenuSurahNameSize,
          ),
        ),
      ),
    );
  }
}

class Surah extends StatelessWidget {
  const Surah({super.key, required this.chapter});

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,

      child: GestureDetector(
        onTap: () {
          Navigator.of(
            context,
          ).push(createRouteQiQReader(chapter: chapter, slideFromRight: false));
        },

        child: SurahContainer(
          children: [
            Row(
              textDirection: TextDirection.rtl,

              children: [
                SurahIcon(isMeccan: chapter.isMeccan),

                SizedBox(width: 20),

                Hero(
                  tag: chapter.number,

                  child: SurahName(chapter: chapter),
                ),
              ],
            ),

            Row(
              textDirection: TextDirection.rtl,

              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: LocalColors.surahMenuNumberOfVerses,

                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.circular(16),
                  ),

                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 17,
                  ),

                  child: Center(
                    child: Text(
                      "${chapter.numberOfVerses.toHindi()} آیه",

                      textDirection: TextDirection.rtl,

                      style: TextStyle(
                        color: LocalColors.surahMenuNumberOfVerses,

                        fontFamily: 'Sindhi',
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10),

                Icon(
                  PhosphorIconsRegular.caretLeft,

                  color: LocalColors.surahMenuSurahName,
                  size: 24,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.textController,
    required this.onChanged,
  });

  final TextEditingController textController;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: LocalColors.surahMenuSurahContainerBg,

        border: Border.all(
          color: LocalColors.surahMenuSurahContainerBorder,
          width: LocalConsts.surahMenuSurahContainerBorderWidth,
        ),

        borderRadius: BorderRadius.circular(
          LocalConsts.surahMenuSearchBoxRadius,
        ),
      ),

      controller: textController,

      onChanged: onChanged,

      textAlign: TextAlign.center,

      placeholder: LocalStrings.surahMenuSearchBoxHint,
      placeholderStyle: TextStyle(
        color: LocalColors.surahMenuSearchBoxHint,

        fontFamily: 'Sindhi',
        fontSize: 20,
      ),

      style: TextStyle(
        color: LocalColors.quranAppText,

        fontFamily: 'Sindhi',
        fontSize: 20,
      ),
    );
  }
}

class SurahList extends StatefulWidget {
  const SurahList({super.key, required this.chaptersData});

  final ChaptersData chaptersData;

  @override
  State<SurahList> createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  late TextEditingController _searchTextController;
  late List<Surah> _surahList;

  void _fillSurahList({Map<int, bool>? filter}) {
    List<Surah> surahList = List.empty(growable: true);

    for (final chapter in widget.chaptersData.chapters) {
      if (!(filter?[chapter.number] ?? true)) {
        continue;
      }

      surahList.add(Surah(chapter: chapter));
    }

    _surahList = surahList;
  }

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();

    _fillSurahList();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

          child: SearchBox(
            textController: _searchTextController,

            onChanged: (value) {
              if (value == '') {
                setState(() {
                  _fillSurahList();
                });
              } else {
                Map<int, bool> surahFilter = {};

                for (final chapter in widget.chaptersData.chapters) {
                  bool hasMatch =
                      chapter.englishName.contains(value) ||
                      chapter.transliteratedName.contains(value) ||
                      chapter.easyTransliteratedName.contains(value);

                  surahFilter[chapter.number] = hasMatch;
                }

                setState(() {
                  _fillSurahList(filter: surahFilter);
                });
              }
            },
          ),
        ),

        for (final surah in _surahList)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),

            child: surah,
          ),

        SizedBox(height: 400),
      ],
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
              behavior: ScrollConfiguration.of(context),

              child: SurahList(chaptersData: QiQApp.resMan.chaptersData),
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
