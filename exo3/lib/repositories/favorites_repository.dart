import 'package:exo3/cats_database.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/breed.dart';

class FavoritesRepository extends ChangeNotifier {
  List<Breed> favoris = [];
  final Database _db = CatsDatabase().database;
  final _tableChats = 'favorite';

  FavoritesRepository() {
    _db.query(_tableChats).then((datas) {
      favoris = datas.map((e) => Breed.fromMap(e)).toList();
      notifyListeners();
    });
  }

  get count => favoris.length;

  add(Breed breed) async {
    favoris.add(breed);
    await _db.insert(_tableChats, breed.toMap());
    notifyListeners();
  }

  remove(Breed breed) async {
    favoris.remove(breed);
    await _db.delete(_tableChats, where: 'id = ?', whereArgs: [breed.id]);
    notifyListeners();
  }

  bool isFavorite(Breed breed) {
    for (var index in favoris) {
      if (index == breed) return true;
    }
    return false;
  }

  Breed get(int i) {
    return favoris.elementAt(i);
  }
}
