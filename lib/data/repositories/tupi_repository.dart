import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class TupiRepository {
  Future<Database> get _db async => AppDatabase.instance.database;

  Future<List<Map<String, dynamic>>> listClassificacoesWithCount() async {
    final db = await _db;
    return db.rawQuery('''
      SELECT c.id, c.nome, COUNT(p.id) AS total
      FROM Classificacao c
      LEFT JOIN PalavraTupi p ON p.classificacao_id = c.id
      GROUP BY c.id, c.nome
      ORDER BY c.nome COLLATE NOCASE ASC
    ''');
  }

  Future<List<String>> getTupiByClassificacao(int classificacaoId) async {
    final db = await _db;
    final res = await db.query(
      'PalavraTupi',
      columns: ['tupi'],
      where: 'classificacao_id = ?',
      whereArgs: [classificacaoId],
      orderBy: 'tupi COLLATE NOCASE ASC',
    );
    return res.map((e) => (e['tupi'] as String?) ?? '').where((s) => s.isNotEmpty).toList();
  }

  Future<List<Map<String, String>>> getPalavrasPorClassificacao(int classificacaoId) async {
    final db = await _db;
    final res = await db.query(
      'PalavraTupi',
      columns: ['tupi', 'portugues'],
      where: 'classificacao_id = ?',
      whereArgs: [classificacaoId],
      orderBy: 'tupi COLLATE NOCASE ASC',
    );
    return res
        .map((e) => {
              'tupi': (e['tupi'] as String?) ?? '',
              'portugues': (e['portugues'] as String?) ?? '',
            })
        .where((m) => (m['tupi']?.isNotEmpty ?? false))
        .toList();
  }

  Future<List<Map<String, String>>> searchPalavras(String query) async {
    final q = query.trim();
    if (q.isEmpty) return [];
    final db = await _db;
    final res = await db.query(
      'PalavraTupi',
      columns: ['tupi', 'portugues'],
      where: 'tupi LIKE ? OR portugues LIKE ?',
      whereArgs: ['%$q%', '%$q%'],
      orderBy: 'tupi COLLATE NOCASE ASC',
      limit: 100,
    );
    return res.map((e) => {
          'tupi': (e['tupi'] as String?) ?? '',
          'portugues': (e['portugues'] as String?) ?? '',
        }).toList();
  }

  Future<Map<String, dynamic>?> getDetalhePorTupi(String tupi) async {
    final db = await _db;
    final res = await db.query(
      'PalavraTupi',
      columns: [
        'id',
        'tupi',
        'portugues',
        'pronuncia',
        'audio_path',
        'imagem_path',
      ],
      where: 'LOWER(tupi) = LOWER(?)',
      whereArgs: [tupi],
      limit: 1,
    );
    if (res.isEmpty) return null;
    final row = res.first;
    final id = row['id'] as int?;
    List<Map<String, String>> exemplos = [];
    if (id != null) {
      final ex = await db.query(
        'Exemplo',
        columns: ['frase_tupi', 'traducao'],
        where: 'palavra_tupi_id = ?',
        whereArgs: [id],
        orderBy: 'id ASC',
        limit: 10,
      );
      exemplos = ex
          .map((e) => {
                'frase_tupi': (e['frase_tupi'] as String?) ?? '',
                'traducao': (e['traducao'] as String?) ?? '',
              })
          .toList();
    }
    return {
      'tupi': (row['tupi'] as String?) ?? tupi,
      'portugues': (row['portugues'] as String?) ?? '',
      'pronuncia': (row['pronuncia'] as String?) ?? '',
      'audio_path': (row['audio_path'] as String?) ?? '',
      'imagem_path': (row['imagem_path'] as String?) ?? '',
      'exemplos': exemplos,
    };
  }
}
