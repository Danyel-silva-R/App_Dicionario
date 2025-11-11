import 'package:flutter/material.dart';

class AprendaPronunciaPage extends StatelessWidget {
  const AprendaPronunciaPage({super.key});

  static const Color bg = Color(0xFFF2E6D5);
  static const Color card = Color(0xFFF5D7BD);
  static const Color textDark = Color(0xFF3E2B22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: textDark,
        foregroundColor: Colors.white,
        title: const Text('Aprenda a Pronúncia'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Os sons e as letras do Asurini do Tocantins',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Os sons da língua dos Asurini do Tocantins são, como os da língua portuguesa, '
                'vogais e consoantes. As vogais são cinco — A, E, I, O e Y. As quatro primeiras '
                'têm sons semelhantes aos do português, mas o “Y” representa um som único, '
                'que não existe no português. Ele é uma vogal alta e não-arredondada, mais central '
                'que o “I”, aproximando-se do “A”.\n\n'
                'As consoantes também são similares às do português, porém a língua Asurini '
                'apresenta combinações sonoras próprias, que refletem o modo de falar e a tradição oral do povo. '
                'A escrita foi adaptada para registrar esses sons da forma mais próxima possível da fala indígena.\n\n'
                'Aprender a pronúncia correta é essencial para compreender o significado cultural '
                'e espiritual das palavras. A língua Asurini expressa, por meio de seus sons, a relação '
                'com a natureza, os costumes e a visão de mundo do povo.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: textDark, fontSize: 16, height: 1.4),
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Dica: ao ler cada palavra, tente observar como a sonoridade muda entre as vogais e consoantes. '
              'O “Y”, por exemplo, tem uma vibração mais centralizada e suave. Essa diferença sonora '
              'é uma das riquezas da língua Asurini.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Color(0xFF4A3A2D),
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
