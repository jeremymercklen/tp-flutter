class AuthenticationResult {
  late String displayname;
  late String login;
  late String token;

  AuthenticationResult(this.displayname, this.login, this.token);

  AuthenticationResult.fromMap(Map<String, dynamic> json) {
    login = json['login'];
    displayname = json['displayname'];
    token = json['token'];
  }
}
