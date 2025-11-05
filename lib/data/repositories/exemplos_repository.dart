import 'package:sqflite/sqflite.dart';
import '../database/app_database.dart';

class ExemplosRepository {
  Future<Database> get _db async => AppDatabase.instance.database;

    // Retorna todos os exemplos, dado o ID de uma palavra
    Future<List<Map<String, dynamic>>> getExemplosByPalavraId(int palavraAssuriniId) async {
      final db = await _db;
      
      final res = await db.query(
        'Exemplo',
        columns: ['*'], 
        where: 'palavra_assurini_id = ?',
        whereArgs: [palavraAssuriniId],
        orderBy: 'frase_assurini COLLATE NOCASE ASC', 
      );
      return res; 
    }

}
