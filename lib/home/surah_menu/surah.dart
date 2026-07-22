import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/reader/chapter.dart';
import 'package:quran_in_quran/reader/route.dart';
import 'package:quran_in_quran/util/to_hindi.dart';
import 'container.dart';
import 'icon.dart';
import 'name.dart';

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
