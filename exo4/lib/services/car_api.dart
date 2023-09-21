import 'dart:convert';

import 'package:exo4/model/user_account.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/authentication_result.dart';
import 'login_state.dart';

class StatusErrorException {
  final int statusCode;

  const StatusErrorException(this.statusCode);
}

class CarAPI {
  static const apiServer = 'extranet.esimed.fr:3333';
  static const apiUrl = '';
}

class UserAccountRoutes extends CarAPI {
  static const userAccountRoutes = '${CarAPI.apiUrl}/useraccount';
  static const authRoutes = '$userAccountRoutes/authenticate';

  Future insert(UserAccount userAccount) async {
    var result = await http.post(
        Uri.http(CarAPI.apiServer, '$userAccountRoutes'),
        body: userAccount.toMap());
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
  }

  Future get(String login) async {
    var result =
        await http.get(Uri.http(CarAPI.apiServer, '$userAccountRoutes/$login'));
    if (result.statusCode == 200)
      return true;
    else
      return false;
  }

  Future<AuthenticationResult> authenticate(
      String login, String password) async {
    var result = await http.post(Uri.http(CarAPI.apiServer, authRoutes),
        body: {'login': login, 'password': password});
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
    final Map<String, dynamic> datas = jsonDecode(result.body);
    return AuthenticationResult.fromMap(datas);
  }

  Future refreshToken(context) async {
    var token = Provider.of<LoginState>(context, listen: false).token;
    var result = await http.get(
        Uri.http(CarAPI.apiServer, '$userAccountRoutes/refreshtoken'),
        headers: {'Authorization': 'Bearer a$token'});
    if (result.statusCode == 200)
      return jsonDecode(result.body);
    else
      throw StatusErrorException(result.statusCode);
  }
}
