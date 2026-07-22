import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/main.dart';
import 'list.dart';

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
                                      LocalColors.goldButtonGradientStart,
                                      LocalColors.goldButtonGradientEnd,
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
                                      LocalColors.goldButtonGradientStart,
                                      LocalColors.goldButtonGradientEnd,
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
