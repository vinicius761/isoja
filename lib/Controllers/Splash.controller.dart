import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isoja/Sync/Filial.api.dart';

import 'package:isoja/Sync/User.api.dart';
import 'package:isoja/Sync/UserFilial.api.dart';

class SplashController extends GetxController {
  RxDouble progress = 0.0.obs;
  RxString loadingText = "Iniciando sincronização...".obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final userApi = Get.find<UserApi>();
      final filialApi = Get.find<FilialApi>();
      final userFilialApi = Get.find<UserFilialApi>();

      loadingText.value = "Buscando usuário...";
      await userApi.getUser();
      progress.value = 0.33;
      await Future.delayed(const Duration(milliseconds: 2000));

      loadingText.value = "Buscando filiais...";
      await filialApi.getFilial();
      progress.value = 0.66;
      await Future.delayed(const Duration(milliseconds: 2000));

      loadingText.value = "Buscando vínculos entre usuário e filial...";
      await userFilialApi.getUserFilial();
      progress.value = 1.0;
      await Future.delayed(const Duration(milliseconds: 2000));

      loadingText.value = "Sincronização concluída!";
      await Future.delayed(const Duration(milliseconds: 100));

      bool usuarioLogado = box.read('is_logged') ?? false;

      print("teste ${usuarioLogado}");
      Get.offAllNamed(usuarioLogado ? '/' : '/login');
    } catch (e) {
      loadingText.value = "Erro ao sincronizar os dados.";
      print("Erro ao carregar os dados: $e");
    }
  }
}
