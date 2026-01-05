import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/services.dart' show rootBundle;
import 'sql_importer.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'dicionario_assurini.db');
    print('📂 Banco criado em: $path');

    return openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await _createSchema(db);
        await _tryImportInitialSql(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // Caso precise adicionar colunas ou tabelas no futuro
        if (oldVersion < newVersion) {
          await _createSchema(db);
        }
      },
    );
  }

  /// Cria as tabelas oficiais do banco.
  Future<void> _createSchema(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Classificacao (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL UNIQUE
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS PalavraAssurini (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        favorito INTEGER DEFAULT 0,
        portugues TEXT NOT NULL,
        assurini TEXT NOT NULL,
        classificacao_id INTEGER NOT NULL,
        FOREIGN KEY (classificacao_id) REFERENCES Classificacao(id)
          ON DELETE RESTRICT ON UPDATE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Exemplo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        palavra_assurini_id INTEGER NOT NULL,
        frase_assurini TEXT NOT NULL,
        traducao TEXT NOT NULL,
        FOREIGN KEY (palavra_assurini_id) REFERENCES PalavraAssurini(id)
          ON DELETE CASCADE ON UPDATE CASCADE
      );
    ''');
  }

  /// Tenta importar dados iniciais de um arquivo SQL.
  Future<void> _tryImportInitialSql(Database db) async {
    try {
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(1) FROM PalavraAssurini'),
      );
      if ((count ?? 0) > 0) {
        print('📚 Banco já possui $count palavras, pulando importação');
        return;
      }

      print('📥 Importando dados iniciais...');
      final sql = await rootBundle.loadString(
        'assets/sql/initial_data.sql',
      );
      await executeSqlScript(db, sql);
      
      // Verificar se a importação funcionou
      final newCount = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(1) FROM PalavraAssurini'),
      );
      print('📊 Importação concluída: $newCount palavras carregadas');
    } catch (e, st) {
      print('❌ Erro ao importar dados iniciais: $e\n$st');
    }
  }
}
