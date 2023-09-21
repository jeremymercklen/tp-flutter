class UserAccount {
  late String displayname;
  late String login;
  late String? password;

  UserAccount({required this.displayname, required this.login, this.password});

  toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayname'] = this.displayname;
    data['login'] = this.login;
    data['password'] = this.password;
    return data;
  }

  UserAccount.fromMap(Map<String, dynamic> map) {
    displayname = map['displayname'];
    login = map['login'];
  }
}
