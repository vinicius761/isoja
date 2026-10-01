import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Drawer.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Utils/CapitalizarNome.util.dart';
import 'package:isoja/Controllers/LeitorRfid.controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<LoginController>();
  final controllerRFID = Get.find<LeitorRfidController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Início'),
      drawer: DrawerComponent(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: AppColors.agroGreen,
                ),
                SizedBox(width: 8),
                Text(
                  'Olá ${capitalizarNome(controller.userLogado.value?.nome ?? '').split(' ').first}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "${controller.userFilialSelecionada.value?.codFilial ?? ''} - ${capitalizarNome(controller.userFilialSelecionada.value?.filialDesc ?? '')}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Obx(() {
              final isConectado = controllerRFID.isConectado.value;
              final isCarregando = controllerRFID.isConectando.value;

              return ElevatedButton.icon(
                onPressed:
                    isCarregando
                        ? null
                        : () async {
                          await controllerRFID.handleConexao();
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  disabledBackgroundColor: Colors.green.withOpacity(
                    0.6,
                  ), // Garante uma cor visível ao carregar
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12,
                    ), // Border radius de 12
                  ),
                ),
                icon:
                    isCarregando
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.lightGray,
                          ),
                        )
                        : Icon(
                          isConectado ? Icons.sync : Icons.bluetooth_connected,
                          color: AppColors.lightGray,
                        ),
                label: Text(
                  isCarregando
                      ? 'Processando...'
                      : (isConectado ? 'Reconectar RFID' : 'Conectar RFID'),
                  style: const TextStyle(
                    color: AppColors.lightGray,
                    fontSize: 16,
                  ),
                ),
              );
            }),
            // GraficoPizza(
            //   titulo: 'Distribuição de Umidade (%)',
            //   dados: dadosUmidade,
            // ),

            // const SizedBox(height: 15),

            // GraficoBarras(
            //   titulo: 'Estimativa de Perda (%)',
            //   dados: dadosPerda,
            //   maxY: 5.0,
            // ),
          ],
        ),
      ),
    );
  }
}
