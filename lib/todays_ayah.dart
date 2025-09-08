import 'package:flutter/cupertino.dart';

import 'local_strings.dart';

class TodaysAyah extends StatelessWidget {
  const TodaysAyah({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          // opacity: 0.18,
          // scale: 1.0,
          fit: BoxFit.cover,
          image: AssetImage('assets/images/desert.jpg'),
        ),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(32)),
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
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}