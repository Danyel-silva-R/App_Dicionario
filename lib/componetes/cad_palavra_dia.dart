import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';

class CadPalavraDia extends StatelessWidget {
  const CadPalavraDia({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        color: AppColors.secondary,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.9),
        child: Column(
          children: [
            Text(
              "Palavra do Dia",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Menino',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Kurumi',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  ''
                  'assets/images/logo_splash.png',
                  height: 150,
                  width: 150,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
