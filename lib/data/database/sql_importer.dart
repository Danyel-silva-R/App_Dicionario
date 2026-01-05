import 'package:sqflite/sqflite.dart';

/// Executa um script SQL grande (com múltiplas sentenças) em SQLite.
///
/// - Ignora linhas de comentário começadas com `--`.
/// - Remove `BEGIN TRANSACTION;` e `COMMIT;` do script (usamos transação própria).
/// - Ignora PRAGMAs e CREATE TABLEs (usamos o schema criado pelo Dart).
/// - Trata aspas simples, evitando quebrar sentenças no `;` dentro de strings.
/// - Desabilita foreign keys durante a importação para evitar erros de ordem.
Future<void> executeSqlScript(Database db, String sql) async {
  // Desabilita foreign keys durante a importação
  await db.execute('PRAGMA foreign_keys = OFF');
  
  // Normaliza quebras de linha e remove BOM/whitespace irrelevante
  final source = sql.replaceAll('\r', '');

  final statements = <String>[];
  final buffer = StringBuffer();
  var inString = false; // dentro de aspas simples

  void pushStatement() {
    var s = buffer.toString().trim();
    buffer.clear();
    if (s.isEmpty) return;
    final upper = s.toUpperCase();
    
    // Ignorar controle de transação, PRAGMAs e CREATE TABLE do arquivo
    if (upper == 'BEGIN TRANSACTION' || 
        upper == 'COMMIT' || 
        upper == 'END' ||
        upper.startsWith('PRAGMA') ||
        upper.startsWith('CREATE TABLE')) {
      return;
    }
    
    // Corrigir INSERTs de PalavraAssurini para especificar as colunas
    // O SQL do arquivo tem: INSERT INTO "PalavraAssurini" VALUES (id, assurini, portugues, classificacao_id)
    // Mas a tabela Dart tem: id, favorito, portugues, assurini, classificacao_id
    if (upper.startsWith('INSERT INTO "PALAVRAASSURINI" VALUES')) {
      s = s.replaceFirst(
        RegExp(r'INSERT INTO "PalavraAssurini" VALUES', caseSensitive: false),
        'INSERT INTO "PalavraAssurini" (id, assurini, portugues, classificacao_id) VALUES',
      );
    }
    
    // Corrigir INSERTs de Exemplo para especificar as colunas
    if (upper.startsWith('INSERT INTO "EXEMPLO" VALUES')) {
      s = s.replaceFirst(
        RegExp(r'INSERT INTO "Exemplo" VALUES', caseSensitive: false),
        'INSERT INTO "Exemplo" (id, palavra_assurini_id, frase_assurini, traducao) VALUES',
      );
    }
    
    statements.add(s);
  }

  for (final line in source.split('\n')) {
    final trimmed = line.trim();
    if (!inString && trimmed.startsWith('--')) {
      continue; // ignora comentários
    }

    for (var i = 0; i < line.length; i++) {
      final ch = line[i];
      if (ch == '\'') {
        // Toggle somente se não for escapado por outra aspa simples duplicada
        final nextIsQuote = i + 1 < line.length && line[i + 1] == '\'';
        if (nextIsQuote) {
          // Aspa escapada ('') → adiciona ambas e avança
          buffer.write("''");
          i++; // salta próximo
          continue;
        } else {
          inString = !inString;
          buffer.write(ch);
          continue;
        }
      }
      if (ch == ';' && !inString) {
        pushStatement();
      } else {
        buffer.write(ch);
      }
    }
    buffer.write('\n');
  }
  // Última sentença (se não terminada com ';')
  if (buffer.isNotEmpty) pushStatement();

  if (statements.isEmpty) {
    await db.execute('PRAGMA foreign_keys = ON');
    return;
  }

  // Reordenar statements: primeiro Classificacao, depois PalavraAssurini, por último Exemplo
  final classificacaoStmts = <String>[];
  final palavraStmts = <String>[];
  final exemploStmts = <String>[];
  final outrosStmts = <String>[];
  
  for (final stmt in statements) {
    final upper = stmt.toUpperCase();
    if (upper.contains('"CLASSIFICACAO"')) {
      classificacaoStmts.add(stmt);
    } else if (upper.contains('"PALAVRAASSURINI"')) {
      palavraStmts.add(stmt);
    } else if (upper.contains('"EXEMPLO"')) {
      exemploStmts.add(stmt);
    } else {
      outrosStmts.add(stmt);
    }
  }
  
  final orderedStmts = [
    ...outrosStmts,
    ...classificacaoStmts,
    ...palavraStmts,
    ...exemploStmts,
  ];

  var errorCount = 0;
  await db.transaction((txn) async {
    for (final stmt in orderedStmts) {
      try {
        await txn.execute(stmt);
      } catch (e) {
        errorCount++;
        if (errorCount <= 5) {
          print('⚠️ Erro SQL: ${stmt.substring(0, stmt.length > 80 ? 80 : stmt.length)}...');
        }
      }
    }
  });

  // Reabilita foreign keys após a importação
  await db.execute('PRAGMA foreign_keys = ON');
  print('✅ Script SQL: ${orderedStmts.length} comandos processados, $errorCount erros');
}

