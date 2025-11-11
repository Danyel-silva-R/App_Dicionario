import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';
import 'buscar_page.dart';
import 'favoritos_page.dart';
import 'categorias_page.dart';
import 'configuracoes_page.dart';
import 'home_content_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _HomePageState();
}

class _HomePageState extends State<AppPage> {
  int _selectedIndex = 0;

  // Crie uma GlobalKey para a FavoritosPage
  final GlobalKey<FavoritosPageState> _favoritesKey = GlobalKey();

  late final List<Widget> _pages; // Mude para late final

  @override
  void initState() {
    super.initState();
    // Inicialize a lista _pages no initState, usando a chave
    _pages = [
      const HomeContentPage(),
      const BuscarPage(showBackButton: false),
      const CategoriasPage(showBackButton: false),
      // Atribua a chave à FavoritosPage
      FavoritosPage(key: _favoritesKey, showBackButton: false),
      const ConfiguracoesPage(showBackButton: false),
    ];
  }

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
        backgroundColor: AppColors.primary,
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
          if (index == 3) {
            _favoritesKey.currentState?.loadFavorites();
          }
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
