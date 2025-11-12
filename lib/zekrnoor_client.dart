import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Bookmark {
  Bookmark({this.type = '', this.value = '', this.id = 0, this.userId = 0});

  String type;
  String value;
  int id;
  int userId;
}

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);

  Credentials.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      password = json['password'];

  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}

class ZekrnoorClient {
  static final instanceUrl = 'https://zekrnoor.liara.run';
  static final loginEndpoint = Uri.parse('$instanceUrl/auth/login');
  static final bookmarksEndpoint = Uri.parse('$instanceUrl/bookmarks/');
  static final appDir = 'qiq';
  static final userCredPath = '$appDir/user.cred';

  bool _isAuthenticated = false;
  bool _isAuthenticating = false;

  String? _accessToken;
  String? _username;

  Future<List<Bookmark>?> getBookmarks() async {
    if (!_isAuthenticated) {
      return null;
    }

    final response = await http.get(
      bookmarksEndpoint,
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer ${_accessToken!}',
      },
    );

    if (response.statusCode == 200) {
      final responseJsonBody = jsonDecode(response.body);
      if (responseJsonBody is List<dynamic>) {
        List<Bookmark> result = List.empty(growable: true);

        for (int i = 0; i < responseJsonBody.length; i++) {
          String type = responseJsonBody[i]['type'];
          String value = responseJsonBody[i]['value'];
          int id = responseJsonBody[i]['id'];
          int userId = responseJsonBody[i]['user_id'];

          result.add(
            Bookmark(type: type, value: value, id: id, userId: userId),
          );
        }

        return result;
      }
    }

    return null;
  }

  bool get isLoggedIn {
    return _isAuthenticated;
  }

  String? get username {
    return _username;
  }

  Future<bool> login({String? username, String? password}) async {
    if (_isAuthenticated || _isAuthenticating) {
      return _isAuthenticated;
    }

    _isAuthenticating = true;

    bool isLoginOld = username == null || password == null;
    final docDirPath = (await getApplicationDocumentsDirectory()).path;
    final credFile = File('$docDirPath/$userCredPath');

    // check if logged in already
    if (isLoginOld) {
      if (await credFile.exists()) {
        final cred = Credentials.fromJson(
          jsonDecode(await credFile.readAsString()),
        );

        username = cred.username;
        password = cred.password;
      }
    }

    if (username == null || password == null) {
      return false;
    }

    final response = await http.post(
      loginEndpoint,
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: 'username=$username&password=$password',
    );

    if (response.statusCode == 200) {
      final responseJsonBody = jsonDecode(response.body);

      final accessToken = responseJsonBody['access_token'];
      if (accessToken is String) {
        _accessToken = accessToken;
        _username = username;
        _isAuthenticated = true;

        // save credentials
        if (!isLoginOld) {
          await credFile.create(recursive: true);
          await credFile.writeAsString(
            mode: FileMode.write,
            jsonEncode(Credentials(username, password)),
            flush: true,
          );
        }
      }
    }

    _isAuthenticating = false;

    return _isAuthenticated;
  }
}
