import 'package:exo3/repositories/favorites_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/favorite_page.dart';

class FavoritesBar extends StatelessWidget {
  const FavoritesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child:
        Consumer<FavoritesRepository>(builder: (context, favorites, child) {
      return ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const FavoritesPage()));
          },
          icon: const Icon(Icons.favorite),
          label: Text('${favorites.count}'),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.red)));
    }));
  }
}
