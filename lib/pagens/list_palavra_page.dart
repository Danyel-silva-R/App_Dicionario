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
                      fontSize: 14,
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
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      final screenWidth = constraints.maxWidth;
                      final isCompact = screenWidth < 320;
                      final baseFontSize = screenWidth * 0.04;
                      final titleSize = (baseFontSize * 1.1).clamp(13.0, 18.0);
                      final subtitleSize = (baseFontSize * 0.9).clamp(11.0, 14.0);
                      
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
                                padding: EdgeInsets.all(isCompact ? 12 : 16),
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
                                      width: isCompact ? 32 : 40,
                                      height: isCompact ? 32 : 40,
                                      decoration: BoxDecoration(
                                        color: const Color(
                                          0xFF654321,
                                        ).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.translate,
                                        color: const Color(0xFF654321),
                                        size: isCompact ? 16 : 20,
                                      ),
                                    ),
                                    SizedBox(width: isCompact ? 10 : 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            assurini,
                                            style: TextStyle(
                                              fontSize: titleSize,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF654321),
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            portugues,
                                            style: TextStyle(
                                              fontSize: subtitleSize,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF757575),
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: const Color(0xFF9E9E9E),
                                      size: isCompact ? 14 : 16,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
