import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/CavaloMecanico.Model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class CavaloMecanicoApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/cavalosmecanico';

  Future<Response> criarCavaloMecanico(CavaloMecanico cavaloMecanico) =>
      api.post(rota, cavaloMecanico.toJson());

  Future<Response> buscaCavaloMecanico() => api.get(rota);
}
