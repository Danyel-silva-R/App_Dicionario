import 'package:flutter/material.dart';
import 'package:dicionario_assurini/theme/theme.dart';

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Palavra do Dia
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(10),
                ),
                // A Column é o filho principal, pois o layout é vertical
                child: Column(
                  // Alinha os filhos da Column à esquerda
                  children: [
                    // O primeiro Text é o título
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Text(
                        'Palavra do dia',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // A Row para a imagem e o texto restante
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // A Column para os dois textos restantes
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Kurumi',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('Menino', style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),
                          // A imagem no canto direito
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Image.asset(
                              'assets/images/logo_splash.png',
                              width: 90, // Ajuste o tamanho da imagem
                              height: 90,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Explorar por Categoria
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.category, color: AppColors.primary),
                  title: const Text("Explorar por Categoria"),
                  onTap: () {
                    // ação ao clicar
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Provérbios
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.menu_book,
                    color: AppColors.primary,
                  ),
                  title: const Text("Explorar Provérbios"),
                  onTap: () {
                    // ação ao clicar
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Expressões do Cotidiano
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.chat, color: AppColors.primary),
                  title: const Text("Expressões do Cotidiano"),
                  onTap: () {
                    // ação ao clicar
                  },
                ),
              ),
              const SizedBox(height: 12),

              // Origem da Língua
              Card(
                color: AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.history_edu,
                    color: AppColors.primary,
                  ),
                  title: const Text("Origem da Língua Asurini"),
                  onTap: () {
                    // ação ao clicar
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
