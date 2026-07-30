import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Controllers/RomaneioCadastro.controller.dart';

class RomaneioBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<RomaneioCadastroController>(RomaneioCadastroController());
  }
}
