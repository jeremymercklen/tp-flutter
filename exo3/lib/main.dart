import 'package:exo3/pages/breed.dart';
import 'package:exo3/repositories/favorites_repository.dart';
import 'package:exo3/services/catapi.dart';
import 'package:exo3/widgets/favorite_bar.dart';
import 'package:exo3/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cats_database.dart';
import 'models/breed.dart' as breed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CatsDatabase().open();
  runApp(ChangeNotifierProvider(
      create: (favoriteRepository) => new FavoritesRepository(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exo3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Exo3'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  var catApi = CatAPI();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<breed.Breed>> _breeds;

  @override
  Widget build(BuildContext context) {
    _breeds = widget.catApi.breeds();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: _breeds,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PageBreed(
                                        breed: data.elementAt(index))));
                              },
                              child: Card(
                                  child: Column(children: [
                                Text(data.elementAt(index).name!,
                                    style: TextStyle(fontSize: 20)),
                                (data.elementAt(index).image != null
                                    ? Image.network(
                                        data.elementAt(index).image!.url!,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                            child: CircularProgressIndicator());
                                      })
                                    : Container()),
                                FavoriteButton(data.elementAt(index))
                              ]))));
                    }
                    return const Center(child: CircularProgressIndicator());
                  })),
          FavoritesBar()
        ],
      ),
    );
  }
}
