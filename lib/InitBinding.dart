import 'package:get/get.dart';
import 'package:isoja/Sync/Filial.api.dart';
import 'package:isoja/Sync/UserFilial.api.dart';
import 'package:isoja/Utils/ApiProvider.util.dart';
import 'package:isoja/Sync/User.api.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ApiProvider>(ApiProvider());
    Get.put<UserApi>(UserApi());
    Get.put<UserFilialApi>(UserFilialApi());
    Get.put<FilialApi>(FilialApi());
  }
}
