import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Drawer.component.dart';
import 'package:isoja/Components/List.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Veiculo.controller.dart';
import 'package:isoja/Model/Veiculo.model.dart';

class VeiculoScreen extends StatelessWidget {
  VeiculoScreen({super.key});

  final controller = Get.find<VeiculoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Veículos'),
      drawer: DrawerComponent(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primaryBlue,
        icon: const Icon(Icons.add, color: AppColors.lightGray),
        label: const Text(
          'Adicionar Veículo',
          style: TextStyle(color: AppColors.lightGray),
        ),
        onPressed: () => Get.toNamed('/cadastro-veiculo'),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Obx(() {
          return ListComponent<Veiculo>(
            isLoading: controller.isLoading.value,
            items: controller.veiculos,
            emptyMessage: 'Nenhum veículo cadastrado.',
            titleBuilder: (veiculo) => veiculo.descricao ?? 'Sem nome',
            subtitleBuilder: (veiculo) => 'Placa: ${veiculo.placa ?? "N/A"}',
            onRefresh: () => controller.buscaVeiculos(),
            onTapItem: (veiculo) {
              controller.buscaVeiculo(veiculo.id);
            },
          );
        }),
      ),
    );
  }
}
