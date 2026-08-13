import 'package:flutter/material.dart';
import 'package:quran_in_quran/local/colors.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: LocalColors.surahMenuSurahContainerBorder,

          width: 1,
        ),
        borderRadius: BorderRadius.circular(45),

        color: LocalColors.quranAppWidgetBg,
      ),

      child: child,
    );
  }
}

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

class GoldBar extends StatelessWidget {
  const GoldBar({super.key, this.spacing = 4, this.onListBullets});

  final double spacing;
  final VoidCallback? onListBullets;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: RoundedContainer(
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: spacing,
            runSpacing: 0,
            children: [
              GoldButton(onPressed: onListBullets, icon: Icons.list),
              GoldButton(onPressed: () {}, icon: Icons.visibility),
              GoldButton(onPressed: () {}, icon: Icons.public),
              GoldButton(onPressed: () {}, icon: Icons.text_fields),
              GoldButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icons.home,
              ),
              GoldButton(onPressed: () {}, icon: Icons.play_arrow),
              GoldButton(onPressed: () {}, icon: Icons.tune),
              GoldButton(onPressed: () {}, icon: Icons.zoom_in),
            ],
          ),
        ),
      ),
    );
  }
}
