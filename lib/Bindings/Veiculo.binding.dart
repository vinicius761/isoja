import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Controllers/Veiculo.controller.dart';

class VeiculoBinding extends Bindings {
  @override
  void dependencies() {
    Get.delete<VeiculoController>();
    Get.put<VeiculoController>(VeiculoController());
  }
}
