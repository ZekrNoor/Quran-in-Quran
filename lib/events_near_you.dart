import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'local_strings.dart';

class EventsNearYou extends StatelessWidget {
  const EventsNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        color: CupertinoColors.systemYellow,
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: [
            Text(
              LocalStrings.events,
              style: TextStyle(
                fontFamily: 'Estedad',
                fontSize: 12.0,
                fontVariations: [
                  FontVariation('wght', 600.0),
                  FontVariation('KSHD', 100.0),
                ],
              ),
            ),
            Icon(Icons.place_outlined, color: CupertinoColors.black),
          ],
        ),
      ),
    );
  }
}
