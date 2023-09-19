import 'package:exo3/models/breed.dart';
import 'package:exo3/models/image.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StatusErrorException {
  final int statusCode;

  const StatusErrorException(this.statusCode);
}

class CatAPI {
  static const apiServer = 'api.thecatapi.com';
  static const apiUrl = '/V1';
  static const searchRoute = '$apiUrl/breeds';

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

  Future<List<Image>> get5Images(String nomBreed) async {
    List<Image> images = [];
    const _searchRoute = '$apiUrl/images/search';

    var result = await http.get(
        Uri.https(
            apiServer, _searchRoute, {'breed_ids': nomBreed, 'limit': '5'}),
        headers: {
          'x-api-key':
              'live_kAqtkvnc0EopUyYf1kC0hAwRd8AKSI9VyWMUMM7LzVJ9YV9NIbIA6CFMnsjupyTc'
        });
    if (result.statusCode == 200) {
      final List<dynamic> datas = await jsonDecode(result.body);
      for (var data in datas) {
        Image image = Image.fromJson(data);
        images.add(image);
      }
      return images;
    }
    throw StatusErrorException(result.statusCode);
  }
}
