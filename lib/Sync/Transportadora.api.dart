import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Model/Transportadora.model.dart';
import 'package:isoja/Repository/Transportadora.repository.dart';
import 'package:isoja/Utils/ApiProviderNest.util.dart';

class TransportadoraApi extends GetxController {
  final ApiProviderNest api = Get.find<ApiProviderNest>();
  final TransportadoraRepository repository = TransportadoraRepository();

  RxList<TransportadoraModel> transportadora = <TransportadoraModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTransportadora();
  }

  Future<bool> getTransportadora() async {
    try {
      final res = await api.get('/transportadora');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        transportadora.value =
            data.map((json) => TransportadoraModel.fromJson(json)).toList();

        bool salvoComSucesso = await repository.insertTransportadoraBatch(
          transportadora,
        );

        return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getUser: $e");
      return false;
    }
  }
}
