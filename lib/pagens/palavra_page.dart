import 'package:flutter/material.dart';
import 'package:dicionario_assurini/data/repositories/word_repository.dart';
import 'package:dicionario_assurini/data/repositories/tupi_repository.dart';

class PalavraPage extends StatefulWidget {
  final String palavra;

  const PalavraPage({super.key, required this.palavra});

  @override
  State<PalavraPage> createState() => _PalavraPageState();
}

class _PalavraPageState extends State<PalavraPage> {
  bool isFavorite = false;
  final _repo = WordRepository();
  final _tupiRepo = TupiRepository();

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    try {
      final fav = await _repo.isFavorite(widget.palavra);
      if (mounted) setState(() => isFavorite = fav);
    } catch (_) {
      // silenciosamente ignora para não quebrar a UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () async {
              await _repo.toggleFavorite(widget.palavra);
              await _loadFavorite();
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? 'Adicionado aos favoritos'
                        : 'Removido dos favoritos',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _tupiRepo.getDetalhePorTupi(widget.palavra),
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
            final data = snapshot.data;
            final traducao = (data?['portugues'] as String?)?.trim();
            final pronuncia = (data?['pronuncia'] as String?)?.trim();
            final exemplos = (data?['exemplos'] as List?)
                    ?.whereType<Map<String, String>>()
                    .toList() ??
                [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card principal da palavra
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.palavra,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF654321),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Palavra em Assurini',
                        style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                      ),
                      if (pronuncia != null && pronuncia.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Pronúncia: $pronuncia',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6D6D6D),
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),
                      const Text(
                        'Tradução (Português):',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF424242),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        (traducao != null && traducao.isNotEmpty)
                            ? traducao
                            : 'Tradução não encontrada.',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF424242),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Card de exemplo de uso
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: Color(0xFF4CAF50),
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Exemplo de uso:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (exemplos.isNotEmpty) ...[
                        Text(
                          exemplos.first['frase_tupi'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2E7D32),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          exemplos.first['traducao'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Sem exemplos cadastrados para "${widget.palavra}".',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2E7D32),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
