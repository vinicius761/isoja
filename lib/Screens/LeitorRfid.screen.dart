import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/LeitorRfid.controller.dart';

class LeitorRfidScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeitorRfidController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tela com RFID'),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Aproxime a tag RFID ou escaneie o código de barras',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Obx(
              () => Text(
                controller.isDialogOpen.value
                    ? 'Leitor Ativo em Dialog...'
                    : 'Aguardando Leitura...',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
