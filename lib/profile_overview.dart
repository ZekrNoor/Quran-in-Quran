import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double profileOverviewBlur = 6;
const double profileOverviewIconSize = 32;
const double profileOverviewIconConstraint = 24;
const double profileOverviewPaddingHorizontal = 12;
const double profileOverviewPaddingVertical = 20;
const double profileOverviewIconsDistance = 2.0;
const Curve profileOverviewAnimationCurve = Curves.easeInOut;

class ProfileOverview extends StatefulWidget {
  const ProfileOverview({
    super.key,
    this.isInFocus = false,
    this.onProfileSelected,
    this.onNotesSelected,
    this.onBookmarksSelected,
    this.onFavoritesSelected,
    this.onReturn,
  });

  final bool isInFocus;
  final Function()? onProfileSelected;
  final Function()? onFavoritesSelected;
  final Function()? onBookmarksSelected;
  final Function()? onNotesSelected;
  final Function()? onReturn;

  @override
  State<ProfileOverview> createState() => _ProfileOverviewState();
}

class _ProfileOverviewState extends State<ProfileOverview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimationNotes;
  late Animation<Offset> _offsetAnimationBookmarks;
  late Animation<Offset> _offsetAnimationFavorites;

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

    _offsetAnimationNotes =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(0 * pi / 8, profileOverviewIconsDistance),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        );

    _offsetAnimationBookmarks =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(2 * pi / 8, profileOverviewIconsDistance),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: profileOverviewAnimationCurve,
          ),
        );

    _offsetAnimationFavorites =
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset.fromDirection(4 * pi / 8, profileOverviewIconsDistance),
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
                padding: EdgeInsetsGeometry.all(5),
                style: IconButton.styleFrom(
                  backgroundColor: CupertinoColors.systemYellow,
                ),
                onPressed: widget.onProfileSelected,
                constraints: BoxConstraints.tight(
                  Size.fromRadius(profileOverviewIconConstraint),
                ),
                icon: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://picsum.photos/200/300',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: profileOverviewPaddingHorizontal,
                vertical: profileOverviewPaddingVertical,
              ),
              child: SlideTransition(
                position: _offsetAnimationNotes,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: widget.onNotesSelected,
                  constraints: BoxConstraints.tight(
                    Size.fromRadius(profileOverviewIconConstraint),
                  ),
                  icon: Icon(
                    Icons.notes,
                    color: CupertinoColors.black,
                    size: profileOverviewIconSize,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: profileOverviewPaddingHorizontal,
                vertical: profileOverviewPaddingVertical,
              ),
              child: SlideTransition(
                position: _offsetAnimationBookmarks,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: widget.onBookmarksSelected,
                  constraints: BoxConstraints.tight(
                    Size.fromRadius(profileOverviewIconConstraint),
                  ),
                  icon: Icon(
                    Icons.bookmark,
                    color: CupertinoColors.black,
                    size: profileOverviewIconSize,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: profileOverviewPaddingHorizontal,
                vertical: profileOverviewPaddingVertical,
              ),
              child: SlideTransition(
                position: _offsetAnimationFavorites,
                child: IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: CupertinoColors.systemYellow,
                  ),
                  onPressed: widget.onFavoritesSelected,
                  constraints: BoxConstraints.tight(
                    Size.fromRadius(profileOverviewIconConstraint),
                  ),
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
