import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/Radio.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Model/User.model.dart';
import 'package:isoja/Model/UserFilial.model.dart';
import 'package:isoja/Repository/User.repository.dart';
import 'package:isoja/Repository/UserFilila.repository.dart';
import 'package:isoja/Components/ToastMessage.component.dart';

class LoginController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final UserRepository userRepo = UserRepository();
  final UserFilialRepository userFilialRepo = UserFilialRepository();
  final box = GetStorage();

  TextEditingController user = TextEditingController(text: 'vinicius.viegas');
  TextEditingController senha = TextEditingController(text: 'Iare@2026');

  RxList<UserFilialModel> userFilial = <UserFilialModel>[].obs;
  Rxn<UserFilialModel> userFilialSelecionada = Rxn<UserFilialModel>();
  Rxn<UserModel> userLogado = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
  }

  Future<void> entrar() async {
    if (formKey.currentState!.validate()) {
      final userRes = await userRepo.findByUserAndSenha(user.text, senha.text);

      if (userRes != null) {
        userLogado.value = userRes;
        userFilial.value = await userFilialRepo.userFilialRepo(userRes.idUser);
        selecioneFilila();
        await box.write('is_logged', true);
        return;
      }
      ToastMessageComponent.info('Usuário ou senha não encontrado!');
    }
  }

  Future<void> sair() async {
    user.text = '';
    senha.text = '';
    formKey = GlobalKey<FormState>();
    await box.write('is_logged', false);
    Get.toNamed('/login');
  }

  void selecioneFilila() async {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Text(
              "Selecione uma Filial",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...userFilial.map(
                      (item) => InkWell(
                        // Torna a linha inteira clicável para selecionar a filial
                        onTap: () {
                          userFilialSelecionada.value = item;
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item.codFilial} - ${item.filialDesc}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Obx(
                                () => RadioComponent<UserFilialModel?>(
                                  value: item,
                                  groupValue: userFilialSelecionada.value,
                                  activeColor: AppColors.agroGreen,
                                  onChanged: (UserFilialModel? valor) {
                                    userFilialSelecionada.value = valor;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonComponent(
              text: 'Entrar',
              onPressed: () {
                if (userFilialSelecionada.value == null) {
                  ToastMessageComponent.info(
                    'Por favor, selecione uma filial para continuar.',
                  );
                  return;
                }

                Get.offAllNamed('/');
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
