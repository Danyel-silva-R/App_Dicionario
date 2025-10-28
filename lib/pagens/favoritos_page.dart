import 'package:flutter/material.dart';
import 'palavra_page.dart';
import 'package:dicionario_assurini/data/repositories/word_repository.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key, this.showBackButton = true});

  final bool showBackButton;
  
  List<Widget> _buildEmpty() => const [
        Icon(
          Icons.favorite_border,
          size: 80,
          color: Color(0xFF9E9E9E),
        ),
        SizedBox(height: 16),
        Text(
          'Nenhum favorito ainda',
          style: TextStyle(fontSize: 18, color: Color(0xFF9E9E9E)),
        ),
        SizedBox(height: 8),
        Text(
          'Adicione palavras aos favoritos\npara vê-las aqui',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Color(0xFFBDBDBD)),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final repo = WordRepository();
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      body: FutureBuilder<List<String>>(
        future: repo.getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar favoritos: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            );
          }
          final favoritos = snapshot.data ?? [];
          if (favoritos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildEmpty(),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoritos.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PalavraPage(palavra: favoritos[index]),
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
                        Expanded(
                          child: Text(
                            favoritos[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF424242),
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 20,
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
    );
  }
}
