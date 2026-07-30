import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Controllers/Pecas.controller.dart';

class PecasBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PecasController>(PecasController());
  }
}
