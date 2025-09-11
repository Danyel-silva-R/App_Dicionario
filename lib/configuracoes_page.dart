import 'package:flutter/material.dart';

class ConfiguracoesPage extends StatelessWidget {
  const ConfiguracoesPage({super.key, this.showBackButton = true});

  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF654321),
        foregroundColor: Colors.white,
        leading:
            showBackButton
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                )
                : null,
        automaticallyImplyLeading: showBackButton,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildConfigurationItem('Política de privacidade', () {
              // Navegar para política de privacidade
            }),
            const SizedBox(height: 16),
            _buildConfigurationItem('Sobre o Dicionário', () {
              // Navegar para sobre o dicionário
            }),
            const SizedBox(height: 16),
            _buildConfigurationItem('Ajuda', () {
              // Navegar para ajuda
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigurationItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A4A4A),
                ),
              ),
            ),
            const Icon(Icons.arrow_forward, color: Color(0xFF4A4A4A), size: 24),
          ],
        ),
      ),
    );
  }
}
