import 'package:exo4/components.dart';
import 'package:exo4/pages/signin_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 200, 20, 20),
            child: Center(
                child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Cars', style: TextStyle(fontSize: 50)),
                  MySizedBox(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Login'),
                          validator: (v) {})),
                  MySizedBox(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (v) {},
                          obscureText: true)),
                  MySizedBox(
                      child: MyElevatedButton(onPressed: () {}, text: 'Login')),
                  MySizedBox(
                      child: MyElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SigninPage()));
                          },
                          text: 'Sign in'))
                ],
              ),
            ))));
  }
}
