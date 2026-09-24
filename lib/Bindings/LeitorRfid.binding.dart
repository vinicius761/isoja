import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Controllers/LeitorRfid.controller.dart';

class LeitorRfidBinding extends Bindings {
  @override
  void dependencies() {
    Get.delete<LeitorRfidController>();
    Get.put<LeitorRfidController>(LeitorRfidController(), permanent: true);
  }
}
