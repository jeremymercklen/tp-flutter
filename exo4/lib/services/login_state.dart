import 'package:exo4/model/user_account.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginState extends ChangeNotifier {
  UserAccount? _user;
  String? _token;

  LoginState() {
    SharedPreferences.getInstance().then((prefs) {
      final token = prefs.getString("token");
      final displayname = prefs.getString("displayname");
      final login = prefs.getString("login");
      if ((token != null) && (login != null) && (displayname != null)) {
        _user = UserAccount(displayname: displayname, login: login);
        _token = token;
        notifyListeners();
      }
    });
  }

  bool get connected => _user != null;

  get user => _user;

  get token => _token;

  set user(user) {
    _user = user;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("displayname", _user!.displayname);
      prefs.setString("login", _user!.login);
    });
  }

  set token(token) {
    _token = token;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("token", _token!);
    });
  }

  disconnect() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove("token");
      prefs.remove("displayname");
      prefs.remove("login");
    });
    _user = null;
    _token = null;
    notifyListeners();
  }
}
