import 'package:flutter/material.dart';

class SobreAppPage extends StatelessWidget {
  const SobreAppPage({super.key});

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
        title: const Text('Sobre o Aplicativo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title('Sobre o aplicativo'),
            _paragraphCard(
              '“Sé – Kó – Dicionário Asuriní”, é um aplicativo construído para apoiar o '
              'processo de ensino – aprendizagem e preservação da língua materna da '
              'etnia Asuriní do Trocará, comunidade indígena que vive na região '
              'Tocantina, no município de Tucuruí – Pará. O App reúne o vocabulário, '
              'expressões diárias, informações sobre a pronúncia das palavras e '
              'conteúdos culturais, facilitando o acesso à língua materna da etnia '
              'Asuriní Trocará para estudantes, professores e comunidade indígena e '
              'não indígena.',
            ),

            const SizedBox(height: 20),

            _title('Desenvolvimento'),
            _paragraphCard(
              'O aplicativo foi desenvolvido sob a orientação da Ma. Maria Sarmento '
              'Pereira – TAE IFPA e Me. Alex Oliveira – Professor Colaborador do IFPA, '
              'juntamente com os discentes do Curso de Ciência da Computação IFPA: '
              'Danyel da Silva Rodrigues, Roger Luan Guimarães Goltara, Gabriel da Silva '
              'e Bruno Nichael Farias David e Talia dos Santos – Curso Redes de '
              'Computadores. O projeto integra tecnologia, educação e preservação '
              'cultural, no intuito de valorizar e preservar a língua materna e a '
              'história do povo Asuriní do Trocará por meio de uma plataforma acessível '
              'e moderna.',
            ),

            const SizedBox(height: 20),

            _title('Agradecimentos'),
            _paragraphCard(
              'Agradecemos à comunidade Asuriní do Trocará pela parceria na construção '
              'deste aplicativo, ao IFPA - Edital 09/2024 - PROEX/PROEN/PROPPG – '
              'Diversidade e a todas as pessoas que contribuíram com pesquisas, registros '
              'e materiais que tornaram a construção deste aplicativo possível. '
              'Este aplicativo é um convite ao respeito, ao aprendizado e à valorização '
              'da língua materna dos povos indígenas da Amazônia Paraense, aqui em '
              'especial a etnia Asuriní do Trocará.',
            ),

            const SizedBox(height: 30),

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
                onPressed: () => Navigator.pop(context),
                child: const Text('Voltar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* --- HELPERS DE UI --- */

  Widget _title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: textDark,
      ),
    ),
  );

  Widget _paragraphCard(String text) {
    return Container(
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 15, color: textDark, height: 1.45),
      ),
    );
  }
}
