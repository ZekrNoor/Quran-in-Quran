import 'package:flutter/cupertino.dart';
import '../../data/repositories/quran_repository.dart';
import '../../reader/chapter.dart';
import '../../reader/route.dart';
import '../../reader/verse_reader_screen.dart';
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
  int _activeTab = 0; // 0: سوره, 1: جزء, 2: حزب
  final QuranRepository _quranRepo = QuranRepository();

  late List<Chapter> _filteredChapters;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _filteredChapters = widget.chaptersData.chapters;
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        _filteredChapters = widget.chaptersData.chapters;
      } else {
        final q = query.trim().toLowerCase();
        _filteredChapters = widget.chaptersData.chapters.where((c) {
          return c.transliteratedName.toLowerCase().contains(q) ||
              c.englishName.toLowerCase().contains(q) ||
              c.easyTransliteratedName.toLowerCase().contains(q) ||
              c.number.toString() == q;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Selector (سوره / جزء / حزب)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SizedBox(
            width: double.infinity,
            child: CupertinoSlidingSegmentedControl<int>(
              groupValue: _activeTab,
              backgroundColor: CupertinoColors.tertiarySystemFill,
              thumbColor: const Color(0xFFD4AF37),
              children: {
                0: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'سوره',
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 14,
                      fontWeight: _activeTab == 0 ? FontWeight.bold : FontWeight.normal,
                      color: _activeTab == 0 ? CupertinoColors.black : CupertinoColors.label,
                    ),
                  ),
                ),
                1: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'جزء',
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 14,
                      fontWeight: _activeTab == 1 ? FontWeight.bold : FontWeight.normal,
                      color: _activeTab == 1 ? CupertinoColors.black : CupertinoColors.label,
                    ),
                  ),
                ),
                2: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'حزب',
                    style: TextStyle(
                      fontFamily: 'Estedad',
                      fontSize: 14,
                      fontWeight: _activeTab == 2 ? FontWeight.bold : FontWeight.normal,
                      color: _activeTab == 2 ? CupertinoColors.black : CupertinoColors.label,
                    ),
                  ),
                ),
              },
              onValueChanged: (val) {
                if (val != null) setState(() => _activeTab = val);
              },
            ),
          ),
        ),

        // Search bar (Only for Surahs)
        if (_activeTab == 0)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: SearchBox(
              textController: _searchTextController,
              onChanged: _onSearchChanged,
            ),
          ),

        // Content
        Expanded(
          child: _buildTabBody(context),
        ),
      ],
    );
  }

  Widget _buildTabBody(BuildContext context) {
    if (_activeTab == 0) {
      return ListView.builder(
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: _filteredChapters.length,
        itemBuilder: (context, index) {
          final chapter = _filteredChapters[index];
          return GestureDetector(
            onLongPress: () {
              // Open verse by verse reader on long press
              Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (_) => VerseReaderScreen(chapter: chapter),
                ),
              );
            },
            child: Surah(chapter: chapter),
          );
        },
      );
    } else if (_activeTab == 1) {
      final juzList = _quranRepo.getJuzList();
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: juzList.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final juz = juzList[index];
          return Container(
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: CupertinoListTile(
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${juz.number}',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontFamily: 'Estedad',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                juz.title,
                style: const TextStyle(
                  fontFamily: 'Estedad',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                'شروع از سوره ${juz.startSurahName} (صفحه ${juz.startPage})',
                style: TextStyle(
                  fontFamily: 'Estedad',
                  fontSize: 12,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_back,
                size: 16,
                color: CupertinoColors.secondaryLabel,
              ),
              onTap: () {
                Navigator.of(context).push(
                  createRouteQiQReader(page: juz.startPage),
                );
              },
            ),
          );
        },
      );
    } else {
      final hizbList = _quranRepo.getHizbList();
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: hizbList.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final hizb = hizbList[index];
          return Container(
            decoration: BoxDecoration(
              color: CupertinoColors.secondarySystemBackground,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD4AF37).withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: CupertinoListTile(
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
                ),
                alignment: Alignment.center,
                child: Text(
                  '${hizb.number}',
                  style: const TextStyle(
                    color: Color(0xFFD4AF37),
                    fontFamily: 'Estedad',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                hizb.title,
                style: const TextStyle(
                  fontFamily: 'Estedad',
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              subtitle: Text(
                'صفحه ${hizb.startPage}',
                style: TextStyle(
                  fontFamily: 'Estedad',
                  fontSize: 12,
                  color: CupertinoColors.secondaryLabel.resolveFrom(context),
                ),
              ),
              trailing: const Icon(
                CupertinoIcons.chevron_back,
                size: 16,
                color: CupertinoColors.secondaryLabel,
              ),
              onTap: () {
                Navigator.of(context).push(
                  createRouteQiQReader(page: hizb.startPage),
                );
              },
            ),
          );
        },
      );
    }
  }
}
