import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Model/EntidadeEntrega.model.dart';
import 'package:isoja/Repository/Filial.repository.dart';
import 'package:isoja/Utils/ApiProviderNest.util.dart';

class EntidadeEntregaApi extends GetxController {
  final ApiProviderNest api = Get.find<ApiProviderNest>();
  final FilialRepository repository = FilialRepository();

  RxList<EntidadeEntrega> entidadeEntrega = <EntidadeEntrega>[].obs;

  @override
  void onInit() {
    super.onInit();
    getEntidades();
  }

  Future<bool> getEntidades() async {
    try {
      final res = await api.get('/entidade-entrega');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        entidadeEntrega.value =
            data.map((json) => EntidadeEntrega.fromJson(json)).toList();

        // bool salvoComSucesso = await repository.insertFilialBatch(
        //   entidadeEntrega,
        // );

        // return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getEntidade: $e");
      return false;
    }
  }
}
