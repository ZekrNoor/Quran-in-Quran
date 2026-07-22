import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';

class Word extends StatelessWidget {
  const Word({
    super.key,
    required this.code,
    required this.pageFont,
    required this.verseId,
    required this.verseKey,
    this.onSelect,
  });

  final String code;
  final String pageFont;
  final int verseId;
  final String verseKey;
  final void Function()? onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,

      child: Text(
        code,

        style: TextStyle(
          color: LocalColors.quranAppText,

          fontFamily: pageFont,
          fontSize: LocalConsts.readerFontSize,

          height: LocalConsts.readerFontSize / LocalConsts.readerLineHeight,
        ),
      ),
    );
  }
}

