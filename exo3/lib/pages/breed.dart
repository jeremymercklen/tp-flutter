import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/breed.dart';
import '../services/catapi.dart';

class PageBreed extends StatefulWidget {
  PageBreed({super.key, required this.breed});

  Breed breed;
  var catApi = CatAPI();

  @override
  State<StatefulWidget> createState() => _PageBreed();
  }
}

class _PageBreed extends State<PageBreed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(widget.breed.name!),
    ),
    body:
    throw UnimplementedError();
  }
  
}
