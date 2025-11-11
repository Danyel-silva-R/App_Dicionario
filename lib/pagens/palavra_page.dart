//import 'package:dicionario_assurini/data/repositories/palavras_repository.dart';
import 'package:dicionario_assurini/data/repositories/palavras_repository.dart';
import 'package:dicionario_assurini/pagens/exemplos_builder.dart';
import 'package:flutter/material.dart';

class PalavraPage extends StatefulWidget {
  final int id;
  final String portugues;
  final String assurini;

  const PalavraPage({
    super.key,
    required this.portugues,
    required this.assurini,
    required this.id,
  });

  @override
  State<PalavraPage> createState() => _PalavraPageState();
}

class _PalavraPageState extends State<PalavraPage> {
  bool isFavorite = false;
  final _repo = PalavrasRepository();

  @override
  void initState() {
    super.initState();
    _loadFavorite();
  }

  Future<void> _loadFavorite() async {
    try {
      final fav = await _repo.isFavorite(widget.id);
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
              await _repo.toggleFavorite(widget.id);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
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
                      widget.assurini,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF654321),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Em Português: ${widget.portugues}',
                      style: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
                    ),
                    /* O app nao é pra ter definição
                    const SizedBox(height: 16),
                    const Text(
                      'Definição:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Esta é a definição da palavra "${widget.portugues}". Aqui seria mostrado o significado completo da palavra na língua Assurini, incluindo contexto cultural e exemplos de uso.',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF424242),
                        height: 1.5,
                      ),
                    ),
                    */
                  ],
                ),
              ),
              const SizedBox(height: 20),

              BuildExemplosCards(id: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}
