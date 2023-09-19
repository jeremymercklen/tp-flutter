import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CatsDatabase {
  static final CatsDatabase _instance = CatsDatabase._internal();

  factory CatsDatabase() => _instance;

  CatsDatabase._internal();

  late final Database database;

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE favorite(id TEXT, name TEXT, description TEXTE)');
  }

  open() async {
    database = await openDatabase(join(await getDatabasesPath(), 'favorite.db'),
        version: 1, onCreate: _onCreate);
  }
}
