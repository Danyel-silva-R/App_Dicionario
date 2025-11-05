import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class PalavrasRepository {
  Future<Database> get _db async => AppDatabase.instance.database;

  Future<List<Map<String, dynamic>>> listClassificacoesWithCount() async {
    final db = await _db;
    return db.rawQuery('''
      SELECT c.id, c.nome, COUNT(p.id) AS total
      FROM Classificacao c
      LEFT JOIN PalavraAssurini p ON p.classificacao_id = c.id
      GROUP BY c.id, c.nome
      ORDER BY c.nome COLLATE NOCASE ASC
    ''');
  }

  Future<List<Map<String, dynamic>>> getPalavraByClassificacao(int classificacaoId) async {
    final db = await _db;
    final res = await db.query(
      'PalavraAssurini',
      columns: ['*'], 
      where: 'classificacao_id = ?',
      whereArgs: [classificacaoId],
      orderBy: 'portugues COLLATE NOCASE ASC',
    );
    return res; 
  }

  Future<List<Map<String, dynamic>>> searchPalavras(String query) async {
    final q = query.trim();
    if (q.isEmpty) return [];
    final db = await _db;
    final res = await db.query(
      'PalavraAssurini',
      columns: ['*'], 
      where: 'assurini LIKE ? OR portugues LIKE ?',
      whereArgs: ['%$q%', '%$q%'],
      orderBy: 'assurini COLLATE NOCASE ASC',
      limit: 100,
    );
    return res;
  }
}
