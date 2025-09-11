import 'package:flutter/material.dart';
import 'buscar_page.dart';
import 'favoritos_page.dart';
import 'categorias_page.dart';
import 'configuracoes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const BuscarPage(showBackButton: false),
    const CategoriasPage(showBackButton: false),
    const FavoritosPage(showBackButton: false),
    const ConfiguracoesPage(showBackButton: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Dicionário',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF654321),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF654321),
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
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Palavra do Dia Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFFF9500),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Palavra do Dia',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Kurumi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Menino',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuA3rD1RXiWEAon2D3DrpUsaEMYVWUivRE5rwgfFv2HZc2o_aOW-ZSzcv4rY5-Qoi_CXuraR8FzWSM8NMRHJXKwO3hcfaXvhlSGW0gXEs47m_sYVXZ3Pa5WyG-V21Ax_8klgf_qd61GwipnPN_Hqkf9rpX6Jp06HS7BQEcpsIxYb_jdvwQ2wMf7tYiGwvqZL53-NqQEfcSNp1WP1upK5mst5SiEJfcfLAQzqw3kyyekfrIlu691EcBq8wVONzG6T0YwBKxhfJwe__zpJ',
                      width: 96,
                      height: 96,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.orange.withOpacity(0.3),
                          ),
                          child: const Icon(
                            Icons.child_care,
                            size: 48,
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Categoria Buttons
          _buildCategoryButton(
            context,
            'APRENDER POR CATEGORIA',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuBZyCR_3DZ6_5zaYnqy51jXluOToAGawcZgFGG2xQQTSgRQTvyjOkHWs1O_nQo2CHg9Uy3QbJIPcsPw1R3E8Mu6rfytGdm6dhMzSf-VL8aOH_BAqblp125QitBJr_Bo9w1xE0-Us8ZQPEqZ0LM6QSLuoFB61MTsWvJEBVhDoU3prhnvtOzdt5Eb0TMMtsFHvQS0pdZ0C0GYFP9wKFQC7P7vuoc_t9LxPZQ74lr4yhAjsUAD3riAzCslhkMI9gNiAr9qRT07BekCkJLt',
            const CategoriasPage(),
          ),
          const SizedBox(height: 16),

          _buildCategoryButton(
            context,
            'EXPLORAR PROVÉRBIOS',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuC4YuyGwctDg7nFMSFOqvAlQgMIS6V_7E6ams9auMZJqP_2NazaOThLMFjkwBb4FL7VHoOaALWbGlG6ZpbVgYM8xV6UJ6o03qs6p63P5yK2DerDFPno-JnkIEr7Z2lDltl1SPEEpWCfxmO7SEA6vkw0LYzJiXhb-N4fASCoNEe9p2ZpFqK1w2imFePGOWerdJdegVlJ-Bfp4KZswieLjnaZMn5Nn7X_WIezULfsGm5UWZErNkag41eWSRlosjPOse8nmJDSJPO16DrS',
            const CategoriasPage(),
          ),
          const SizedBox(height: 16),

          _buildCategoryButton(
            context,
            'EXPRESSÕES DO COTIDIANO',
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCrkTKeEe-xkX3ygvWdB-2rHffkQCGBndKJuNkiHTuMLqK9eG6s3CL3IRup_NEJwk3Dhcq7v7ZiQyULvyg7Bcxe_w2Qbo_CuuuGrZDphDfGc5Q129U-lTLqJejS2kSnMx2TiLBgKndpRjrhK_GR9z9eYFIKGNN8KZ2BYMiIKXMJyC85l95r_HAC2wc6xHMnp_sWl2mo-qVFEYKilew5-uMTQG2Af-JmEuH4DJWdqGmM4uh610OMSyraqumPhMhSSuMcq_qiOxIwNmbe',
            const CategoriasPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(
    BuildContext context,
    String label,
    String imageUrl,
    Widget page,
  ) {
    return InkWell(
      onTap:
          () =>
              Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFCC99),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.category,
                      size: 24,
                      color: const Color(0xFF8B4513),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
