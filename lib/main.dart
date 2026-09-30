import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isoja/Bindings/Acoplamento.binding.dart';
import 'package:isoja/Bindings/Carreta.binding.dart';
import 'package:isoja/Bindings/CavaloMecanico.binding.dart';
import 'package:isoja/Bindings/LeitorRfid.binding.dart';
import 'package:isoja/Bindings/Login.binding.dart';
import 'package:isoja/Bindings/Proprietario.binding.dart';
import 'package:isoja/Bindings/Romaneio.binding.dart';
import 'package:isoja/Bindings/Splash.binding.dart';
import 'package:isoja/InitBinding.dart';
import 'package:isoja/Screens/CadastroCarreta.screen.dart';
import 'package:isoja/Screens/CadastroCavaloMecanico.screen.dart';
import 'package:isoja/Screens/CadastroProprietario.screen.dart';
import 'package:isoja/Screens/Acoplamento.screen.dart';
import 'package:isoja/Screens/Home.screen.dart';
import 'package:isoja/Screens/LeitorRfid.screen.dart';
import 'package:isoja/Screens/Login.screen.dart';
import 'package:isoja/Screens/RomaneioComPesagem.dart';
import 'package:isoja/Screens/Splash.screen.dart';
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
        GetPage(name: '/', page: () => HomeScreen(), binding: LoginBinding()),
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
          name: '/cadastro-producao',
          page: () => RomaneioComPesagemScreen(),
          binding: RomaneioBinding(),
        ),
        GetPage(
          name: '/rfid',
          page: () => LeitorRfidScreen(),
          binding: LeitorRfidBinding(),
        ),
        GetPage(
          name: '/cadastro-proprietario',
          page: () => CadastroProprietarioScreen(),
          binding: ProprietarioBinding(),
        ),
        GetPage(
          name: '/cadastro-cavalo-mecanico',
          page: () => CadastroCavaloMecanicoScreen(),
          bindings: [CavaloMecanicoBinding(), ProprietarioBinding()],
        ),
        GetPage(
          name: '/cadastro-carreta',
          page: () => CadastroCarretaScreen(),
          bindings: [ProprietarioBinding(), CarretaBinding()],
        ),
        GetPage(
          name: '/Acoplamento',
          page: () => AcoplamentoScreen(),
          bindings: [
            CavaloMecanicoBinding(),
            CarretaBinding(),
            AcoplamentoBinding(),
          ],
        ),
      ],
    );
  }
}
