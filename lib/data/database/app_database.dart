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

    return openDatabase(
      path,
      version: 3,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE words (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            termo TEXT UNIQUE NOT NULL,
            categoria TEXT NOT NULL,
            definicao TEXT,
            favorito INTEGER NOT NULL DEFAULT 0
          )
        ''');

        final batch = db.batch();
        void add(String termo, String categoria) {
          batch.insert(
            'words',
            {
              'termo': termo,
              'categoria': categoria,
              'definicao': 'Definição de $termo (exemplo).',
              'favorito': 0,
            },
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );
        }

        for (final t in ['Árvore', 'Rio', 'Floresta', 'Pássaro', 'Folha']) {
          add(t, 'Natureza');
        }
        for (final t in ['Onça', 'Macaco', 'Peixe', 'Cobra', 'Borboleta']) {
          add(t, 'Animais');
        }
        for (final t in ['Mandioca', 'Milho', 'Banana', 'Açaí', 'Farinha']) {
          add(t, 'Alimentação');
        }
        for (final t in ['Cabeça', 'Mão', 'Pé', 'Olho', 'Boca']) {
          add(t, 'Corpo humano');
        }
        for (final t in ['Casa', 'Fogo', 'Água', 'Roupa', 'Comida']) {
          add(t, 'Vida cotidiana');
        }
        for (final t in ['Pai', 'Mãe', 'Filho', 'Filha', 'Avó']) {
          add(t, 'Família');
        }

        await batch.commit(noResult: true);

        await _createRequestedSchema(db);
        await _backfillFromWords(db);
        await _tryImportInitialSql(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await _createRequestedSchema(db);
          await _backfillFromWords(db);
          await _tryImportInitialSql(db);
        }
      },
    );
  }

  Future<void> _createRequestedSchema(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Classificacao (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS PalavraTupi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tupi TEXT NOT NULL,
        pronuncia TEXT,
        portugues TEXT NOT NULL,
        audio_path TEXT,
        imagem_path TEXT,
        classificacao_id INTEGER NOT NULL,
        FOREIGN KEY (classificacao_id) REFERENCES Classificacao(id)
          ON DELETE RESTRICT ON UPDATE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS Exemplo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        palavra_tupi_id INTEGER NOT NULL,
        frase_tupi TEXT NOT NULL,
        traducao TEXT NOT NULL,
        FOREIGN KEY (palavra_tupi_id) REFERENCES PalavraTupi(id)
          ON DELETE CASCADE ON UPDATE CASCADE
      )
    ''');

    final rows = await db.query('Classificacao', columns: ['id', 'nome']);
    final existing = {
      for (final e in rows)
        ((e['nome'] as String?)?.toLowerCase() ?? ''): e['id'] as int
    };
    const wanted = [
      'sem_classificacao',
      'natureza',
      'animais',
      'alimentação',
      'corpo humano',
      'vida cotidiana',
      'família',
    ];
    for (final nome in wanted) {
      if (!existing.containsKey(nome)) {
        await db.insert('Classificacao', {'nome': nome});
      }
    }
  }

  Future<void> _backfillFromWords(Database db) async {
    final tupiCount = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(1) FROM PalavraTupi'),
    );
    if ((tupiCount ?? 0) > 0) return;

    final classes = await db.query('Classificacao', columns: ['id', 'nome']);
    final classMap = <String, int>{
      for (final e in classes)
        ((e['nome'] as String?)?.toLowerCase() ?? ''): (e['id'] as int)
    };

    final words = await db.query('words', columns: ['termo', 'categoria', 'definicao']);
    final insertBatch = db.batch();
    for (final w in words) {
      final termo = (w['termo'] as String?)?.trim();
      if (termo == null || termo.isEmpty) continue;
      final categoria = ((w['categoria'] as String?) ?? '').toLowerCase().trim();
      final definicao = (w['definicao'] as String?)?.trim();

      String key = categoria;
      if (key == 'alimentacao') key = 'alimentação';
      if (key == 'familia') key = 'família';

      final classId = classMap[key] ?? classMap['sem_classificacao'];
      if (classId == null) continue;

      insertBatch.insert(
        'PalavraTupi',
        {
          'tupi': termo,
          'portugues': definicao?.isNotEmpty == true ? definicao! : termo,
          'classificacao_id': classId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await insertBatch.commit(noResult: true);
  }

  Future<void> _tryImportInitialSql(Database db) async {
    try {
      final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(1) FROM PalavraTupi'),
      );
      if ((count ?? 0) > 0) return;

      final sql = await rootBundle.loadString('assets/sql/initial_data.sql');
      await executeSqlScript(db, sql);
    } catch (_) {
      // Se o asset não existir ou falhar, apenas ignora
    }
  }
}
