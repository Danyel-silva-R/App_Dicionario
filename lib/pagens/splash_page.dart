import 'dart:async';
import 'package:dicionario_assurini/data/database/app_database.dart';
import 'package:flutter/material.dart';
import 'package:dicionario_assurini/theme/theme.dart';
import 'package:dicionario_assurini/pagens/app_page.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

Future<void> resetDatabase() async {
  final dbPath = await getDatabasesPath();
  final fullPath = p.join(dbPath, 'dicionario_assurini.db');
  await deleteDatabase(fullPath);
  print('🧹 Banco deletado: $fullPath');
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await resetDatabase();
    try {
      print('Inicializando banco...');
      final db = await AppDatabase.instance.database;

      // Teste simples: listar tabelas
      final tables = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
      print('Tabelas encontradas: $tables');

      // Pequeno delay pra manter o splash visível
      await Future.delayed(const Duration(seconds: 1));
    } catch (e, st) {
      print('Erro ao inicializar banco: $e\n$st');
    }

    if (mounted) {
      setState(() => _isLoading = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AppPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            if (_isLoading) ...[
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: Colors.white),
            ]
          ],
        ),
      ),
    );
  }
}
