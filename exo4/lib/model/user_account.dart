class UserAccount {
  late String displayName;
  late String login;
  late String password;

  UserAccount(this.displayName, this.login, this.password);

  toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['login'] = this.login;
    data['password'] = this.password;
    return data;
  }

  UserAccount.fromMap(Map<String, dynamic> map) {
    displayName = map['displayName'];
    login = map['login'];
  }
}
