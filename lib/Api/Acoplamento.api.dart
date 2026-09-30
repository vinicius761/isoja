import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/Acoplamento.model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class AcoplamentoApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/acoplamento';

  Future<Response> criarAcoplamento(Acoplamento acoplamento) =>
      api.post(rota, acoplamento.toJson());

  Future<Response> buscaAcoplamento() => api.get(rota);
}
