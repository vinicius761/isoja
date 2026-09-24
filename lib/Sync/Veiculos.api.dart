import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:isoja/Model/Veiculo.model.dart';
import 'package:isoja/Repository/Veiculo.repository.dart';
import 'package:isoja/Utils/ApiProviderNest.util.dart';

class VeiculoApi extends GetxController {
  final ApiProviderNest api = Get.find<ApiProviderNest>();
  final VeiculoRepository repository = VeiculoRepository();

  RxList<VeiculoModel> vaiculos = <VeiculoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getVeiculos();
  }

  Future<bool> getVeiculos() async {
    try {
      final res = await api.get('/veiculos');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        vaiculos.value =
            data.map((json) => VeiculoModel.fromJson(json)).toList();

        bool salvoComSucesso = await repository.insertVeiculoBatch(vaiculos);

        return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getVeiculos: $e");
      return false;
    }
  }
}
