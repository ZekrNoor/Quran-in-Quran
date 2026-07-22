import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/reader/chapter.dart';

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
