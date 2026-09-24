import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:isoja/Sync/EntidadeEntrega.api.dart';
import 'package:isoja/Sync/Filial.api.dart';
import 'package:isoja/Sync/Transportadora.api.dart';

import 'package:isoja/Sync/User.api.dart';
import 'package:isoja/Sync/UserFilial.api.dart';
import 'package:isoja/Sync/Veiculos.api.dart';

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
      final veiculosApi = Get.find<VeiculoApi>();
      final transportadoraApi = Get.find<TransportadoraApi>();
      final entidadeApi = Get.find<EntidadeEntregaApi>();

      loadingText.value = "Buscando usuário...";
      await userApi.getUser();
      progress.value = 0.10;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Buscando filiais...";
      await filialApi.getFilial();
      progress.value = 0.36;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Buscando Veículos...";
      await veiculosApi.getVeiculos();
      progress.value = 0.46;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Buscando Transportadoras...";
      await transportadoraApi.getTransportadora();
      progress.value = 0.56;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Buscando Entidades de Entregas...";
      await entidadeApi.getEntidades();
      progress.value = 0.66;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Buscando vínculos entre usuário e filial...";
      await userFilialApi.getUserFilial();
      progress.value = 1.0;
      await Future.delayed(const Duration(milliseconds: 1000));

      loadingText.value = "Sincronização concluída!";
      await Future.delayed(const Duration(milliseconds: 100));

      bool usuarioLogado = box.read('is_logged') ?? false;

      Get.offAllNamed(usuarioLogado ? '/' : '/login');
    } catch (e) {
      loadingText.value = "Erro ao sincronizar os dados.";
      print("Erro ao carregar os dados: $e");
    }
  }
}
