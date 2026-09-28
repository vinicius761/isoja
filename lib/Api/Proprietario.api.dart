import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/Proprietario.model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class ProprietarioApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/proprietarios';

  Future<Response> criarProprietario(Proprietario proprietario) =>
      api.post(rota, proprietario.toJson());

  Future<Response> buscaProprietario() => api.get(rota);
}
