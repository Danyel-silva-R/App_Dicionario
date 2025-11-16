import 'package:flutter/material.dart';

class SobreAppPage extends StatelessWidget {
  const SobreAppPage({super.key});

  // Paleta alinhada com o restante do app
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
            _sectionTitle('Sobre o aplicativo'),
            _paragraphCard(
              '“Sé kó – Dicionário Asurini” é um aplicativo criado para apoiar a '
              'preservação e o ensino da Língua Asurini do Trocará, falada pelo povo '
              'indígena Asurini que vive na região do rio Tocantins, entre os municípios '
              'de Baião e Tucuruí, no Pará. O app reúne vocabulário, informações sobre a '
              'pronúncia e conteúdos culturais, facilitando o acesso à língua para '
              'estudantes, professores e membros da própria comunidade.',
            ),

            const SizedBox(height: 20),

            _sectionTitle('Desenvolvimento'),
            _paragraphCard(
              'O aplicativo foi desenvolvido por Danyel da Silva Rodrigues, '
              'Roger Luan Guimarães Goltara e Gabriel da Silva, alunos do curso de '
              'Ciência da Computação do IFPA – Campus Tucuruí, sob orientação do '
              'Professor Alex Oliveira e da Professora Maria Sarmento Viana. '
              'O projeto integra tecnologia, educação e preservação cultural, '
              'buscando valorizar a língua e a história do povo Asurini do Trocará por '
              'meio de uma plataforma acessível e moderna.',
            ),

            const SizedBox(height: 20),

            _sectionTitle('Referências bibliográficas'),
            _paragraphCard(
              'CABRAL, Ana Suelly Arruda Câmara; RODRIGUES, Ayron Dall’Igna. '
              'Dicionário da Língua Asuriní do Trocará do Tocantins – Português. '
              'Belém: UFPA/IFNOPAP; UnB/IL/LALI, 2003.',
            ),
            const SizedBox(height: 8),
            _paragraphCard(
              'VIANA, Jairson Monteiro Rodrigues. A escola e a prática do futebol por '
              'indígenas Asurini mulheres do Trocará. 2024. 205 f. '
              'Orientação: Profa. Dra. Sônia Maria da Silva Araújo.',
            ),

            const SizedBox(height: 20),

            _sectionTitle('Agradecimentos'),
            _paragraphCard(
              'Agradecemos à comunidade Asurini do Trocará pela preservação da língua e '
              'da cultura, e a todas as pessoas que contribuíram com pesquisas, registros '
              'e materiais que tornaram este aplicativo possível. Este app é um convite '
              'ao respeito, ao aprendizado e à valorização dos povos indígenas do Pará.',
            ),

            const SizedBox(height: 28),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Versão 1.0.0',
                    style: TextStyle(
                      color: textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* ---------- helpers de UI ---------- */

  static Widget _sectionTitle(String text) {
    return Padding(
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
  }

  static Widget _paragraphCard(String text) {
    return Container(
      width: double.infinity,
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
