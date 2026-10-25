# نقشه ساختار پروژه (Project Structure Map - Graphify)

> تولید شده به صورت خودکار توسط ابزار Graphify برای بهینه‌سازی مصرف توکن و تسریع تحلیل ایجنت‌ها.
> آخرین بروزرسانی: 2026-10-25T19:55:21.181025

## ساختار درختی و محتوای ماژول‌ها


### 📁 ماژول `client`
- **`lib/client/zekrnoor_client.dart`**
  - تعاریف: `class Bookmark`, `class Credentials`, `class ZekrnoorClient`
  - وابستگی‌ها: 'dart:convert', 'dart:io', 'package:http/http.dart' as http...

### 📁 ماژول `data`
- **`lib/data/models/ayah.dart`**
  - تعاریف: `class Ayah`
- **`lib/data/models/comment.dart`**
  - تعاریف: `class VerseComment`
- **`lib/data/models/tafsir.dart`**
  - تعاریف: `class VerseTafsir`, `class VerseTranslation`
- **`lib/data/repositories/local_storage_repository.dart`**
  - تعاریف: `class LocalStorageRepository`
  - وابستگی‌ها: 'dart:convert', 'package:shared_preferences/shared_preferences.dart', '../models/comment.dart'
- **`lib/data/repositories/quran_repository.dart`**
  - تعاریف: `class JuzInfo`, `class HizbInfo`, `class QuranRepository`
  - وابستگی‌ها: '../models/ayah.dart', '../models/tafsir.dart', '../../reader/chapter.dart'...

### 📁 ماژول `home`
- **`lib/home/al_quran_al_karim.dart`**
  - تعاریف: `class AlQuranAlKarim extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/strings.dart'
- **`lib/home/daily_meditation.dart`**
  - تعاریف: `class DailyMeditation extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/strings.dart'
- **`lib/home/events_near_you.dart`**
  - تعاریف: `class EventsNearYou extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/strings.dart'
- **`lib/home/home.dart`**
  - تعاریف: `class QiQHome extends StatefulWidget`, `class _QiQHomeState extends State<QiQHome>`
  - وابستگی‌ها: 'surah_menu/route.dart', 'profile/profile_card.dart', 'profile/profile_overview.dart'...
- **`lib/home/home_header.dart`**
  - تعاریف: `class HomeHeader extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/strings.dart', 'events_near_you.dart'
- **`lib/home/home_main_layout.dart`**
  - تعاریف: `class HomeMainLayout extends StatelessWidget`
  - وابستگی‌ها: 'al_quran_al_karim.dart', 'daily_meditation.dart', 'home_header.dart'...
- **`lib/home/profile/profile_card.dart`**
  - تعاریف: `class ProfileCard extends StatefulWidget`, `class ProfileCardLoggedIn extends StatelessWidget`, `class ProfileCardLoggedOut extends StatelessWidget`, `class _ProfileCardState extends State<ProfileCard>`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart', 'package:quran_in_quran/local/strings.dart'...
- **`lib/home/profile/profile_overview.dart`**
  - تعاریف: `class ProfileOverview extends StatefulWidget`, `class _ProfileOverviewState extends State<ProfileOverview>`
  - وابستگی‌ها: 'dart:math', 'dart:ui'
- **`lib/home/side_bar_menu.dart`**
  - تعاریف: `class SideBarMenu extends StatefulWidget`, `class _SideBarMenuState extends State<SideBarMenu>`
  - وابستگی‌ها: 'dart:ui'
- **`lib/home/sign_in/route.dart`**
  - وابستگی‌ها: 'sign_in.dart'
- **`lib/home/sign_in/sign_in.dart`**
  - تعاریف: `class QiQSignIn extends StatelessWidget`
- **`lib/home/surah_menu/container.dart`**
  - تعاریف: `class SurahContainer extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart'
- **`lib/home/surah_menu/icon.dart`**
  - تعاریف: `class SurahIcon extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart'
- **`lib/home/surah_menu/list.dart`**
  - تعاریف: `class SurahList extends StatefulWidget`, `class _SurahListState extends State<SurahList>`
  - وابستگی‌ها: '../../data/repositories/quran_repository.dart', '../../reader/chapter.dart', '../../reader/route.dart'...
- **`lib/home/surah_menu/menu.dart`**
  - تعاریف: `class QiQSurahMenu extends StatelessWidget`
  - وابستگی‌ها: '../../ui/phosphor_icons.dart', 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/main.dart'...
- **`lib/home/surah_menu/name.dart`**
  - تعاریف: `class SurahName extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart', 'package:quran_in_quran/reader/chapter.dart'
- **`lib/home/surah_menu/route.dart`**
  - وابستگی‌ها: 'menu.dart'
- **`lib/home/surah_menu/search_box.dart`**
  - تعاریف: `class SearchBox extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart', 'package:quran_in_quran/local/strings.dart'
- **`lib/home/surah_menu/surah.dart`**
  - تعاریف: `class Surah extends StatelessWidget`
  - وابستگی‌ها: '../../ui/phosphor_icons.dart', 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/reader/chapter.dart'...
- **`lib/home/todays_ayah.dart`**
  - تعاریف: `class TodaysAyah extends StatelessWidget`
  - وابستگی‌ها: 'dart:math', 'package:provider/provider.dart', '../data/repositories/quran_repository.dart'...

### 📁 ماژول `local`
- **`lib/local/colors.dart`**
  - وابستگی‌ها: 'dart:ui'
- **`lib/local/consts.dart`**
- **`lib/local/paths.dart`**
- **`lib/local/strings.dart`**

### 📁 ماژول `root`
- **`lib/main.dart`**
  - تعاریف: `class QiQApp extends StatelessWidget`
  - وابستگی‌ها: 'package:provider/provider.dart', 'package:window_manager/window_manager.dart', 'nav_bar/nav_bar.dart'...

### 📁 ماژول `nav_bar`
- **`lib/nav_bar/nav_bar.dart`**
  - تعاریف: `class NotchedContainerClipper extends CustomClipper<Path>`, `class NavBar extends StatefulWidget`, `class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin`
  - وابستگی‌ها: '../ui/phosphor_icons.dart', 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart'

### 📁 ماژول `providers`
- **`lib/providers/reflection_provider.dart`**
  - تعاریف: `class ReflectionProvider extends ChangeNotifier`
  - وابستگی‌ها: '../data/models/comment.dart', '../data/repositories/local_storage_repository.dart'

### 📁 ماژول `reader`
- **`lib/reader/chapter.dart`**
  - تعاریف: `class Chapter`, `class ChaptersData`
- **`lib/reader/info_bar.dart`**
  - تعاریف: `class InfoBar extends StatelessWidget`
  - وابستگی‌ها: '../ui/phosphor_icons.dart', 'package:quran_in_quran/ui/gold.dart', 'package:quran_in_quran/local/colors.dart'...
- **`lib/reader/qpage.dart`**
  - تعاریف: `class QPage extends StatefulWidget`, `class _QPageState extends State<QPage>`
  - وابستگی‌ها: 'dart:convert', 'dart:io', 'package:path_provider/path_provider.dart'...
- **`lib/reader/reader.dart`**
  - تعاریف: `class PageNumber extends StatelessWidget`, `class Reader extends StatefulWidget`, `class _ReaderState extends State<Reader>`, `class QiQReader extends StatefulWidget`, `class _QiQReaderState extends State<QiQReader>`
  - وابستگی‌ها: 'chapter.dart', 'package:quran_in_quran/ui/gold.dart', 'package:quran_in_quran/local/colors.dart'...
- **`lib/reader/route.dart`**
  - وابستگی‌ها: 'chapter.dart', 'reader.dart'
- **`lib/reader/verse_card.dart`**
  - تعاریف: `class VerseCard extends StatelessWidget`
  - وابستگی‌ها: 'package:provider/provider.dart', '../data/models/ayah.dart', '../providers/reflection_provider.dart'...
- **`lib/reader/verse_reader_screen.dart`**
  - تعاریف: `class VerseReaderScreen extends StatefulWidget`, `class _VerseReaderScreenState extends State<VerseReaderScreen>`
  - وابستگی‌ها: '../data/models/ayah.dart', '../data/repositories/quran_repository.dart', '../reader/chapter.dart'...
- **`lib/reader/verse_reflection_modal.dart`**
  - تعاریف: `class VerseReflectionModal extends StatefulWidget`, `class _VerseReflectionModalState extends State<VerseReflectionModal>`, `class Divider extends StatelessWidget`
  - وابستگی‌ها: 'package:provider/provider.dart', '../data/models/ayah.dart', '../data/repositories/quran_repository.dart'...
- **`lib/reader/word.dart`**
  - تعاریف: `class Word extends StatelessWidget`
  - وابستگی‌ها: 'package:quran_in_quran/local/colors.dart', 'package:quran_in_quran/local/consts.dart'

### 📁 ماژول `root`
- **`lib/resource_manager.dart`**
  - تعاریف: `class ResourceManager`
  - وابستگی‌ها: 'dart:convert', 'package:quran_in_quran/reader/chapter.dart'

### 📁 ماژول `ui`
- **`lib/ui/gold.dart`**
  - تعاریف: `class RoundedContainer extends StatelessWidget`, `class GoldButton extends StatelessWidget`, `class GoldBar extends StatelessWidget`
  - وابستگی‌ها: 'phosphor_icons.dart', 'package:quran_in_quran/local/colors.dart'
- **`lib/ui/phosphor_icons.dart`**

### 📁 ماژول `util`
- **`lib/util/to_hindi.dart`**
