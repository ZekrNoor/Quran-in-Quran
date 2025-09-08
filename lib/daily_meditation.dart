import 'package:flutter/cupertino.dart';

import 'local_strings.dart';

class DailyMeditation extends StatelessWidget {
  const DailyMeditation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          bottom: BorderSide(color: CupertinoColors.systemYellow, width: 4),
        ),
      ),
      child: Row(
        children: [
          const Text(
            LocalStrings.dailyMeditation2,
            style: TextStyle(
              fontFamily: 'Estedad',
              fontSize: 24.0,
              fontVariations: [
                FontVariation('wght', 600.0),
                FontVariation('KSHD', 200.0),
              ],
            ),
          ),
          SizedBox(width: 6),
          const Text(
            LocalStrings.dailyMeditation1,
            style: TextStyle(
              fontFamily: 'Estedad',
              fontSize: 24.0,
              fontVariations: [
                FontVariation('wght', 600.0),
                FontVariation('KSHD', 100.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}