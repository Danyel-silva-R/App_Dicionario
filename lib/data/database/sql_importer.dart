import 'package:sqflite/sqflite.dart';

/// Executa um script SQL grande (com múltiplas sentenças) em SQLite.
///
/// - Ignora linhas de comentário começadas com `--`.
/// - Remove `BEGIN TRANSACTION;` e `COMMIT;` do script (usamos transação própria).
/// - Trata aspas simples, evitando quebrar sentenças no `;` dentro de strings.
Future<void> executeSqlScript(Database db, String sql) async {
  // Normaliza quebras de linha e remove BOM/whitespace irrelevante
  final source = sql.replaceAll('\r', '');

  final statements = <String>[];
  final buffer = StringBuffer();
  var inString = false; // dentro de aspas simples

  void pushStatement() {
    final s = buffer.toString().trim();
    buffer.clear();
    if (s.isEmpty) return;
    final upper = s.toUpperCase();
    if (upper == 'BEGIN TRANSACTION' || upper == 'COMMIT' || upper == 'END') {
      return; // ignorar controle de transação do arquivo
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

  if (statements.isEmpty) return;

  await db.transaction((txn) async {
    for (final stmt in statements) {
      try {
        await txn.execute(stmt);
      } catch (_) {
        // Ignora erros individuais para processar o máximo possível
      }
    }
  });
}

