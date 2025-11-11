import 'package:flutter/material.dart';

class OrigemLinguaPage extends StatelessWidget {
  const OrigemLinguaPage({super.key});

  // Paleta (ajuste para o seu tema global, se já tiver AppColors)
  static const Color bg = Color(0xFFF2E6D5);
  static const Color card = Color(0xFFF5D7BD);
  static const Color textDark = Color(0xFF3E2B22);
  static const Color chip = Color(0xFFEBC7A9);
  static const Color accent = Color(0xFFA5673B);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: textDark,
        foregroundColor: Colors.white,
        title: const Text('Origem da Língua'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderChip(text: 'Contexto'),
            _ParagraphCard(
              child: Text(
                // TODO: Substituir pelo resumo do livro (origem histórica/etimológica).
                // Dica: 1 parágrafo curto explicando o que é a língua Asurini e onde é falada.
                'A língua Asurini é a língua materna do povo Asurini, transmitida '
                'principalmente pela tradição oral. Sua história está ligada ao território, '
                'às práticas culturais e às relações com a natureza e os demais povos da região.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textDark,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16),
            _HeaderChip(text: 'Linhas gerais de origem'),
            _BulletCard(
              items: const [
                // TODO: substituir/confirmar com o livro
                'Tradição oral como base de preservação e transmissão entre gerações.',
                'Sistema fonético e ortográfico adaptado para representar os sons próprios da língua.',
                'Vocabulário ligado à vida na floresta, rios, fauna e objetos culturais.',
              ],
            ),

            const SizedBox(height: 16),
            _HeaderChip(text: 'Família linguística'),
            _ParagraphCard(
              child: Text(
                // TODO: Confirmar no livro a família linguística (ex.: Tupi-Guarani)
                // e inserir a formulação exata do material.
                'Segundo a literatura linguística, a língua Asurini se relaciona a grupos '
                'indígenas da região amazônica e apresenta características fonéticas e '
                'lexicais próprias. O registro escrito foi desenvolvido para refletir fielmente '
                'os sons presentes na fala do povo.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textDark,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16),
            _HeaderChip(text: 'Como a língua é ensinada e mantida'),
            _BulletCard(
              items: const [
                // TODO: extrair do livro práticas de ensino/uso comunitário descritas
                'Uso cotidiano na comunidade e em atividades culturais.',
                'Registro de palavras, provérbios e narrativas tradicionais.',
                'Materiais didáticos locais (como alfabetos ilustrados e pequenas coleções de termos).',
              ],
            ),

            const SizedBox(height: 16),
            _HeaderChip(text: 'Notas sobre pronúncia (resumo)'),
            _ParagraphCard(
              child: Text(
                // Adaptado do trecho que você enviou (sem citar literalmente).
                // Se quiser, cole a citação exata do livro aqui.
                'As vogais principais são A, E, I, O e Y. As quatro primeiras têm valores '
                'similares aos do português. Já o “Y” representa um som que não existe no '
                'português: é uma vogal alta e não-arredondada, mais central que o “I”, '
                'aproximando-se do “A”.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: textDark,
                  height: 1.4,
                ),
                textAlign: TextAlign.justify,
              ),
            ),

            const SizedBox(height: 16),
            _HeaderChip(text: 'Linha do tempo (resumo)'),
            _TimelineCard(
              events: const [
                // TODO: preencha com marcos do livro (ex.: contato, registros, projetos educacionais)
                TimelineEvent(
                  title: 'Tradição oral',
                  subtitle: 'Transmissão familiar e comunitária.',
                ),
                TimelineEvent(
                  title: 'Registros escritos',
                  subtitle: 'Sistematização para ensino e preservação.',
                ),
                TimelineEvent(
                  title: 'Materiais didáticos',
                  subtitle:
                      'Produção de cartazes, dicionários e atividades escolares.',
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

/* ============  W I D G E T S  ============ */

class _HeaderChip extends StatelessWidget {
  final String text;
  const _HeaderChip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: OrigemLinguaPage.chip,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: OrigemLinguaPage.textDark,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ParagraphCard extends StatelessWidget {
  final Widget child;
  const _ParagraphCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: OrigemLinguaPage.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

class _BulletCard extends StatelessWidget {
  final List<String> items;
  const _BulletCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return _ParagraphCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final t in items) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '•  ',
                  style: TextStyle(
                    color: OrigemLinguaPage.textDark,
                    height: 1.45,
                  ),
                ),
                Expanded(
                  child: Text(
                    t,
                    style: const TextStyle(
                      color: OrigemLinguaPage.textDark,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final List<TimelineEvent> events;
  const _TimelineCard({required this.events});

  @override
  Widget build(BuildContext context) {
    return _ParagraphCard(
      child: Column(
        children: [
          for (int i = 0; i < events.length; i++) ...[
            _TimelineTile(event: events[i], isLast: i == events.length - 1),
            if (i != events.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class TimelineEvent {
  final String title;
  final String subtitle;
  const TimelineEvent({required this.title, required this.subtitle});
}

class _TimelineTile extends StatelessWidget {
  final TimelineEvent event;
  final bool isLast;
  const _TimelineTile({required this.event, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // marcador
        Column(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: OrigemLinguaPage.textDark,
                shape: BoxShape.circle,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 24,
                color: OrigemLinguaPage.textDark.withOpacity(0.35),
              ),
          ],
        ),
        const SizedBox(width: 10),
        // texto
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  color: OrigemLinguaPage.textDark,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                event.subtitle,
                style: const TextStyle(
                  color: OrigemLinguaPage.textDark,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
