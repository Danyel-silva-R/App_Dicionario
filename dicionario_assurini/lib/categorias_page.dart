import 'package:flutter/material.dart';
import 'list_palavra_page.dart';

class CategoriasPage extends StatelessWidget {
  const CategoriasPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  final List<Map<String, dynamic>> categorias = const [
    {
      'nome': 'Natureza',
      'palavras': 32,
      'icon': Icons.eco,
      'color': Color(0xFF4CAF50),
    },
    {
      'nome': 'Animais',
      'palavras': 27,
      'icon': Icons.pets,
      'color': Color(0xFFFF9800),
    },
    {
      'nome': 'Alimentação',
      'palavras': 16,
      'icon': Icons.restaurant,
      'color': Color(0xFF2196F3),
    },
    {
      'nome': 'Corpo humano',
      'palavras': 18,
      'icon': Icons.accessibility,
      'color': Color(0xFFFF5722),
    },
    {
      'nome': 'Vida cotidiana',
      'palavras': 23,
      'icon': Icons.home,
      'color': Color(0xFF8BC34A),
    },
    {
      'nome': 'Família',
      'palavras': 23,
      'icon': Icons.family_restroom,
      'color': Color(0xFFE91E63),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EADF),
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
      body: Padding(
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  final categoria = categorias[index];
                  return _buildCategoryCard(context, categoria);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    Map<String, dynamic> categoria,
  ) {
    return InkWell(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ListPalavraPage(categoria: categoria['nome']),
            ),
          ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: categoria['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  categoria['icon'],
                  size: 32,
                  color: categoria['color'],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                categoria['nome'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF424242),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                '${categoria['palavras']} palavras',
                style: const TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
