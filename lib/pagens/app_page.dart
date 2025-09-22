import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';
import 'buscar_page.dart';
import 'favoritos_page.dart';
import 'categorias_page.dart';
import 'configuracoes_page.dart';
import 'home_content_page.dart'; // <- nova página para a Home

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _HomePageState();
}

class _HomePageState extends State<AppPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContentPage(), // <- nova tela de "Início"
    const BuscarPage(showBackButton: false),
    const CategoriasPage(showBackButton: false),
    const FavoritosPage(showBackButton: false),
    const ConfiguracoesPage(showBackButton: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Dicionário',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.primary,
        elevation: 0,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuração',
          ),
        ],
      ),
    );
  }
}
