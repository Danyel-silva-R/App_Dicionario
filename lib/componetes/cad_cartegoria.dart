import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';

class CadCategoria extends StatelessWidget {
  final String nomeCad;
  final String imagenRela; // precisa ser final, pois StatelessWidget é imutável

  const CadCategoria({
    super.key,
    required this.nomeCad,
    required this.imagenRela, // recebe como parâmetro obrigatório
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 7, // <-- Aqui define a sombra
        shadowColor: Colors.black.withOpacity(0.6), // <-- Cor da sombra
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imagenRela, width: 100),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                nomeCad,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
