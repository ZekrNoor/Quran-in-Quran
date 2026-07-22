import 'package:flutter/cupertino.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/local/strings.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.textController,
    required this.onChanged,
  });

  final TextEditingController textController;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      decoration: BoxDecoration(
        color: LocalColors.surahMenuSurahContainerBg,

        border: Border.all(
          color: LocalColors.surahMenuSurahContainerBorder,
          width: LocalConsts.surahMenuSurahContainerBorderWidth,
        ),

        borderRadius: BorderRadius.circular(
          LocalConsts.surahMenuSearchBoxRadius,
        ),
      ),

      controller: textController,

      onChanged: onChanged,

      textAlign: TextAlign.center,

      placeholder: LocalStrings.surahMenuSearchBoxHint,
      placeholderStyle: TextStyle(
        color: LocalColors.surahMenuSearchBoxHint,

        fontFamily: 'Sindhi',
        fontSize: 20,
      ),

      style: TextStyle(
        color: LocalColors.quranAppText,

        fontFamily: 'Sindhi',
        fontSize: 20,
      ),
    );
  }
}
