import 'package:dicionario_assurini/componetes/cad_cartegoria.dart';
import 'package:dicionario_assurini/pagens/aprenda_page.dart';
import 'package:dicionario_assurini/pagens/origem_page.dart';
import 'package:dicionario_assurini/pagens/provo_page.dart';
import 'package:flutter/material.dart';
import 'package:dicionario_assurini/theme/theme.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            CadCategoria(
              nomeCad: "APRENDA A PRONÚNCIA DAS PALAVRAS",
              imagenRela: 'assets/images/livro.png',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AprendaPronunciaPage(),
                  ),
                );
              },
            ),
            CadCategoria(
              nomeCad: "O PROVO ASURINI TROCARÁ",
              imagenRela: 'assets/images/oca.png',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PovoAsuriniPage(),
                  ),
                );
              },
            ),
            CadCategoria(
              nomeCad: "ORIGEM DA LÍNGUA ASURINI",
              imagenRela: 'assets/images/origempage.png',
              tap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrigemLinguaPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
