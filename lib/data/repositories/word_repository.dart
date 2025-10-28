import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class WordRepository {
  Future<Database> get _db async => AppDatabase.instance.database;

  Future<List<String>> getWordsByCategory(String categoria) async {
    final db = await _db;
    final res = await db.query(
      'words',
      columns: ['termo'],
      where: 'LOWER(categoria) = LOWER(?)',
      whereArgs: [categoria],
      orderBy: 'termo COLLATE NOCASE ASC',
    );
    return res.map((e) => e['termo'] as String).toList();
  }

  Future<List<String>> searchWords(String query) async {
    if (query.trim().isEmpty) return [];
    final db = await _db;
    final res = await db.query(
      'words',
      columns: ['termo'],
      where: 'termo LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'termo COLLATE NOCASE ASC',
      limit: 50,
    );
    return res.map((e) => e['termo'] as String).toList();
  }

  Future<List<String>> getFavorites() async {
    final db = await _db;
    final res = await db.query(
      'words',
      columns: ['termo'],
      where: 'favorito = 1',
      orderBy: 'termo COLLATE NOCASE ASC',
    );
    return res.map((e) => e['termo'] as String).toList();
  }

  Future<bool> isFavorite(String termo) async {
    final db = await _db;
    final res = await db.query(
      'words',
      columns: ['favorito'],
      where: 'termo = ?',
      whereArgs: [termo],
      limit: 1,
    );
    if (res.isEmpty) return false;
    return (res.first['favorito'] as int? ?? 0) == 1;
  }

  Future<void> toggleFavorite(String termo) async {
    final db = await _db;
    final fav = await isFavorite(termo);
    await db.update(
      'words',
      {'favorito': fav ? 0 : 1},
      where: 'termo = ?',
      whereArgs: [termo],
    );
  }
}

