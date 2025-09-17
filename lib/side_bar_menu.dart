import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double sideBarMenuBlur = 6;
final Curve sideBarMenuAnimationCurve = Curves.easeInOut;

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({super.key, this.isInFocus = false, this.onReturn});

  final bool isInFocus;
  final Function()? onReturn;

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Durations.medium1);

    _opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _controller,
            curve: sideBarMenuAnimationCurve,
          ),
        )..addListener(() {
          setState(() {});
        });

    _offsetAnimation = Tween<Offset>(begin: Offset(1, 0), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: sideBarMenuAnimationCurve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int _selectedIndex = 0;
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  bool showLeading = false;
  bool showTrailing = false;
  double groupAlignment = -1.0;

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
          sigmaX: sideBarMenuBlur,
          sigmaY: sideBarMenuBlur,
        ),
        child: Row(
          children: [
            Expanded(child: GestureDetector(onTap: widget.onReturn)),
            SlideTransition(
              position: _offsetAnimation,
              child: Localizations(
                locale: Locale('en', 'US'),
                delegates: [
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                child: NavigationRail(
                  selectedIndex: _selectedIndex,
                  groupAlignment: groupAlignment,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: labelType,
                  leading: showLeading
                      ? FloatingActionButton(
                          elevation: 0,
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          child: const Icon(Icons.add),
                        )
                      : const SizedBox(),
                  trailing: showTrailing
                      ? IconButton(
                          onPressed: () {
                            // Add your onPressed code here!
                          },
                          icon: const Icon(Icons.more_horiz_rounded),
                        )
                      : const SizedBox(),
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('First'),
                    ),
                    NavigationRailDestination(
                      icon: Badge(child: Icon(Icons.bookmark_border)),
                      selectedIcon: Badge(child: Icon(Icons.book)),
                      label: Text('Second'),
                    ),
                    NavigationRailDestination(
                      icon: Badge(
                        label: Text('4'),
                        child: Icon(Icons.star_border),
                      ),
                      selectedIcon: Badge(
                        label: Text('4'),
                        child: Icon(Icons.star),
                      ),
                      label: Text('Third'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
