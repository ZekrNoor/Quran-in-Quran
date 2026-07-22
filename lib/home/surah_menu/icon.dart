import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';

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
