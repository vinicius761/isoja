import 'package:get/get.dart';
import 'package:isoja/Model/Filial.model.dart';
import 'package:isoja/Repository/Filial.repository.dart';
import 'package:isoja/Utils/ApiProvider.util.dart';

class FilialApi extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  final FilialRepository repository = FilialRepository();

  RxList<Filial> filial = <Filial>[].obs;

  @override
  void onInit() {
    super.onInit();
    getFilial();
  }

  Future<bool> getFilial() async {
    try {
      final res = await api.get('/api/app_alg/filial');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        filial.value = data.map((json) => Filial.fromJson(json)).toList();

        bool salvoComSucesso = await repository.insertFilialBatch(filial);

        return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getUser: $e");
      return false;
    }
  }
}
