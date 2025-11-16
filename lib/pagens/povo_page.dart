import 'package:flutter/material.dart';

class PovoAsuriniPage extends StatelessWidget {
  const PovoAsuriniPage({super.key});

  static const Color bg = Color(0xFFF2E6D5);
  static const Color card = Color(0xFFF5D7BD);
  static const Color textDark = Color(0xFF3E2B22);
  static const Color accent = Color(0xFFA5673B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: textDark,
        foregroundColor: Colors.white,
        title: const Text('O Povo Asurini do Trocará'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quem são os Asurini do Trocará',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: textDark,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Os Asurini do Trocará habitam a Terra Indígena Trocará, no Pará, entre os municípios de '
              'Baião e Tucuruí, à margem do rio Tocantins, e falam a língua '
              'Asurini do Tocantins, da família Tupi-Guarani. ',
              style: TextStyle(color: textDark.withOpacity(0.9), height: 1.4),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 20),

            _InfoCard(
              title: 'Origem e Localização',
              text:
                  'A comunidade está localizada na Terra Indígena Trocará, e a língua é usada exclusivamente por esse povo no estado do Pará. '
                  'Historicamente, o termo “Asurini” passou a ser usado para esse grupo na região após contato com sertanejos e expansão de fronteiras na Amazônia. ',
              imagePath: 'assets/images/mapa.png',
            ),

            const SizedBox(height: 16),

            _InfoCard(
              title: 'Cultura e Identidade',
              text:
                  'A arte dos Asurini se manifesta em pinturas corporais, cerâmicas, grafismos e narrativas orais. '
                  'Essas expressões culturais são diretamente ligadas ao território, à floresta e ao rio, e formam parte da identidade do povo.',
              imagePath: 'assets/images/Arte_indígena1.png',
            ),

            const SizedBox(height: 16),

            _InfoCard(
              title: 'Desafios e Preservação',
              text:
                  'Apesar do idioma ainda estar em uso, a língua Asurini do Tocantins está em risco, pois as novas gerações falam cada vez mais o português. '
                  'Sustentar o idioma, a memória e os costumes tradicionais é parte essencial da sobrevivência cultural do povo Asurini.',
              imagePath: 'assets/images/alfabeto.jpeg',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String text;
  final String imagePath;

  const _InfoCard({
    required this.title,
    required this.text,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PovoAsuriniPage.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagePath.isNotEmpty) ...[
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: PovoAsuriniPage.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15,
                    color: PovoAsuriniPage.textDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
