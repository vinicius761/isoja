import 'package:get/get.dart';
import 'package:isoja/Model/Talhao.model.dart';
import 'package:isoja/Repository/Talhao.repository.dart';
import 'package:isoja/Utils/ApiProvider.util.dart';

class TalhaoApi extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  TalhaoRepository repository = TalhaoRepository();

  RxList<Talhao> talhao = <Talhao>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTalhao();
  }

  Future<bool> getTalhao() async {
    try {
      final res = await api.get('/api/app_alg/thpr_v2');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        talhao.value = data.map((json) => Talhao.fromJson(json)).toList();

        final result = await repository.insertBatch(talhao);

        return result.isNotEmpty;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getTalhao: $e");
      return false;
    }
  }
}
