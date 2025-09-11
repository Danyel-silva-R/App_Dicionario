import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';

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
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF654321),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            const Text(
              'Dicionário',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w300,
                color: Color(0xFFE8B17A),
                letterSpacing: 2,
              ),
            ),
            const Text(
              'Língua materna',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Color(0xFFE8B17A),
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
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuA3rD1RXiWEAon2D3DrpUsaEMYVWUivRE5rwgfFv2HZc2o_aOW-ZSzcv4rY5-Qoi_CXuraR8FzWSM8NMRHJXKwO3hcfaXvhlSGW0gXEs47m_sYVXZ3Pa5WyG-V21Ax_8klgf_qd61GwipnPN_Hqkf9rpX6Jp06HS7BQEcpsIxYb_jdvwQ2wMf7tYiGwvqZL53-NqQEfcSNp1WP1upK5mst5SiEJfcfLAQzqw3kyyekfrIlu691EcBq8wVONzG6T0YwBKxhfJwe__zpJ',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        color: const Color(0xFFE8B17A),
                      ),
                      child: const Icon(
                        Icons.face,
                        size: 80,
                        color: Colors.white,
                      ),
                    );
                  },
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
