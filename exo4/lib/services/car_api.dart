import 'package:exo4/model/user_account.dart';
import 'package:http/http.dart' as http;

class CarAPI {
  static const apiServer = 'extranet.esimed.fr:3333';
  static const apiUrl = '';
}

class UserAccountRoutes extends CarAPI {
  static const authRoutes = '${CarAPI.apiUrl}/useraccount';
  static const userAccountRoutes = '${CarAPI.apiUrl}/users';

  Future insert(UserAccount userAccount) async {
    var result = await http.post(
        Uri.https(CarAPI.apiServer, '$userAccountRoutes/add'),
        body: userAccount.toMap());
  }
}
