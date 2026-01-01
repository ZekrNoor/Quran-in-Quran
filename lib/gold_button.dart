import 'package:flutter/material.dart';
import 'package:quran_in_quran/local_colors.dart';

class GoldButton extends StatelessWidget {
  const GoldButton({super.key, required this.onPressed, required this.icon});

  final void Function()? onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,

      padding: EdgeInsets.zero,

      icon: Ink(
        decoration: const ShapeDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,

            colors: [
              LocalColors.goldButtonGradientStart,
              LocalColors.goldButtonGradientEnd,
            ],
          ),

          shape: CircleBorder(),
        ),

        padding: EdgeInsets.all(7),

        child: Icon(icon, color: LocalColors.quranAppText),
      ),

      iconSize: 30,
    );
  }
}
