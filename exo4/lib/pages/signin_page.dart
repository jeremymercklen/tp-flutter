import 'package:exo4/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key});

  @override
  State<StatefulWidget> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    late String _password;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Sign in'),
        ),
        body: Column(
          children: [
            MySizedBox(
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Display name'),
                    validator: (value) =>
                        stringNotEmptyValidator(value, 'Please enter a name'))),
            MySizedBox(
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Login'),
                    validator: (value) => stringNotEmptyValidator(
                        value, 'Please enter a Login'))),
            MySizedBox(
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => _password = value.toString(),
                    validator: (value) => stringNotEmptyValidator(
                        value, 'Please enter a password'),
                    obscureText: true)),
            MySizedBox(
                child: TextFormField(
                    decoration: InputDecoration(labelText: 'Repeat password'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please repeat the password';
                      }
                      if (value != _password) {
                        return 'The passwords does not matches';
                      }
                      return null;
                    },
                    obscureText: true)),
            MySizedBox(
                child: MyElevatedButton(onPressed: () {}, text: 'Sign in'))
          ],
        ));
  }
}
