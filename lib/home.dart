import 'package:flutter/cupertino.dart';

import 'package:quran_in_quran/surah_menu.dart';
import 'package:quran_in_quran/home_main_layout.dart';
import 'package:quran_in_quran/profile_card.dart';
import 'package:quran_in_quran/profile_overview.dart';
import 'package:quran_in_quran/reader.dart';
import 'package:quran_in_quran/side_bar_menu.dart';
import 'package:quran_in_quran/sign_in.dart';

class QiQHome extends StatefulWidget {
  const QiQHome({super.key});

  @override
  State<QiQHome> createState() => _QiQHomeState();
}

class _QiQHomeState extends State<QiQHome> {
  bool _isProfileOverviewInFocus = false;
  bool _isProfileCardInFocus = false;
  bool _isSideBarMenuInFocus = false;
  bool _isHomeMainLayoutInFocus = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: !_isHomeMainLayoutInFocus,

          child: HomeMainLayout(
            onProfileSelected: () {
              setState(() {
                _isHomeMainLayoutInFocus = false;
                _isProfileOverviewInFocus = true;
              });
            },

            onSideBarMenuSelected: () {
              setState(() {
                _isHomeMainLayoutInFocus = false;
                _isSideBarMenuInFocus = true;
              });
            },

            onResumeReading: () {
              Navigator.of(context).push(createRouteQiQReader());
            },

            onSurahMenu: () {
              Navigator.of(context).push(createRouteQiQSurahMenu());
            },
          ),
        ),

        IgnorePointer(
          ignoring: !_isProfileOverviewInFocus,

          child: ProfileOverview(
            isInFocus: _isProfileOverviewInFocus,

            onProfileSelected: () {
              setState(() {
                // _isProfileOverviewInFocus = false;
                _isProfileCardInFocus = true;
              });
            },

            onNotesSelected: () {},

            onBookmarksSelected: () {},

            onFavoritesSelected: () {},

            onReturn: () {
              setState(() {
                _isProfileOverviewInFocus = false;
                _isHomeMainLayoutInFocus = true;
              });
            },
          ),
        ),

        IgnorePointer(
          ignoring: !_isProfileCardInFocus,

          child: ProfileCard(
            isInFocus: _isProfileCardInFocus,

            onSignIn: () {
              // TODO: design sign-in page
              // maybe not the most optimal way of doing this
              setState(() {
                _isProfileCardInFocus = false;
                _isProfileOverviewInFocus = false;
                _isHomeMainLayoutInFocus = true;
              });

              Navigator.of(context).push(createRouteQiQSignIn());
            },

            onSignUp: () {
              // TODO: design sign-up page
              setState(() {
                _isProfileCardInFocus = false;
                _isProfileOverviewInFocus = false;
                _isHomeMainLayoutInFocus = true;
              });
            },

            onReturn: () {
              setState(() {
                _isProfileCardInFocus = false;
                // _isProfileOverviewInFocus = true;
              });
            },
          ),
        ),

        IgnorePointer(
          ignoring: !_isSideBarMenuInFocus,

          child: SideBarMenu(
            isInFocus: _isSideBarMenuInFocus,

            onReturn: () {
              setState(() {
                _isSideBarMenuInFocus = false;
                _isHomeMainLayoutInFocus = true;
              });
            },
          ),
        ),
        // TODO: implement menu animation & functionality
      ],
    );
  }
}
