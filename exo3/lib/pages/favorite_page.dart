import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/favorites_repository.dart';
import '../widgets/favorite_bar.dart';
import '../widgets/favorite_button.dart';
import 'breed.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Favoris'),
            ),
            body:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Consumer<FavoritesRepository>(
                  builder: (context, favorites, child) => Expanded(
                      child: ListView.builder(
                          itemCount: favorites.count,
                          itemBuilder: (context, index) {
                            final favorite = favorites.get(index);
                            return Row(children: [
                              FavoriteButton(favorite),
                              GestureDetector(
                                  child: Text(favorite.name!),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PageBreed(breed: favorite)));
                                  })
                            ]);
                          })))
            ])));
  }
}
