import 'package:flutter/material.dart';
import 'package:dicionario_assurini/theme/theme.dart';

class OrigemLinguaPage extends StatelessWidget {
  const OrigemLinguaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Origem da Língua Asurini'),
        backgroundColor: AppColors.primary,
      ),
      backgroundColor: AppColors.background,
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'A língua Asurini tem origem nas raízes tupi-guarani e faz parte da '
          'herança cultural do povo Asurini do Xingu. Essa língua expressa não '
          'apenas a comunicação, mas também a relação espiritual e simbólica '
          'com o território, os antepassados e a natureza.',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
