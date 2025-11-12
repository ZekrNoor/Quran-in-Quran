import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quran_in_quran/local_colors.dart';
import 'package:quran_in_quran/local_consts.dart';

class NotchedContainerClipper extends CustomClipper<Path> {
  const NotchedContainerClipper({
    this.depth = 40,
    this.width = 78,
    this.position = 200,
  });

  final double depth;
  final double width;
  final double position;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(position - width / 2 - 20, 0); // Start of notch
    path.cubicTo(
      position - width / 2 + 10,
      0,
      position - depth,
      depth,
      position,
      depth,
    );
    path.cubicTo(
      position + depth,
      depth,
      position + width / 2 - 10,
      0,
      position + width / 2 + 20,
      0,
    );
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _notchPositionAnimation;
  late Animation<Offset> _iconPositionOutAnimation;
  late Animation<Offset> _iconPositionInAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Durations.medium1);

    _notchPositionAnimation =
        Tween<double>(begin: 100.0, end: 300.0).animate(
          CurvedAnimation(parent: _controller, curve: LocalConsts.navBarCurve),
        )..addListener(() {
          setState(() {});
        });

    _iconPositionOutAnimation =
        Tween<Offset>(begin: Offset.zero, end: Offset(-2, 0)).animate(
          CurvedAnimation(parent: _controller, curve: LocalConsts.navBarCurve),
        );
    _iconPositionInAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: LocalConsts.navBarCurve),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.center,

      children: [
        Padding(
          padding: const EdgeInsets.only(top: LocalConsts.navBarButtonSize / 2),

          child: ClipPath(
            clipper: NotchedContainerClipper(
              depth: LocalConsts.navBarNotchDepth,
              width: LocalConsts.navBarNotchWidth,
              position: _notchPositionAnimation.value,
            ),

            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,

              decoration: BoxDecoration(
                color: LocalColors.navBarBg,

                borderRadius: BorderRadius.all(
                  Radius.circular(LocalConsts.navBarBorderRadius),
                ),
                border: Border.all(color: LocalColors.navBarBorder, width: 1.0),

                shape: BoxShape.rectangle,

                // boxShadow: [
                //   BoxShadow(
                //     color: const Color.fromARGB(16, 0, 0, 0),
                //     blurRadius: 28,
                //     spreadRadius: 0,
                //   ),
                // ],
              ),

              child: SizedBox(
                height: LocalConsts.navBarHeight - 2,
                width: LocalConsts.navBarWidth - 2,
              ),
            ),
          ),
        ),

        Positioned(
          left:
              _notchPositionAnimation.value - LocalConsts.navBarButtonSize / 2,
          bottom:
              LocalConsts.navBarHeight - LocalConsts.navBarButtonSize / 2 - 4,

          child: ClipOval(
            child: IconButton(
              padding: EdgeInsets.zero,

              constraints: BoxConstraints.tight(
                Size(
                  LocalConsts.navBarButtonSize,
                  LocalConsts.navBarButtonSize,
                ),
              ),

              style: IconButton.styleFrom(
                backgroundColor: LocalColors.navBarButtonBg,
              ),

              onPressed: () {
                _controller.toggle();
              },

              icon: Stack(
                children: [
                  SlideTransition(
                    position: _iconPositionOutAnimation,

                    child: const Icon(
                      PhosphorIconsRegular.house,

                      color: LocalColors.navBarButtonIcon,
                      size: LocalConsts.navBarIconSize,
                    ),
                  ),
                  SlideTransition(
                    position: _iconPositionInAnimation,

                    child: const Icon(
                      PhosphorIconsRegular.magnifyingGlass,

                      color: LocalColors.navBarButtonIcon,
                      size: LocalConsts.navBarIconSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
