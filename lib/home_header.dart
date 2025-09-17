import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'events_near_you.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.profileCallback, this.sideBarMenuCallback});

  final void Function()? profileCallback;
  final void Function()? sideBarMenuCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: profileCallback,
          icon: Icon(
            Icons.account_circle_outlined,
            color: CupertinoColors.black,
            size: 32,
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
          child: EventsNearYou(),
        ),
        const Spacer(),
        IconButton(
          onPressed: sideBarMenuCallback,
          icon: Icon(Icons.menu, color: CupertinoColors.black, size: 32),
        ),
        // IconButton(onPressed: onPressed, icon: icon)
      ],
    );
  }
}
