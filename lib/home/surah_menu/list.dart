import 'package:flutter/material.dart';
import 'package:quran_in_quran/reader/chapter.dart';
import 'surah.dart';
import 'search_box.dart';

class SurahList extends StatefulWidget {
  const SurahList({super.key, required this.chaptersData});

  final ChaptersData chaptersData;

  @override
  State<SurahList> createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {
  late TextEditingController _searchTextController;
  late List<Surah> _surahList;

  void _fillSurahList({Map<int, bool>? filter}) {
    List<Surah> surahList = List.empty(growable: true);

    for (final chapter in widget.chaptersData.chapters) {
      if (!(filter?[chapter.number] ?? true)) {
        continue;
      }

      surahList.add(Surah(chapter: chapter));
    }

    _surahList = surahList;
  }

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();

    _fillSurahList();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: ClampingScrollPhysics(),

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

          child: SearchBox(
            textController: _searchTextController,

            onChanged: (value) {
              if (value == '') {
                setState(() {
                  _fillSurahList();
                });
              } else {
                Map<int, bool> surahFilter = {};

                for (final chapter in widget.chaptersData.chapters) {
                  bool hasMatch =
                      chapter.englishName.contains(value) ||
                      chapter.transliteratedName.contains(value) ||
                      chapter.easyTransliteratedName.contains(value);

                  surahFilter[chapter.number] = hasMatch;
                }

                setState(() {
                  _fillSurahList(filter: surahFilter);
                });
              }
            },
          ),
        ),

        for (final surah in _surahList)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),

            child: surah,
          ),

        SizedBox(height: 400),
      ],
    );
  }
}
