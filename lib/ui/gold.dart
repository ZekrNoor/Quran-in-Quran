import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
  const GoldBar({super.key, this.spacing = 4});

  final double spacing;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: EdgeInsets.all(6),

        child: Row(
          children: [
            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.listBullets,
            ),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.binoculars),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.globe),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.textT),

            SizedBox(width: spacing),

            GoldButton(
              onPressed: () {
                Navigator.of(context).pop();
              },

              icon: PhosphorIconsRegular.house,
            ),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.play),

            SizedBox(width: spacing),

            GoldButton(onPressed: () {}, icon: PhosphorIconsRegular.sliders),

            SizedBox(width: spacing),

            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.magnifyingGlassPlus,
            ),
          ],
        ),
      ),
    );
  }
}
