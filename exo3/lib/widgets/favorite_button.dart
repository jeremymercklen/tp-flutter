import 'package:exo3/models/breed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/favorites_repository.dart';

class FavoriteButton extends StatelessWidget {
  final Breed favorite;

  const FavoriteButton(this.favorite, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child:
            Consumer<FavoritesRepository>(builder: (context, favorites, child) {
          return IconButton(
              icon: Icon(favorites.isFavorite(favorite)
                  ? Icons.favorite
                  : Icons.favorite_outline),
              style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              onPressed: () {
                if (favorites.isFavorite(favorite)) {
                  favorites.remove(favorite);
                } else {
                  favorites.add(favorite);
                }
              });
        }));
  }
}
