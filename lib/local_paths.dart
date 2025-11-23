final class LocalPaths {
  static final instanceUrl = 'https://zekrnoor.liara.run';
  static final loginEndpoint = Uri.parse('$instanceUrl/auth/login');
  static final bookmarksEndpoint = Uri.parse('$instanceUrl/bookmarks/');

  static final appDir = 'qiq';
  static final userCredPath = '$appDir/user.cred';
  static final quranDir = "$appDir/quran";
}
