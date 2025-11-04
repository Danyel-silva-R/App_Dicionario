import 'package:flutter/material.dart';
import 'list_palavra_page.dart';
import 'package:dicionario_assurini/data/repositories/tupi_repository.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  // Versão segura para nomes de arquivos com acentos
  String? _iconFor2(String nome) {
    final key = nome.toLowerCase();
    if (key.contains('natureza')) return 'assets/images/folha.png';
    if (key.contains('animal')) return 'assets/images/pata.png';
    if (key.contains('alimenta') || key.contains('comida')) {
      return 'assets/images/comida.png';
    }
    if (key.contains('corpo')) return 'assets/images/mão.png';
    if (key.contains('vida')) return 'assets/images/oca2.png';
    if (key.contains('fam')) return 'assets/images/pessoas.png';
    if (key.contains('cultura')) return 'assets/images/fogo.png';
    if (key.contains('express')) return 'assets/images/convesas.png';
    if (key.contains('objeto')) return 'assets/images/vaso.png';
    if (key.contains('pessoa')) return 'assets/images/pessoas.png';
    return null;
  }

  String _displayName(String nome) {
    if (nome.isEmpty) return nome;
    return nome[0].toUpperCase() + nome.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final repo = TupiRepository();
    return Scaffold(
      backgroundColor: const Color(0xFFF3EADF),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(
                'Escolha uma Categoria',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF654321),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: repo.listClassificacoesWithCount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Erro ao carregar categorias: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    final categorias = snapshot.data ?? [];
                    if (categorias.isEmpty) {
                      return const Center(
                        child: Text('Nenhuma categoria encontrada'),
                      );
                    }
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.maxWidth;
                        final isCompact = width < 360;
                        final isWide = width > 600;
                        final spacing = isCompact ? 8.0 : 16.0;
                        final maxExtent = isWide ? 240.0 : 200.0;
                        final aspectRatio = isWide ? 1.1 : 0.9;

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: maxExtent,
                                crossAxisSpacing: spacing,
                                mainAxisSpacing: spacing,
                                childAspectRatio: aspectRatio,
                              ),
                          itemCount: categorias.length,
                          itemBuilder: (context, index) {
                            final c = categorias[index];
                            final iconPath = _iconFor2('${c['nome']}');
                            return _buildCategoryCard(
                              context,
                              id: c['id'] as int,
                              nome: _displayName('${c['nome']}'),
                              total: (c['total'] as int?) ?? 0,
                              iconPath: iconPath,
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
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required int id,
    required String nome,
    required int total,
    String? iconPath,
  }) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ListPalavraPage(
                    classificacaoId: id,
                    classificacaoNome: nome,
                  ),
            ),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child:
                      iconPath == null
                          ? const ColoredBox(
                            color: Color(0xFFF5F5F5),
                            child: Center(
                              child: Icon(
                                Icons.category,
                                color: Color(0xFFBDBDBD),
                              ),
                            ),
                          )
                          : Image.asset(
                            iconPath,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const ColoredBox(
                                color: Color(0xFFF5F5F5),
                                child: Center(
                                  child: Icon(
                                    Icons.photo,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                ),
                              );
                            },
                          ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF424242),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '$total palavras',
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
