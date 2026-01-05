import 'package:dicionario_assurini/data/repositories/palavras_repository.dart';
import 'package:flutter/material.dart';
import 'palavra_page.dart';

class ListPalavraPage extends StatelessWidget {
  final int classificacaoId;
  final String classificacaoNome;
  const ListPalavraPage({
    super.key,
    required this.classificacaoId,
    required this.classificacaoNome,
  });

  @override
  Widget build(BuildContext context) {
    final repo = PalavrasRepository();
    final future = repo.getPalavraByClassificacao(classificacaoId);

    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
        title: Text(classificacaoNome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<Map<String, dynamic>>>(
              future: future,
              builder: (context, snapshot) {
                final count = snapshot.data?.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Text(
                    count == null
                        ? 'Carregando...'
                        : '$count palavras encontradas',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF654321),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  final palavras = snapshot.data ?? [];
                  if (palavras.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma palavra encontrada'),
                    );
                  }
                  return ListView.builder(
                    itemCount: palavras.length,
                    itemBuilder: (context, index) {
                      final assurini = palavras[index]['assurini'] ?? '';
                      final portugues = palavras[index]['portugues'] ?? '';
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) => PalavraPage(
                                        id: palavras[index]['id'] ?? 0,
                                        portugues:
                                            palavras[index]['portugues'] ?? '',
                                        assurini:
                                            palavras[index]['assurini'] ?? '',
                                      ),
                                ),
                              ),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF654321,
                                    ).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.translate,
                                    color: Color(0xFF654321),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    palavras[index]['portugues'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF424242),
                                    ),
                                  ),
                                ),
                                if (portugues.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      portugues,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF757575),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF9E9E9E),
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
