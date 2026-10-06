import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Drawer.component.dart';
import 'package:isoja/Components/List.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Motorista.controller.dart';
import 'package:isoja/Model/Motorista.model.dart';

class MotoristasScreen extends StatelessWidget {
  MotoristasScreen({super.key});

  final controller = Get.find<MotoristaController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Motoristas'),
      drawer: DrawerComponent(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: AppColors.lightGray),
        label: const Text(
          'Adicionar Motorista',
          style: TextStyle(color: AppColors.lightGray),
        ),
        onPressed: () => Get.toNamed('/cadastro-motorista'),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Obx(() {
          return ListComponent<Motorista>(
            iconData: Icons.person,
            isLoading: controller.isLoading.value,
            items: controller.motoristas,
            emptyMessage: 'Nenhum motorista cadastrado.',
            titleBuilder: (motorista) => motorista.da4Nome ?? 'Sem nome',
            subtitleBuilder:
                (motorista) => 'Placa: ${motorista.da4Cod ?? "N/A"}',
            onRefresh: () => controller.buscaMotoristas(),
            onTapItem: (motorista) {
              controller.buscarPorDa4Cod(motorista.da4Cod!);
              // controller.buscaVeiculo(veiculo.id);
            },
          );
        }),
      ),
    );
  }
}
