import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/local/strings.dart';
import 'package:quran_in_quran/main.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    this.isInFocus = false,
    this.onSignIn,
    this.onSignUp,
    this.onReturn,
  });

  final bool isInFocus;
  final Function()? onSignIn;
  final Function()? onSignUp;
  final Function()? onReturn;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class ProfileCardLoggedIn extends StatelessWidget {
  const ProfileCardLoggedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,

          backgroundImage: NetworkImage('https://picsum.photos/200/300'),
        ),

        SizedBox(height: 20),

        Text(
          QiQApp.client.username ?? 'null',

          style: TextStyle(color: LocalColors.quranAppText, fontSize: 24.0),
        ),
      ],
    );
  }
}

class ProfileCardLoggedOut extends StatelessWidget {
  const ProfileCardLoggedOut({super.key, this.onSignIn, this.onSignUp});

  final Function()? onSignIn;
  final Function()? onSignUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: LocalColors.quranAppButtonBorder,

                  width: 1.0,
                ),

                borderRadius: BorderRadius.circular(100),
              ),

              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,

              child: CupertinoButton.filled(
                color: LocalColors.quranAppButtonBg,

                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),

                borderRadius: BorderRadius.circular(100),

                onPressed: onSignIn,

                child: Row(
                  children: [
                    const Text(
                      LocalStrings.signIn,

                      style: TextStyle(
                        color: LocalColors.quranAppText,

                        fontFamily: 'Estedad',
                        fontSize: 12.0,
                        fontVariations: [
                          FontVariation('wght', 500.0),
                          FontVariation('KSHD', 100.0),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),

                    Icon(Icons.menu, color: LocalColors.quranAppText),
                  ],
                ),
              ),
            ),

            SizedBox(width: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: LocalColors.quranAppButtonBorderSecondary,

                  width: 1.0,
                ),

                borderRadius: BorderRadius.circular(100),
              ),

              padding: EdgeInsets.zero,

              margin: EdgeInsets.zero,

              child: CupertinoButton.filled(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),

                borderRadius: BorderRadius.circular(100),

                color: LocalColors.quranAppButtonBgSecondary,

                onPressed: onSignUp,

                child: Row(
                  children: [
                    const Text(
                      LocalStrings.singUp,

                      style: TextStyle(
                        color: LocalColors.quranAppText,

                        fontFamily: 'Estedad',
                        fontSize: 12.0,
                        fontVariations: [
                          FontVariation('wght', 500.0),
                          FontVariation('KSHD', 100.0),
                        ],
                      ),
                    ),

                    SizedBox(width: 10),

                    Icon(Icons.menu, color: LocalColors.quranAppText),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  bool _isLoggedIn = false;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: Durations.medium1);

    _offsetAnimation =
        Tween<Offset>(begin: Offset(0, -1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: LocalConsts.profileCardCurve,
          ),
        )..addListener(() {
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInFocus) {
      _isLoggedIn = QiQApp.client.isLoggedIn;

      _controller.forward();
    } else {
      _controller.reverse();
    }

    return Column(
      children: [
        SlideTransition(
          position: _offsetAnimation,

          child: Card(
            margin: EdgeInsets.zero,

            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.vertical(
                top: Radius.zero,
                bottom: Radius.circular(LocalConsts.profileCardRadius),
              ),
            ),

            child: Padding(
              padding: EdgeInsetsGeometry.only(top: 100, bottom: 60),

              child: Center(
                child: _isLoggedIn
                    ? const ProfileCardLoggedIn()
                    : ProfileCardLoggedOut(
                        onSignIn: widget.onSignIn,
                        onSignUp: widget.onSignUp,
                      ),
              ),
            ),
          ),
        ),

        Expanded(child: GestureDetector(onTap: widget.onReturn)),
      ],
    );
  }
}
