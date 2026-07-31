import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/strings.dart';
import 'package:quran_in_quran/reader/ayah.dart';
import 'package:quran_in_quran/reader/ayah_card.dart';
import 'package:quran_in_quran/reader/ayah_loader.dart';
import 'package:quran_in_quran/reader/chapter.dart';
import 'package:quran_in_quran/reader/route.dart';
import 'package:quran_in_quran/reader/translation_loader.dart';
import 'package:quran_in_quran/ui/gold.dart';

class QiQAyahReader extends StatefulWidget {
  const QiQAyahReader({
    super.key,
    required this.chapter,
    this.initialVerse,
  });

  final Chapter chapter;
  final int? initialVerse;

  @override
  State<QiQAyahReader> createState() => _QiQAyahReaderState();
}

class _QiQAyahReaderState extends State<QiQAyahReader> {
  List<Ayah>? _ayahs;
  Map<String, String> _translations = {};
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _itemKeys = [];

  @override
  void initState() {
    super.initState();
    _loadAyahs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadAyahs() async {
    final ayahs = await AyahLoader.loadChapter(widget.chapter.number);
    final translations = await TranslationLoader.loadAll();

    if (!mounted) {
      return;
    }

    setState(() {
      _ayahs = ayahs;
      _translations = translations;
      _itemKeys.clear();
      _itemKeys.addAll(List.generate(ayahs.length, (_) => GlobalKey()));
    });

    if (widget.initialVerse != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToVerse(widget.initialVerse!);
      });
    }
  }

  void _scrollToVerse(int verseNumber) {
    if (_ayahs == null) {
      return;
    }

    final index = _ayahs!.indexWhere((a) => a.verseNumber == verseNumber);
    if (index < 0 || index >= _itemKeys.length) {
      return;
    }

    final context = _itemKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Durations.medium1,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColors.quranAppReaderBg,
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 48),

              Expanded(
                child: _buildBody(),
              ),

              const SizedBox(height: 100),
            ],
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: AyahGoldBar(
                onListBullets: () {
                  Navigator.of(context).pushReplacement(
                    createRouteQiQReader(
                      chapter: widget.chapter,
                      slideFromRight: false,
                    ),
                  );
                },
                onHome: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_ayahs == null) {
      return const Center(
        child: CircularProgressIndicator(
          color: LocalColors.navBarButtonIcon,
        ),
      );
    }

    if (_ayahs!.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            LocalStrings.ayahAyahNoData,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Estedad',
              fontSize: 16,
              color: LocalColors.ayahCardTranslationText,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: _ayahs!.length,
      itemBuilder: (context, index) {
        final ayah = _ayahs![index];

        return KeyedSubtree(
          key: _itemKeys[index],
          child: AyahCard(
            ayah: ayah,
            translation: _translations[ayah.verseKey],
          ),
        );
      },
    );
  }
}

class AyahGoldBar extends StatelessWidget {
  const AyahGoldBar({
    super.key,
    this.onListBullets,
    this.onHome,
  });

  final VoidCallback? onListBullets;
  final VoidCallback? onHome;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GoldButton(
              onPressed: onListBullets,
              icon: PhosphorIconsRegular.listBullets,
            ),

            const SizedBox(width: 4),

            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.binoculars,
            ),

            const SizedBox(width: 4),

            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.globe,
            ),

            const SizedBox(width: 4),

            GoldButton(
              onPressed: onHome ?? () {
                Navigator.of(context).pop();
              },
              icon: PhosphorIconsRegular.house,
            ),

            const SizedBox(width: 4),

            GoldButton(
              onPressed: () {},
              icon: PhosphorIconsRegular.sliders,
            ),
          ],
        ),
      ),
    );
  }
}
