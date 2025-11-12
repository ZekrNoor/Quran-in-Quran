import 'package:flutter/cupertino.dart';

import 'al_quran_al_karim.dart';
import 'daily_meditation.dart';
import 'home_header.dart';
import 'todays_ayah.dart';

class HomeMainLayout extends StatelessWidget {
  const HomeMainLayout({
    super.key,
    this.onProfileSelected,
    this.onSideBarMenuSelected,
    this.onResumeReading,
  });

  final void Function()? onProfileSelected;
  final void Function()? onSideBarMenuSelected;
  final void Function()? onResumeReading;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // navigationBar: const CupertinoNavigationBar.large(
      //   largeTitle: Text(
      //     LocalStrings.welcome,
      //     style: TextStyle(
      //       fontFamily: 'Estedad',
      //       fontSize: 42.0,
      //       fontVariations: [
      //         FontVariation('wght', 800.0),
      //         FontVariation('KSHD', 100.0),
      //       ],
      //     ),
      //   ),
      // ),

      child: SafeArea(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),

          child: ListView(
            physics: ClampingScrollPhysics(),

            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ),

                child: HomeHeader(
                  profileCallback: onProfileSelected,
                  sideBarMenuCallback: onSideBarMenuSelected,
                ),
              ),

              SizedBox(height: 40),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: AlQuranAlKarim(onResumeReading: onResumeReading),
              ),

              SizedBox(height: 40),

              Padding(
                padding: EdgeInsetsGeometry.only(right: 12),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [const Spacer(), DailyMeditation()],
                ),
              ),

              SizedBox(height: 40),

              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                child: TodaysAyah(),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
