import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/local/strings.dart';
import 'package:quran_in_quran/local/surah_arabic_names.dart';
import 'package:quran_in_quran/reader/ayah.dart';
import 'package:quran_in_quran/util/to_hindi.dart';

class AyahCard extends StatefulWidget {
  const AyahCard({
    super.key,
    required this.ayah,
    required this.translation,
  });

  final Ayah ayah;
  final String? translation;

  @override
  State<AyahCard> createState() => _AyahCardState();
}

class _AyahCardState extends State<AyahCard> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final surahName = SurahArabicNames.forChapter(widget.ayah.chapterId);
    final ayahLabel = '$surahName ${widget.ayah.verseNumber.toHindi()}';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LocalColors.ayahCardBg,
        borderRadius: BorderRadius.circular(LocalConsts.ayahCardRadius),
        border: Border.all(
          color: LocalColors.quranAppBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _AyahCardHeader(
            label: ayahLabel,
            isBookmarked: _isBookmarked,
            onBookmark: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
            },
          ),

          const SizedBox(height: 20),

          Wrap(
            direction: Axis.horizontal,
            textDirection: TextDirection.rtl,
            alignment: WrapAlignment.center,
            spacing: 4,
            runSpacing: 8,
            children: [
              for (final word in widget.ayah.words)
                Text(
                  word.code,
                  style: TextStyle(
                    color: LocalColors.quranAppText,
                    fontFamily: word.pageFont,
                    fontSize: LocalConsts.ayahCardArabicFontSize,
                    height: 1.6,
                  ),
                ),
            ],
          ),

          if (widget.translation != null && widget.translation!.isNotEmpty) ...[
            const SizedBox(height: 20),

            Text(
              widget.translation!,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: LocalColors.ayahCardTranslationText,
                fontFamily: 'Estedad',
                fontSize: LocalConsts.ayahCardTranslationFontSize,
                height: 1.8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],

          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: _TadabburButton(onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

class _AyahCardHeader extends StatelessWidget {
  const _AyahCardHeader({
    required this.label,
    required this.isBookmarked,
    required this.onBookmark,
  });

  final String label;
  final bool isBookmarked;
  final VoidCallback onBookmark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: LocalColors.ayahCardHeaderBg,
        borderRadius: BorderRadius.circular(LocalConsts.ayahCardHeaderRadius),
        border: Border.all(
          color: LocalColors.quranAppBorder,
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          _AyahActionButton(
            icon: isBookmarked
                ? PhosphorIconsFill.bookmarkSimple
                : PhosphorIconsRegular.bookmarkSimple,
            iconColor: isBookmarked
                ? LocalColors.navBarButtonIcon
                : LocalColors.quranAppText,
            onPressed: onBookmark,
          ),

          const SizedBox(width: 8),

          _AyahActionButton(
            icon: PhosphorIconsRegular.play,
            onPressed: () {},
          ),

          const SizedBox(width: 8),

          _AyahActionButton(
            icon: PhosphorIconsRegular.shareNetwork,
            onPressed: () {},
          ),

          const Spacer(),

          Text(
            label,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: LocalColors.quranAppText,
              fontFamily: 'Estedad',
              fontSize: LocalConsts.ayahCardHeaderFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AyahActionButton extends StatelessWidget {
  const _AyahActionButton({
    required this.icon,
    required this.onPressed,
    this.iconColor = LocalColors.quranAppText,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: LocalColors.quranAppWidgetBg,
      shape: const CircleBorder(
        side: BorderSide(
          color: LocalColors.quranAppBorder,
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: LocalConsts.ayahCardActionButtonSize,
          height: LocalConsts.ayahCardActionButtonSize,
          child: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class _TadabburButton extends StatelessWidget {
  const _TadabburButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: LocalColors.quranAppButtonBgSecondary,
      borderRadius: BorderRadius.circular(LocalConsts.ayahCardTadabburRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(LocalConsts.ayahCardTadabburRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                PhosphorIconsRegular.caretLeft,
                size: 16,
                color: LocalColors.quranAppText,
              ),

              const SizedBox(width: 6),

              Text(
                LocalStrings.tadabburInAyah,
                style: const TextStyle(
                  color: LocalColors.quranAppText,
                  fontFamily: 'Estedad',
                  fontSize: LocalConsts.ayahCardTadabburFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
