import 'dart:ffi';

import 'package:exo4/components.dart';
import 'package:exo4/model/car.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import '../services/car_api.dart';
import '../widgets/drawer.dart';

class NewCarPage extends StatefulWidget {
  NewCarPage({super.key});

  final carRoutes = CarRoutes();

  @override
  State<StatefulWidget> createState() => _NewCarPage();
}

class _NewCarPage extends State<NewCarPage> {
  final _formKey = GlobalKey<FormState>();
  late String _make;
  late String _model;
  bool _isrunning = false;
  late int _price;
  DateTime _buildDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _buildDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != _buildDate)
      setState(() {
        _buildDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text('Cars'),
            ),
            drawer: const MyDrawer(),
            body: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MySizedBox(
                        child: TextFormField(
                            onChanged: (value) => _make = value.toString(),
                            decoration: InputDecoration(labelText: 'Make'),
                            validator: (value) => stringNotEmptyValidator(
                                value, 'Please enter a make'))),
                    MySizedBox(
                        child: TextFormField(
                            onChanged: (value) => _model = value.toString(),
                            decoration: InputDecoration(labelText: 'Model'),
                            validator: (value) => stringNotEmptyValidator(
                                value, 'Please enter a model'))),
                    MySizedBox(
                        child: TextFormField(
                            onChanged: (value) => _price = int.parse(value),
                            decoration: InputDecoration(labelText: 'Price'),
                            validator: (value) => stringNotEmptyValidator(
                                value, 'Please enter a price'))),
                    MySizedBox(
                        child: Row(children: [
                      Text(
                        'Is running',
                        style: TextStyle(fontSize: 20),
                      ),
                      Checkbox(
                          //checkColor: Colors.white,
                          //fillColor: MaterialStateProperty.resolveWith(getColor),
                          value: _isrunning,
                          onChanged: (bool? value) {
                            setState(() {
                              _isrunning = value!;
                            });
                          }),
                    ])),
                    Column(children: [
                      Row(
                        children: [
                          Text('Build date : ', style: TextStyle(fontSize: 20)),
                          Text(DateFormat.yMd().format(_buildDate),
                              style: TextStyle(fontSize: 20))
                        ],
                      ),
                      MySizedBox(
                          child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        child: const Text('Select date'),
                      ))
                    ]),
                    MySizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              var car = Car(_make, _model, _isrunning, _price,
                                  DateFormat.yMd().format(_buildDate));
                              widget.carRoutes.insert(car, context);
                            },
                            child: Text('Add car')))
                  ],
                ))));
  }
}
