import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:dicionario_assurini/pagens/splash_page.dart';

void main() {
  runApp(const DicionarioApp());
}

class DicionarioApp extends StatelessWidget {
  const DicionarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicionário',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}
