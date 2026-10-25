import '../models/ayah.dart';
import '../models/tafsir.dart';
import '../../reader/chapter.dart';
import '../../main.dart';

class JuzInfo {
  final int number;
  final String title;
  final int startPage;
  final String startSurahName;
  final int startVerse;

  const JuzInfo({
    required this.number,
    required this.title,
    required this.startPage,
    required this.startSurahName,
    required this.startVerse,
  });
}

class HizbInfo {
  final int number;
  final String title;
  final int startPage;
  final String startSurahName;

  const HizbInfo({
    required this.number,
    required this.title,
    required this.startPage,
    required this.startSurahName,
  });
}

class QuranRepository {
  List<Chapter> getChapters() {
    return QiQApp.resMan.chaptersData.chapters;
  }

  Chapter getChapterByNumber(int surahNumber) {
    final list = getChapters();
    return list.firstWhere(
      (c) => c.number == surahNumber,
      orElse: () => list.first,
    );
  }

  // List of 30 Quran Juz
  List<JuzInfo> getJuzList() {
    return List.generate(30, (index) {
      final juzNum = index + 1;
      final startPages = [
        1, 22, 42, 62, 82, 102, 122, 142, 162, 182,
        202, 222, 242, 262, 282, 302, 322, 342, 362, 382,
        402, 422, 442, 462, 482, 502, 522, 542, 562, 582,
      ];
      final surahNames = [
        'الفاتحة', 'البقرة', 'آل عمران', 'النساء', 'النساء', 'المائدة', 'الأنعام', 'الأعراف', 'الأنفال', 'التوبة',
        'هود', 'يوسف', 'الرعد', 'الحجر', 'الإسراء', 'الكهف', 'الأنبیاء', 'المؤمنون', 'الفرقان', 'النمل',
        'العنكبوت', 'الأحزاب', 'یس', 'الزمر', 'فصلت', 'الأحقاف', 'الذاریات', 'المجادلة', 'الملك', 'النبأ',
      ];
      return JuzInfo(
        number: juzNum,
        title: 'جزء $juzNum',
        startPage: startPages[index],
        startSurahName: surahNames[index],
        startVerse: 1,
      );
    });
  }

  // List of 60 Quran Hizbs
  List<HizbInfo> getHizbList() {
    return List.generate(60, (index) {
      final hizbNum = index + 1;
      final page = ((hizbNum - 1) * 10) + 1;
      return HizbInfo(
        number: hizbNum,
        title: 'حزب $hizbNum',
        startPage: page > 604 ? 604 : page,
        startSurahName: 'حزب $hizbNum قرآن کریم',
      );
    });
  }

  // Today's Ayah (featured on home screen)
  Ayah getTodaysAyah() {
    return const Ayah(
      surahNumber: 19,
      verseNumber: 21,
      verseKey: '19:21',
      text: 'قَالَ كَذَٰلِكِ قَالَ رَبُّكِ هُوَ عَلَيَّ هَيِّنٌ ۖ وَلِنَجْعَلَهُ آيَةً لِّلنَّاسِ وَرَحْمَةً مِّنَّا ۚ وَكَانَ أَمْرًا مَّقْضِيًّا',
      translation: 'گفت: «فرمان پروردگار تو همین است که: این کار بر من آسان است و ما می‌خواهیم او را نشانه‌ای برای مردم و رحمتی از سوی خود قرار دهیم؛ و این امری حتمی است.»',
      pageNumber: 306,
      juzNumber: 16,
      hizbNumber: 31,
      audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/019021.mp3',
    );
  }

  // Sample verses for Surah (Verse-by-Verse view)
  List<Ayah> getVersesForSurah(int surahNumber) {
    if (surahNumber == 19) { // Maryam
      return const [
        Ayah(
          surahNumber: 19,
          verseNumber: 21,
          verseKey: '19:21',
          text: 'قَالَ كَذَٰلِكِ قَالَ رَبُّكِ هُوَ عَلَيَّ هَيِّنٌ ۖ وَلِنَجْعَلَهُ آيَةً لِّلنَّاسِ وَرَحْمَةً مِّنَّا ۚ وَكَانَ أَمْرًا مَّقْضِيًّا',
          translation: 'گفت: «فرمان پروردگار تو همین است که: این کار بر من آسان است و ما می‌خواهیم او را نشانه‌ای برای مردم و رحمتی از سوی خود قرار دهیم؛ و این امری حتمی است.»',
          pageNumber: 306,
          juzNumber: 16,
          hizbNumber: 31,
          audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/019021.mp3',
        ),
        Ayah(
          surahNumber: 19,
          verseNumber: 22,
          verseKey: '19:22',
          text: 'فَحَمَلَتْهُ فَانتَبَذَتْ بِهِ مَكَانًا قَصِيًّا',
          translation: 'سرانجام (مریم) به او باردار شد؛ و او را به نقطه دوردستی برد.',
          pageNumber: 306,
          juzNumber: 16,
          hizbNumber: 31,
          audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/019022.mp3',
        ),
        Ayah(
          surahNumber: 19,
          verseNumber: 23,
          verseKey: '19:23',
          text: 'فَأَجَاءَهَا الْمَخَاضُ إِلَىٰ جِذْعِ النَّخْلَةِ قَالَتْ يَا لَيْتَنِي مِتُّ قَبْلَ هَٰذَا وَكُنتُ نَسْيًا مَّنسِيًّا',
          translation: 'درد زایمان او را به کنار تنه درخت خرمایی کشاند؛ گفت: «ای کاش پیش از این مرده بودم و به کلی فراموش می‌شدم!»',
          pageNumber: 306,
          juzNumber: 16,
          hizbNumber: 31,
          audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/019023.mp3',
        ),
      ];
    }

    // Default Al-Fatihah
    return const [
      Ayah(
        surahNumber: 1,
        verseNumber: 1,
        verseKey: '1:1',
        text: 'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
        translation: 'به نام خداوند بخشنده مهربان',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001001.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 2,
        verseKey: '1:2',
        text: 'الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ',
        translation: 'ستایش مخصوص خداوندی است که پروردگار جهانیان است.',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001002.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 3,
        verseKey: '1:3',
        text: 'الرَّحْمَٰنِ الرَّحِيمِ',
        translation: 'بخشنده و مهربان است.',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001003.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 4,
        verseKey: '1:4',
        text: 'مَالِكِ يَوْمِ الدِّينِ',
        translation: 'صاحب روز پاداش و جزا است.',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001004.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 5,
        verseKey: '1:5',
        text: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ',
        translation: 'تنها تو را می‌پرستیم؛ و تنها از تو یاری می‌جوییم.',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001005.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 6,
        verseKey: '1:6',
        text: 'اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ',
        translation: 'ما را به راه راست هدایت کن...',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001006.mp3',
      ),
      Ayah(
        surahNumber: 1,
        verseNumber: 7,
        verseKey: '1:7',
        text: 'صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ',
        translation: 'راه کسانی که آنان را مشمول نعمت خود ساختی؛ نه غضب‌شدگان و نه گمراهان!',
        pageNumber: 1,
        juzNumber: 1,
        hizbNumber: 1,
        audioUrl: 'https://everyayah.com/data/Alafasy_128kbps/001007.mp3',
      ),
    ];
  }

  // Translations list for a verse
  List<VerseTranslation> getTranslationsForVerse(String verseKey) {
    return const [
      VerseTranslation(
        translatorId: 'makarem',
        translatorName: 'آیت‌الله مکارم شیرازی',
        text: 'گفت: «مطلب همین است، پروردگارت فرمود: این کار بر من آسان است و برای این است که او را نشانه‌ای برای مردم قرار دهیم و رحمتی از سوی ما باشد و این امری است حتمی!»',
      ),
      VerseTranslation(
        translatorId: 'fooladvand',
        translatorName: 'استاد فولادوند',
        text: 'گفت: «فرمان چنین است، پروردگارت گفته: آن بر من آسان است، و تا او را نشانه‌ای برای مردم و رحمتی از جانب خویش قرار دهیم، و دستوری قطعی بود.»',
      ),
      VerseTranslation(
        translatorId: 'ansarian',
        translatorName: 'حسین انصاریان',
        text: 'گفت: چنین است، پروردگارت فرموده: این کار بر من آسان است، و برای این است که او را نشانه‌ای برای مردم و رحمتی از سوی خود قرار دهیم.',
      ),
      VerseTranslation(
        translatorId: 'ghomshei',
        translatorName: 'مهدی الهی قمشه‌ای',
        text: 'گفت: چنین خواهد بود، پروردگارت فرمود: این کار بر من سهل و آسان است و تا او را آیت و معجزه‌ای برای خلق قرار دهیم و رحمتی از جانب ما باشد.',
      ),
    ];
  }

  // Tafsirs for a verse
  List<VerseTafsir> getTafsirsForVerse(String verseKey) {
    return const [
      VerseTafsir(
        tafsirId: 'nemouneh',
        tafsirName: 'تفسیر نمونه',
        scholar: 'آیت‌الله مکارم شیرازی',
        content: 'در پاسخ به شگفتی مریم، جبرئیل با قاطعیت اعلام می‌کند که قدرت لایزال الهی فوق همه قوانین مادی است. خلقت بدون پدر، نشانه‌ای از احاطه و ربوبیت حق‌تعالی است و مقصود، تجلی رحمت خداوندی برای انسان‌هاست.',
      ),
      VerseTafsir(
        tafsirId: 'noor',
        tafsirName: 'تفسیر نور',
        scholar: 'حجت‌الاسلام قرائتی',
        content: 'پیام‌های آیه:\n۱. کارهای خارق‌العاده برای خداوند آسان است.\n۲. تولد حضرت عیسی هم معجزه است و هم فیض و رحمت برای بشریت.\n۳. هرگاه اراده الهی به امری تعلق گیرد، تخلف‌ناپذیر است.',
      ),
      VerseTafsir(
        tafsirId: 'almizan',
        tafsirName: 'تفسیر روایی و المیزان',
        scholar: 'علامه طباطبایی',
        content: 'مراد از «وکان امراً مقضیاً» قضا و اراده حتمی الهی است که زمان وقوع آن فرا رسیده است. صفت «هین» اشاره به نفی هرگونه عجز یا صعوبت در تدبیر هستی برای مبدأ آفرینش دارد.',
      ),
    ];
  }
}
