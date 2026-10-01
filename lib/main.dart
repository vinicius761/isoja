import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isoja/Bindings/LeitorRfid.binding.dart';
import 'package:isoja/Bindings/Login.binding.dart';
import 'package:isoja/Bindings/Splash.binding.dart';
import 'package:isoja/Bindings/Veiculo.binding.dart';
import 'package:isoja/InitBinding.dart';
import 'package:isoja/Screens/Home.screen.dart';
import 'package:isoja/Screens/LeitorRfid.screen.dart';
import 'package:isoja/Screens/Login.screen.dart';
import 'package:isoja/Screens/Splash.screen.dart';
import 'package:isoja/Screens/CadastroVeiculo.screen.dart';
import 'package:isoja/Screens/Veiculo.screen.dart';
import 'package:isoja/Utils/DatabaseHelper.util.dart';
import 'package:isoja/Utils/VerificaPermissoes.util.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await GetStorage().erase();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Erro real ao carregar o arquivo .env: $e");
  }

  try {
    await solicitarPermissoes();
  } catch (e) {
    print("Aviso de Permissão: $e");
  }

  try {
    await DatabaseHelper.instance.database;
  } catch (e) {
    print("Erro ao inicializar o Banco de Dados: $e");
  }

  runApp(const ISoja());
}

class ISoja extends StatelessWidget {
  const ISoja({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ISoja',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: ThemeData(textTheme: GoogleFonts.robotoTextTheme()),
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
          bindings: [LoginBinding(), LeitorRfidBinding()],
        ),
        GetPage(
          name: '/splash',
          page: () => Splashscreen(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
          binding: LoginBinding(),
        ),

        GetPage(
          name: '/rfid',
          page: () => LeitorRfidScreen(),
          binding: LeitorRfidBinding(),
        ),
        GetPage(
          name: '/cadastro-veiculo',
          page: () => CadastroVeiculoScreen(),
          binding: VeiculoBinding(),
        ),
        GetPage(
          name: '/veiculo',
          page: () => VeiculoScreen(),
          binding: VeiculoBinding(),
        ),
      ],
    );
  }
}
