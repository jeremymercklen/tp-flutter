import 'package:exo4/model/user_account.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends ChangeNotifier {
  UserAccount? _user;
  String? _token;

  bool get connected => _user != null;

  get user => _user;

  get token => _token;

  setUser(UserAccount user) => _user = user;

  setToken(String token) => _token = token;

  disconnect() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
