import 'package:flutter/material.dart';
import 'chapter.dart';
import 'package:quran_in_quran/ui/gold.dart';
import 'package:quran_in_quran/local/colors.dart';
import 'package:quran_in_quran/local/consts.dart';
import 'package:quran_in_quran/main.dart';
import 'package:quran_in_quran/util/to_hindi.dart';
import 'word.dart';
import 'qpage.dart';
import 'info_bar.dart';

class PageNumber extends StatelessWidget {
  const PageNumber(this.pageNumber, {super.key});

  final int pageNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),
        ),
        borderRadius: BorderRadius.circular(36),
      ),

      child: SizedBox(
        width: 50,

        child: Text(
          pageNumber.toHindi(),

          textAlign: TextAlign.center,

          style: TextStyle(
            color: Color.fromRGBO(0x77, 0x77, 0x77, 1.0),

            fontFamily: 'Sindhi',
            fontSize: 18,

            height: 1.0,
          ),
        ),
      ),
    );
  }
}

class Reader extends StatefulWidget {
  const Reader({
    super.key,
    this.page,
    this.chapter,
    this.onPageChange,
    this.onSelectAyah,
  });

  final int? page;
  final int? chapter;
  // TODO: add chapter number as argument
  final void Function(int page)? onPageChange;
  final void Function(List<Word> ayah)? onSelectAyah;

  @override
  State<Reader> createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  QPage? _prevPage;
  late QPage _thisPage;
  QPage? _nextPage;

  late int _currentPage;
  bool _isGoingForward = false;

  Chapter? _heroChapter;

  void _setNextPage() {
    _currentPage++;

    setState(() {
      _isGoingForward = true;

      _prevPage = _thisPage;
      _thisPage = _nextPage!;
    });

    _nextPage = _currentPage < 604
        ? (_heroChapter != null) && ((_currentPage + 1) == _heroChapter!.page)
              ? QPage(
                  key: UniqueKey(),
                  chapter: _heroChapter,
                  onSelectAyah: widget.onSelectAyah,
                )
              : QPage(
                  key: UniqueKey(),
                  number: _currentPage + 1,
                  onSelectAyah: widget.onSelectAyah,
                )
        : null;
  }

  void _setPrevPage() {
    _currentPage--;

    setState(() {
      _isGoingForward = false;

      _nextPage = _thisPage;
      _thisPage = _prevPage!;
    });

    _prevPage = _currentPage > 1
        ? (_heroChapter != null) && ((_currentPage - 1) == _heroChapter!.page)
              ? QPage(
                  key: UniqueKey(),
                  chapter: _heroChapter,
                  onSelectAyah: widget.onSelectAyah,
                )
              : QPage(
                  key: UniqueKey(),
                  number: _currentPage - 1,
                  onSelectAyah: widget.onSelectAyah,
                )
        : null;
  }

  @override
  void initState() {
    super.initState();

    if (widget.page != null) {
      _currentPage = widget.page!;
    }

    if (widget.chapter != null) {
      _heroChapter = QiQApp.resMan.chaptersData.chapters[widget.chapter! - 1];
      _currentPage = _heroChapter!.page;
    }

    _prevPage = _currentPage > 1
        ? QPage(
            key: UniqueKey(),
            number: _currentPage - 1,
            onSelectAyah: widget.onSelectAyah,
          )
        : null;
    _thisPage = _heroChapter != null
        ? QPage(
            key: UniqueKey(),
            chapter: _heroChapter,
            onSelectAyah: widget.onSelectAyah,
          )
        : QPage(
            key: UniqueKey(),
            number: _currentPage,
            onSelectAyah: widget.onSelectAyah,
          );
    _nextPage = _currentPage < 604
        ? QPage(
            key: UniqueKey(),
            number: _currentPage + 1,
            onSelectAyah: widget.onSelectAyah,
          )
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.short4,

      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,

      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(
              _isGoingForward
                  ? LocalConsts.readerSlideOffset
                  : -LocalConsts.readerSlideOffset,
              0.0,
            ),
            end: Offset.zero,
          ).animate(animation),

          child: FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(animation),

            child: child,
          ),
        );
      },

      layoutBuilder: (currentChild, previousChildren) => currentChild!,

      child: Dismissible(
        key: UniqueKey(),

        direction: _prevPage != null
            ? (_nextPage != null
                  ? DismissDirection.horizontal
                  : DismissDirection.startToEnd)
            : DismissDirection.endToStart,

        dismissThresholds: const <DismissDirection, double>{
          DismissDirection.startToEnd: 0.1,
          DismissDirection.endToStart: 0.1,
        },

        movementDuration: Durations.short2,
        resizeDuration: null,

        onDismissed: (direction) {
          if (direction == DismissDirection.startToEnd) {
            _setPrevPage();
          } else {
            _setNextPage();
          }

          (widget.onPageChange ?? (_) {})(_currentPage);
        },

        child: _thisPage,
      ),
    );
  }
}

class QiQReader extends StatefulWidget {
  const QiQReader({super.key, this.chapter});

  final Chapter? chapter;

  @override
  State<QiQReader> createState() => _QiQReaderState();
}

class _QiQReaderState extends State<QiQReader>
    with SingleTickerProviderStateMixin {
  late int _page;
  late int _chapter;

  List<Word> _ayahInFocus = List.empty();

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  bool _isAyahInFocus = false;

  @override
  void initState() {
    super.initState();

    final Chapter chapter =
        widget.chapter ?? QiQApp.resMan.chaptersData.chapters[0];

    _page = chapter.page;
    _chapter = chapter.number;

    _controller = AnimationController(vsync: this, duration: Durations.medium1);

    _offsetAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          )
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status.isCompleted) {
              setState(() {
                _isAyahInFocus = true;
              });
            } else if (status.isDismissed) {
              setState(() {
                _isAyahInFocus = false;
              });
            }
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LocalColors.quranAppReaderBg,

      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 14.0,
                  ),

                  child: InfoBar(chapter: _chapter),
                ),

                SizedBox(height: 10),

                Reader(
                  chapter: _chapter,

                  onPageChange: (page) {
                    setState(() {
                      _page = page;
                    });
                  },

                  onSelectAyah: (ayah) {
                    _ayahInFocus = ayah;

                    _controller.forward();
                  },
                ),

                const Spacer(),

                PageNumber(_page),

                SizedBox(height: 10),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,

            child: Padding(
              padding: EdgeInsets.only(bottom: 40),

              child: Row(
                children: [const Spacer(), const GoldBar(), const Spacer()],
              ),
            ),
          ),

          IgnorePointer(
            ignoring: !_isAyahInFocus,

            child: Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _controller.reverse();
                    },
                  ),
                ),

                SlideTransition(
                  position: _offsetAnimation,

                  child: SizedBox(
                    width: double.infinity,

                    child: Card(
                      margin: EdgeInsets.zero,

                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.vertical(
                          top: Radius.circular(LocalConsts.profileCardRadius),
                          bottom: Radius.zero,
                        ),
                      ),

                      child: Padding(
                        padding: EdgeInsetsGeometry.symmetric(
                          vertical: 60,
                          horizontal: 30,
                        ),

                        child: Wrap(
                          direction: Axis.horizontal,
                          textDirection: TextDirection.rtl,

                          spacing: 4.0,
                          runSpacing: 30.0,

                          children: _ayahInFocus,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
