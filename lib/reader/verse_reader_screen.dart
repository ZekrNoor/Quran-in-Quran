import 'package:flutter/cupertino.dart';
import '../data/models/ayah.dart';
import '../data/repositories/quran_repository.dart';
import '../reader/chapter.dart';
import 'verse_card.dart';

class VerseReaderScreen extends StatefulWidget {
  final Chapter chapter;
  final int initialVerse;

  const VerseReaderScreen({
    super.key,
    required this.chapter,
    this.initialVerse = 1,
  });

  @override
  State<VerseReaderScreen> createState() => _VerseReaderScreenState();
}

class _VerseReaderScreenState extends State<VerseReaderScreen> {
  final QuranRepository _quranRepo = QuranRepository();
  late List<Ayah> _verses;

  @override
  void initState() {
    super.initState();
    _verses = _quranRepo.getVersesForSurah(widget.chapter.number);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'سوره ${widget.chapter.transliteratedName} (${widget.chapter.numberOfVerses} آیه)',
          style: const TextStyle(
            fontFamily: 'Estedad',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.chapter.isMeccan ? 'مکی' : 'مدنی',
            style: const TextStyle(
              fontFamily: 'Estedad',
              fontSize: 11,
              color: Color(0xFFD4AF37),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      child: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: _verses.length,
          itemBuilder: (context, index) {
            final ayah = _verses[index];
            return VerseCard(ayah: ayah);
          },
        ),
      ),
    );
  }
}
