import 'dart:ffi';

import 'package:exo4/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class NewCarPage extends StatefulWidget {
  NewCarPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewCarPage();
}

class _NewCarPage extends State<NewCarPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late String _make;
    late String _model;
    bool _isrunning = false;
    late int _price;
    late String _builddate;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Cars'),
        ),
        drawer: const MyDrawer(),
        body: Form(
            child: Column(
          children: [
            MySizedBox(
                child: TextFormField(
                    onChanged: (value) => _make = value.toString(),
                    decoration: InputDecoration(labelText: 'Make'),
                    validator: (value) =>
                        stringNotEmptyValidator(value, 'Please enter a make'))),
            MySizedBox(
                child: TextFormField(
                    onChanged: (value) => _model = value.toString(),
                    decoration: InputDecoration(labelText: 'Model'),
                    validator: (value) => stringNotEmptyValidator(
                        value, 'Please enter a model'))),
            MySizedBox(
                child: Row(children: [
              Text(
                'Is running',
                style: TextStyle(fontSize: 20),
              ),
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: _isrunning,
                  onChanged: (bool? value) {
                    setState(() {
                      _isrunning = value!;
                    });
                  }),
            ])),
            MySizedBox(
                child: TextFormField(
                    onChanged: (value) => _price = int.parse(value),
                    decoration: InputDecoration(labelText: 'Make'),
                    validator: (value) => stringNotEmptyValidator(
                        value, 'Please enter a price'))),
            MySizedBox(
                child: TextFormField(
                    onChanged: (value) => _builddate = value.toString(),
                    decoration: InputDecoration(labelText: 'Build date'),
                    validator: (value) => stringNotEmptyValidator(
                        value, 'Please enter a build date'))),
          ],
        )));
  }
}
