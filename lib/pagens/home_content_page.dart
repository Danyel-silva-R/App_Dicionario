import 'package:dicionario_assurini/componetes/cad_cartegoria.dart';
import 'package:dicionario_assurini/componetes/card_slide.dart';
import 'package:dicionario_assurini/pagens/origem_page.dart';
import 'package:flutter/material.dart';
import 'package:dicionario_assurini/theme/theme.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final _images = const [
    'assets/images/aldeia.png',
    'assets/images/Arte_indigena1.png',
    'assets/images/escola.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppColors.primary,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    const Text(
                      'ORIGEM DA LÍNGUA ASURINI',
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    AutoCarousel(
                      imagePaths: _images,
                      height: 200,
                      interval: Duration(seconds: 3),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrigemLinguaPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Saiba Mais',
                          style: TextStyle(
                            color: AppColors.onPrimary,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            const CadCategoria(
              nomeCad: "O PROVO ASSURINÍ TROCARÁ",
              imagenRela: 'assets/images/oca.png',
            ),
            const CadCategoria(
              nomeCad: "APRENDA A PRONÚNCIA DAS PALAVRAS",
              imagenRela: 'assets/images/livro.png',
            ),
          ],
        ),
      ),
    );
  }
}
