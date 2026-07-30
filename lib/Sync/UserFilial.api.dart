import 'package:get/get.dart';
import 'package:isoja/Model/UserFilial.model.dart';
import 'package:isoja/Repository/UserFilila.repository.dart';
import 'package:isoja/Utils/ApiProvider.util.dart';

class UserFilialApi extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  final UserFilialRepository repository = UserFilialRepository();

  RxList<UserFilialModel> userFilial = <UserFilialModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserFilial();
  }

  Future<bool> getUserFilial() async {
    try {
      final res = await api.get('/api/app_alg/user_filial');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        userFilial.value =
            data.map((json) => UserFilialModel.fromJson(json)).toList();

        bool salvoComSucesso = await repository.insertUserFilialBatch(
          userFilial,
        );

        return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getUser: $e");
      return false;
    }
  }
}
