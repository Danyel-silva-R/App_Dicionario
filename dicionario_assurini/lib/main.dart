import 'package:flutter/material.dart';
import 'splash_page.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashPage(),
    );
  }
}