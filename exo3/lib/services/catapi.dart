import 'package:exo3/models/breed.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatusErrorException {
  final int statusCode;

  const StatusErrorException(this.statusCode);
}

class CatAPI {
  static const apiServer = 'api.thecatapi.com';
  static const apiUrl = '';
  static const searchRoute = '$apiUrl/V1/breeds';

  Future<List<Breed>> breeds() async {
    List<Breed> breeds = [];
    var result = await http.get(Uri.https(apiServer, searchRoute), headers: {
      'x-api-key':
          'live_kAqtkvnc0EopUyYf1kC0hAwRd8AKSI9VyWMUMM7LzVJ9YV9NIbIA6CFMnsjupyTc'
    });
    if (result.statusCode == 200) {
      final List<dynamic> datas = await jsonDecode(result.body);
      for (var data in datas) {
        Breed breed = Breed.fromMap(data);
        breeds.add(breed);
      }
      return breeds;
    }
    throw StatusErrorException(result.statusCode);
  }
}
