import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final String operation;

  ResultsPage(this.operation, {super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Resultats'),
            ),
            body: Center(
              child: Text(widget.operation),
            )));
  }
}
