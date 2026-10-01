import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Model/Veiculo.model.dart';
import 'package:isoja/Utils/ApiJavaProvider.util.dart';

class VeiculoApi {
  final api = Get.find<ApiProviderJava>();

  String rota = '/veiculos';

  Future<Response> criarVeiculo(Veiculo veiculo) =>
      api.post(rota, veiculo.toJson());

  Future<Response> buscaVeiculo() => api.get(rota);
}
