import 'package:flutter/material.dart';

class AprendaPronunciaTextoPage extends StatelessWidget {
  const AprendaPronunciaTextoPage({super.key});

  static const Color bg = Color(0xFFF2E6D5);
  static const Color card = Color(0xFFF5D7BD);
  static const Color textDark = Color(0xFF3E2B22);
  static const Color accent = Color(0xFFA5673B);

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
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Como pronunciar as palavras Asurini'),
            _paragraph(
              'A língua Asurini do Tocantins apresenta sons próprios que a diferenciam '
              'do português. A pronúncia é suave e ritmada, valorizando cada vogal e consoante. '
              'O aprendizado da pronúncia é uma forma de preservar o som e o significado das palavras transmitidas pelos anciãos.',
            ),

            const SizedBox(height: 16),
            _title('As vogais'),
            _paragraph(
              'As vogais principais são A, E, I, O e Y. As quatro primeiras são semelhantes às do português, '
              'mas o “Y” representa um som intermediário entre o “I” e o “U”, feito com os lábios relaxados e a língua alta. '
              'É um som muito comum nas palavras da língua Asurini.',
            ),

            const SizedBox(height: 16),
            _title('As consoantes'),
            _paragraph(
              'As consoantes são geralmente pronunciadas de forma clara e breve. '
              'O “R” pode ter som vibrante (como no português) e o “NG” representa um som nasal, '
              'como em “n’anga”. O “W” e o “K” também aparecem com frequência, e o “H” indica uma leve aspiração.',
            ),

            const SizedBox(height: 16),
            _title('Ritmo e entonação'),
            _paragraph(
              'A fala Asurini tem ritmo constante e melodioso. '
              'Cada sílaba deve ser pronunciada sem omissões, e as palavras costumam ter entonações suaves. '
              'É importante respeitar o tempo de cada som para manter o significado correto.',
            ),

            const SizedBox(height: 16),
            _title('Nasais e acentos'),
            _paragraph(
              'Algumas palavras apresentam sons nasais indicados pelo uso de “˜” ou pelo dígrafo “NG”. '
              'Esses sons devem ser feitos com o ar saindo parcialmente pelo nariz. '
              'Os acentos ajudam a indicar a sílaba mais forte da palavra, como em “ryirõna”.',
            ),

            const SizedBox(height: 16),
            _title('Importância da pronúncia'),
            _paragraph(
              'A pronúncia correta preserva o sentido e a força cultural das palavras. '
              'Aprender a falar de forma próxima à dos falantes nativos é um ato de respeito e valorização '
              'da língua Asurini, que representa a identidade do povo e a sua conexão com o território.',
            ),

            const SizedBox(height: 24),
            Center(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: accent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      t,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: textDark,
      ),
    ),
  );

  Widget _paragraph(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      t,
      textAlign: TextAlign.justify,
      style: const TextStyle(fontSize: 15, color: textDark, height: 1.45),
    ),
  );
}
