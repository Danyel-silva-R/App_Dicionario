import 'package:dicionario_assurini/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:dicionario_assurini/pagens/splash_page.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    // Habilita SQLite via FFI para desktop
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
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
