import 'package:flutter/material.dart';
import 'package:o_soja/View/home_screen.dart';
import 'package:o_soja/dao/database.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await _checkPermissions();
  // 2. Cria a instância única do banco
  final database = AppDatabase();

  runApp(

    Provider<AppDatabase>(
      create: (_) => database,
      dispose: (_, db) => db.close(),
      child: const AgroApp(),
    ),
  );
}
/*void main() async {
  // 1. Garante a comunicação com os plugins nativos (Criptografia/Storage)
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Solicita permissões necessárias no Android
  await _checkPermissions();

  // 3. Inicializa o banco (Aqui o Drift gera a chave e abre o SQLCipher)
  final database = AppDatabase();

  runApp(
    // O Provider deixa o banco disponível para todas as telas
    Provider<AppDatabase>(
      create: (_) => database,
      dispose: (_, db) => db.close(),
      child: const AgroApp(),
    ),
  );
}*/

Future<void> _checkPermissions() async {

  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}

class AgroApp extends StatelessWidget {
  const AgroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O_Soja',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1B5E20),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B5E20)),
      ),
      initialRoute: '/home', //mudar para / depois para login
      routes: {
       // '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}