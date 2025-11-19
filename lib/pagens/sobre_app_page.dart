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
              '“Sé kó – Dicionário Asurini” é um aplicativo criado para apoiar a preservação, '
              'a aprendizagem e a valorização da Língua Asurini do Trocará, falada pela '
              'comunidade indígena localizada entre Baião e Tucuruí, no Pará. '
              'O aplicativo reúne conteúdos linguísticos, culturais e educativos, '
              'tornando o acesso à língua mais acessível para estudantes, professores '
              'e para a própria comunidade indígena.',
            ),

            const SizedBox(height: 20),

            _title('Desenvolvimento'),
            _paragraphCard(
              'Desenvolvido por Danyel da Silva Rodrigues, Roger Luan Guimarães Goltara, '
              'Gabriel da Silva, Talia dos Santos e Bruno Nichael Farias David, alunos do '
              'curso de Ciência da Computação do IFPA – Campus Tucuruí. '
              '\n\nCom orientação do Professor Alex Oliveira e colaboração da Professora '
              'Maria Sarmento Pereira, que contribuiu com a organização e validação dos '
              'conteúdos relacionados à cultura e língua Asurini.',
            ),

            const SizedBox(height: 20),

            _title('Referências bibliográficas'),
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

            _title('Agradecimentos'),
            _paragraphCard(
              'Agradecemos à comunidade Asuriní do Trocará pela parceria na construção '
              'deste aplicativo, ao IFPA – Edital 09/2024 – PROEX/PROEN/PROPPG – Edital '
              'Diversidade, e a todas as pessoas que contribuíram com pesquisas, registros '
              'e materiais que tornaram este trabalho possível.\n\n'
              'Este aplicativo é um convite ao respeito, ao aprendizado e à valorização '
              'da língua materna dos povos indígenas do Pará, em especial da etnia '
              'Asurini do Trocará.',
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

  /* ---------- estilos reutilizáveis ---------- */

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
