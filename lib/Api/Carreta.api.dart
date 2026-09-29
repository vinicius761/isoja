import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/Carreta.model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class CarretaApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/carreta';

  Future<Response> criarCavaloMecanico(Carreta carreta) =>
      api.post(rota, carreta.toJson());

  Future<Response> buscaCavaloMecanico() => api.get(rota);
}
