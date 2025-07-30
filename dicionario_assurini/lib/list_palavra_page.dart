import 'package:flutter/material.dart';
import 'palavra_page.dart';

class ListPalavraPage extends StatelessWidget {
  final String categoria;

  const ListPalavraPage({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final palavras = _getPalavrasPorCategoria(categoria);

    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Text(
                '${palavras.length} palavras encontradas',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF654321),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: palavras.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => PalavraPage(palavra: palavras[index]),
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
                                color: const Color(0xFF654321).withOpacity(0.1),
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
                                palavras[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF424242),
                                ),
                              ),
                            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _getPalavrasPorCategoria(String categoria) {
    switch (categoria.toLowerCase()) {
      case 'natureza':
        return ['Árvore', 'Rio', 'Floresta', 'Pássaro', 'Folha'];
      case 'animais':
        return ['Onça', 'Macaco', 'Peixe', 'Cobra', 'Borboleta'];
      case 'alimentação':
        return ['Mandioca', 'Peixe', 'Banana', 'Açaí', 'Farinha'];
      case 'corpo humano':
        return ['Cabeça', 'Mão', 'Pé', 'Olho', 'Boca'];
      case 'vida cotidiana':
        return ['Casa', 'Fogo', 'Água', 'Roupa', 'Comida'];
      case 'família':
        return ['Pai', 'Mãe', 'Filho', 'Filha', 'Avó'];
      default:
        return ['Inclusão', 'Interface', 'Interação'];
    }
  }
}
