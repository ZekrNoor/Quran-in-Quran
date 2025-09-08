import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double profileOverviewBlur = 6;
final double profileOverviewIconSize = 32;
final double profileOverviewPaddingHorizontal = 12;
final double profileOverviewPaddingVertical = 20;
final Curve profileOverviewAnimationCurve = Curves.easeInOut;

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({super.key, this.isInFocus = false, this.onReturn});

  final bool isInFocus;
  final Function()? onReturn;

  @override
  State<ProfileOverview> createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  late Animation<Offset> _offsetAnimation3;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Durations.medium1);

    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        )..addListener(() {
          setState(() {});
        });

    _offsetAnimation1 =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(0 * pi / 8, 1.2),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        );
    _offsetAnimation2 =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(1.85 * pi / 8, 1.2),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        );
    _offsetAnimation3 =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(4 * pi / 8, 1.2),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInFocus) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Opacity(
      opacity: _opacityAnimation.value,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: profileOverviewBlur,
          sigmaY: profileOverviewBlur,
        ),
        child: Stack(
          children: [
            GestureDetector(onTap: widget.onReturn),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: profileOverviewPaddingHorizontal,
                vertical: profileOverviewPaddingVertical,
              ),
              child: IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: CupertinoColors.systemYellow,
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: CupertinoColors.black,
                  size: profileOverviewIconSize,
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation1,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: profileOverviewPaddingHorizontal,
                  vertical: profileOverviewPaddingVertical,
                ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.notes,
                    color: CupertinoColors.black,
                    size: profileOverviewIconSize,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation2,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: profileOverviewPaddingHorizontal,
                  vertical: profileOverviewPaddingVertical,
                ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark,
                    color: CupertinoColors.black,
                    size: profileOverviewIconSize,
                  ),
                ),
              ),
            ),
            SlideTransition(
              position: _offsetAnimation3,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: profileOverviewPaddingHorizontal,
                  vertical: profileOverviewPaddingVertical,
                ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite,
                    color: CupertinoColors.black,
                    size: profileOverviewIconSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
