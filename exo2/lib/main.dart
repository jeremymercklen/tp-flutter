import 'package:exo2/components.dart';
import 'package:exo2/consts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late int _valeur1;
  late int _valeur2;

  _displayResult(
    String operation,
  ) {}

  _add() {
    int? resultat;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    resultat = (_valeur1 + _valeur2);
    _displayResult("$_valeur1 + $_valeur2 = $resultat");
  }

  _sub() {}

  _mul() {}

  _div() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                  width: 200,
                  child: TextFormField(
                      onSaved: (valeur) => _valeur1 = valeur as int)),
              SizedBox(
                  width: 200,
                  child: TextFormField(
                      onSaved: (valeur) => _valeur2 = valeur as int,
                      validator: (v) =>
                          stringNotEmptyValidator(v, 'Veuillez saisir un nom')))
            ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            MySizedBox(
                child:
                    ElevatedButton(onPressed: () {}, child: Icon(Icons.add))),
            MySizedBox(
                child: ElevatedButton(
                    onPressed: () {}, child: Icon(Icons.remove))),
            MySizedBox(
                child: ElevatedButton(onPressed: () {}, child: Text('X'))),
            MySizedBox(
                child: ElevatedButton(onPressed: () {}, child: Text('/')))
          ],
        )
      ]),
    );
  }
}
