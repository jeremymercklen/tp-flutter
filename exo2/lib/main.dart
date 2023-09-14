import 'package:exo2/components.dart';
import 'package:exo2/consts.dart';
import 'package:exo2/pages/results.dart';
import 'package:exo2/repositories/history_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'database.dart';
import 'model/HistoryEntry.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HistoryDatabase().open();
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
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final repo = HistoryEntryRepository();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  late double _valeur1;
  late double _valeur2;
  late FocusNode _op1Focus;
  late Future<List<HistoryEntry>> _history;
  late final DateFormat _dateTimeFormat;

  @override
  void initState() {
    super.initState();
    _op1Focus = FocusNode();
    initializeDateFormatting()
        .then((value) => _dateTimeFormat = DateFormat.yMd('fr').add_jm());
    _history = widget.repo.getAll();
  }

  @override
  void dispose() {
    super.dispose();
    _op1Focus.dispose();
  }

  String? _operandValidator(value) {
    if (value == null ||
        value.trim().isEmpty ||
        (double.tryParse(value) == null)) {
      return 'Valeur invalide';
    }
    return null;
  }

  _displayResult(String operation) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ResultsPage(operation)))
        .then((value) {
      widget.repo.insert(HistoryEntry(operation));
      setState(() {
        _formKey.currentState?.reset();
        _op1Focus.requestFocus();
        _history = widget.repo.getAll();
      });
    });
  }

  _add() {
    late double resultat;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    resultat = (_valeur1 + _valeur2);
    _displayResult("$_valeur1 + $_valeur2 = $resultat");
  }

  _sub() {
    late double resultat;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    resultat = (_valeur1 - _valeur2);
    _displayResult("$_valeur1 - $_valeur2 = $resultat");
  }

  _mul() {
    late double resultat;
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState?.save();
    resultat = (_valeur1 * _valeur2);
    _displayResult("$_valeur1 x $_valeur2 = $resultat");
  }

  _div() {
    late double resultat;
    _formKey.currentState?.save();
    if (!_formKey.currentState!.validate()) return;
    resultat = (_valeur1 / _valeur2);
    _displayResult("$_valeur1 / $_valeur2 = $resultat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                            onSaved: (valeur) =>
                                _valeur1 = double.parse(valeur.toString()),
                            validator: (v) => _operandValidator(v),
                            focusNode: _op1Focus,
                            keyboardType: TextInputType.number)),
                    SizedBox(
                        width: 200,
                        child: TextFormField(
                            onSaved: (valeur) =>
                                _valeur2 = double.parse(valeur.toString()),
                            validator: (v) => _operandValidator(v),
                            keyboardType: TextInputType.number))
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  MySizedBox(
                      child: ElevatedButton(
                          onPressed: () => _add(), child: Icon(Icons.add))),
                  MySizedBox(
                      child: ElevatedButton(
                          onPressed: () => _sub(), child: Icon(Icons.remove))),
                  MySizedBox(
                      child: ElevatedButton(
                          onPressed: () => _mul(), child: Text('X'))),
                  MySizedBox(
                      child: ElevatedButton(
                          onPressed: () => _div(), child: Text('/'))),
                ],
              ),
              Expanded(
                  child: FutureBuilder(
                      future: _history,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return ListView.builder(
                              padding: defaultPadding,
                              itemCount: data.length,
                              itemBuilder: (context, index) => Text(
                                  '${_dateTimeFormat.format(data[index].date)} : ${data[index].operation}'));
                        } else {
                          return const Text('Chargement...');
                        }
                      }))
            ])));
  }
}
