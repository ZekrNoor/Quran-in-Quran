import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_strings.dart';

class AlQuranAlKarim extends StatelessWidget {
  const AlQuranAlKarim({super.key, this.onResumeReading, this.onSurahMenu});

  final void Function()? onResumeReading;
  final void Function()? onSurahMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.18,
          scale: 1.0,
          fit: BoxFit.none,

          image: AssetImage('assets/images/al_quran_al_karim.png'),
        ),

        shape: BoxShape.rectangle,

        borderRadius: BorderRadius.all(Radius.circular(44)),

        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 255, 240, 180),
            blurRadius: 28,
            spreadRadius: 0,
          ),

          BoxShadow(
            color: const Color.fromARGB(16, 0, 0, 0),
            blurRadius: 28,
            spreadRadius: 0,
          ),
        ],

        color: CupertinoColors.white,
      ),
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(vertical: 20),

              child: Image.asset(
                'assets/images/al_quran_al_karim.png',

                width: 203.0,
                height: 170.52,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 119, 119, 119),

                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),

                    borderRadius: BorderRadius.circular(100),

                    color: Color.fromARGB(255, 244, 244, 246),

                    onPressed: onSurahMenu,

                    child: Row(
                      children: [
                        const Text(
                          LocalStrings.quranMenu,

                          style: TextStyle(
                            color: CupertinoColors.black,

                            fontFamily: 'Estedad',
                            fontSize: 12.0,
                            fontVariations: [
                              FontVariation('wght', 500.0),
                              FontVariation('KSHD', 100.0),
                            ],
                          ),
                        ),

                        SizedBox(width: 10),

                        Icon(Icons.menu, color: CupertinoColors.black),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color.fromARGB(255, 196, 155, 0),

                      width: 1.0,
                    ),

                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: CupertinoButton.filled(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),

                    borderRadius: BorderRadius.circular(100),

                    color: Color.fromARGB(255, 255, 219, 79),

                    onPressed: onResumeReading,

                    child: Row(
                      children: [
                        const Text(
                          LocalStrings.resumeReading,

                          style: TextStyle(
                            color: CupertinoColors.black,

                            fontFamily: 'Estedad',
                            fontSize: 12.0,
                            fontVariations: [
                              FontVariation('wght', 500.0),
                              FontVariation('KSHD', 100.0),
                            ],
                          ),
                        ),

                        SizedBox(width: 10),

                        Icon(Icons.play_arrow, color: CupertinoColors.black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
