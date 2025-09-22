import 'dart:async';
import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';
import 'app_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AppPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'Dicionário',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
                letterSpacing: 2,
              ),
            ),
            const Text(
              'Língua materna',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
                letterSpacing: 1,
              ),
            ),

            const SizedBox(height: 40),

            // Character illustration
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset(
                  'assets/images/logo_splash.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Subtitle
            const Text(
              'Asurini do',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const Text(
              'Trocará',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
