import 'dart:ui';
import 'dart:ui';

import 'package:exo3/widgets/favorite_bar.dart';
import 'package:exo3/widgets/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/breed.dart';
import '../models/image.dart' as image;
import '../services/catapi.dart';

class PageBreed extends StatefulWidget {
  PageBreed({super.key, required this.breed});

  Breed breed;
  final catApi = CatAPI();

  @override
  State<StatefulWidget> createState() => _PageBreed();
}

class _PageBreed extends State<PageBreed> {
  @override
  Widget build(BuildContext context) {
    late Future<List<image.Image>> images =
        widget.catApi.get5Images(widget.breed.id!);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.breed.name!),
        ),
        body: Column(children: [
          Text(widget.breed.description!),
          FavoriteButton(widget.breed),
          Expanded(
              child: FutureBuilder(
                  future: images,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: Image.network(data.elementAt(index).url!,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Center(child: CircularProgressIndicator());
                            }));
                          });
                    }
                    return const Center(child: CircularProgressIndicator());
                  })),
          FavoritesBar()
        ]));
  }
}
