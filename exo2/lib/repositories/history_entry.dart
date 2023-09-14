import 'package:sqflite/sqflite.dart';
import '../database.dart';
import '../model/HistoryEntry.dart';

class HistoryEntryRepository {
  final _tableOperation = 'entry';
  final Database _db = HistoryDatabase().database;

  insert(HistoryEntry entry) async {
    await _db.insert(_tableOperation, entry.toMap());
  }

  Future<List<HistoryEntry>> getAll() async {
    List<Map<String, dynamic>> maps =
        await _db.query(_tableOperation, orderBy: 'date DESC');
    return maps.map((e) => HistoryEntry.fromMap(e)).toList();
  }
}
