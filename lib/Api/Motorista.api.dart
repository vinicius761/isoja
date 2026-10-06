import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/Motorista.model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class MotoristaApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/motoristas';

  Future<Response> criarMotorista(Motorista motorista) =>
      api.post(rota, motorista.toJson());

  Future<Response> buscaMotorista() => api.get(rota);
}
