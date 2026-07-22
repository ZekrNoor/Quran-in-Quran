import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';

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
