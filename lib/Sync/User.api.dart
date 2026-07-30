import 'package:get/get.dart';
import 'package:isoja/Model/User.model.dart';
import 'package:isoja/Repository/User.repository.dart';
import 'package:isoja/Utils/ApiProvider.util.dart';

class UserApi extends GetxController {
  final ApiProvider api = Get.find<ApiProvider>();
  final UserRepository repository = UserRepository();

  RxList<UserModel> user = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<bool> getUser() async {
    try {
      final res = await api.get('/api/app_alg/user_');

      if (res.status.isOk && res.body != null) {
        final List<dynamic> data = res.body;

        user.value = data.map((json) => UserModel.fromJson(json)).toList();

        bool salvoComSucesso = await repository.insertUserBatch(user);

        return salvoComSucesso;
      }

      return false;
    } catch (e) {
      print("Erro no fluxo do getUser: $e");
      return false;
    }
  }
}
