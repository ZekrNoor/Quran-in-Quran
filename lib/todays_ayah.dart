import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:quran_in_quran/local_consts.dart';
import 'package:quran_in_quran/local_strings.dart';

/* range of glyphs (1 <= `from`/`to`) to be rendered for a single page of the quran */
String glyphRange(int from, int to) {
  return String.fromCharCodes(
    // List.generate(to - from + 1, (index) => 0xfb50 + from + index),
    List.generate(to - from + 1, (index) => 0xfc40 + from + index),
  );
}

class TodaysAyah extends StatelessWidget {
  const TodaysAyah({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(LocalConsts.todaysAyahRadius),
        ),

        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/desert.jpg'),
        ),

        shape: BoxShape.rectangle,
      ),

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(LocalConsts.todaysAyahRadius),
          ),

          gradient: LinearGradient(
            colors: <Color>[
              Color.fromRGBO(28, 35, 33, 0.1),
              Color.fromRGBO(28, 35, 33, 0.6),
            ],

            stops: [0.0, 1.0],

            transform: GradientRotation(pi / 2),
          ),

          shape: BoxShape.rectangle,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),

              Text(
                LocalStrings.todaysAyah,

                style: TextStyle(
                  color: CupertinoColors.white,

                  fontFamily: 'Estedad',
                  // fontWeight: FontWeight.w100,
                  fontSize: 16,
                  fontVariations: [
                    FontVariation('wght', 400.0),
                    FontVariation('KSHD', 180.0),
                  ],
                ),
              ),

              SizedBox(height: 33),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                child: Text(
                  glyphRange(1, 14),

                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,

                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontFamily: 'P283',
                    fontSize: 30,
                    letterSpacing: 8.0,
                  ),
                ),
              ),

              SizedBox(height: 130),
            ],
          ),
        ),
      ),
    );
  }
}
