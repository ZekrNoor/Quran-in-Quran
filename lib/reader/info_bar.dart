import 'package:flutter/material.dart';
import 'package:quran_in_quran/ui/gold.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/strings.dart';
import 'package:quran_in_quran/util/to_hindi.dart';

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
              Icons.bookmarks,

              size: 32.0,
              color: Color.fromRGBO(0xfc, 0xc8, 0x00, 1.0),
            ),

            SizedBox(width: 4.0),

            Text(
              LocalStrings.bookmark,

              style: TextStyle(
                color: LocalColors.quranAppText,

                fontFamily: 'Sindhi',
                fontSize: 20.0,
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
