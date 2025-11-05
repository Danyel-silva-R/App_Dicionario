import 'package:dicionario_assurini/data/repositories/exemplos_repository.dart';
import 'package:flutter/material.dart';

class BuildExemplosCards extends StatelessWidget {
  final int id;

  BuildExemplosCards({required this.id});

  final ExemplosRepository _exemplosRepository = ExemplosRepository();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _exemplosRepository.getExemplosByPalavraId(id),
      
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar exemplos.'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final exemplos = snapshot.data;

        if (exemplos == null || exemplos.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Nenhum exemplo de uso encontrado para esta palavra.',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          );
        }
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: exemplos.map((exemplo) {
            final fraseAssurini = exemplo['frase_assurini'] as String;
            final traducao = exemplo['traducao'] as String;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              
              child: _buildExemploCard(
                fraseAssurini: fraseAssurini,
                traducao: traducao,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


Widget _buildExemploCard({
  required String fraseAssurini,
  required String traducao,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFE8F5E8),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: const Color(0xFF4CAF50).withOpacity(0.3),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: Color(0xFF4CAF50),
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Frase em Assurini:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4CAF50),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 🚀 Frase Assurini
        Text(
          fraseAssurini,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Tradução:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(height: 4),
        // 🚀 Tradução
        Text(
          traducao,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF2E7D32),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}