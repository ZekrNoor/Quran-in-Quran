import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_in_quran/local_strings.dart';

import 'events_near_you.dart';

const double homeHeaderIconConstraint = 24;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.profileCallback, this.sideBarMenuCallback});

  final void Function()? profileCallback;
  final void Function()? sideBarMenuCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Tooltip(
          message: LocalStrings.profile,
          textStyle: TextStyle(
            color: CupertinoColors.white,
            fontFamily: 'Estedad',
            fontSize: 12.0,
            fontVariations: [
              FontVariation('wght', 500.0),
              FontVariation('KSHD', 100.0),
            ],
          ),
          child: IconButton(
            onPressed: profileCallback,
            constraints: BoxConstraints.tight(
              Size.fromRadius(homeHeaderIconConstraint),
            ),
            icon: Icon(
              Icons.account_circle_outlined,
              color: CupertinoColors.black,
              size: 32,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
          child: EventsNearYou(),
        ),
        const Spacer(),
        IconButton(
          onPressed: sideBarMenuCallback,
          constraints: BoxConstraints.tight(
            Size.fromRadius(homeHeaderIconConstraint),
          ),
          icon: Icon(Icons.menu, color: CupertinoColors.black, size: 32),
        ),
        // IconButton(onPressed: onPressed, icon: icon)
      ],
    );
  }
}
