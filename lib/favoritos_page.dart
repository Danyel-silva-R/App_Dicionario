import 'package:flutter/material.dart';
import 'palavra_page.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({super.key, this.showBackButton = true});

  final bool showBackButton;
  final List<String> favoritos = const ['Inclusão', 'Empatia'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        automaticallyImplyLeading: showBackButton,
      ),
      body:
          favoritos.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favoritos.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => PalavraPage(palavra: favoritos[index]),
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
              ),
    );
  }
}
