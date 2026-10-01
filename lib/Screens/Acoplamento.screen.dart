import 'package:flutter/material.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Acoplamento.controller.dart';
import 'package:isoja/Controllers/CavaloMecanico.controller.dart';
import 'package:isoja/Components/Dropdown.component.dart';
import 'package:get/get.dart';
import 'package:isoja/Controllers/Carreta.controller.dart';
import 'package:isoja/Components/Input.component.dart';

class AcoplamentoScreen extends StatelessWidget {
  const AcoplamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AcoplamentoController>();
    final cavaloController = Get.find<CavaloMecanicoController>();
    final carretaController = Get.find<CarretaController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppbarComponent(title: 'Acoplamento Carreta Cavalo'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() {
                  final String? valorSelecionado =
                      cavaloController.cavalos.any(
                            (item) =>
                                item.id.toString() == controller.idCavalo.value,
                          )
                          ? controller.idCavalo.value
                          : null;

                  return DropdownComponent(
                    label: 'Cavalo Mecânico',
                    value: valorSelecionado,
                    prefixIcon: Icon(
                      Icons.local_shipping_outlined, // Icone para o Cavalo
                      color: AppColors.agroGreen,
                    ),
                    hintText:
                        cavaloController.cavalos.isEmpty
                            ? 'Carregando cavalo mecânico...'
                            : 'Escolha o cavalo mecânico',
                    enabled: cavaloController.cavalos.isNotEmpty,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione um cavalo';
                      }
                      return null;
                    },
                    items:
                        cavaloController.cavalos.map<DropdownMenuItem<String>>((
                          item,
                        ) {
                          return DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text("${item.modelo}-${item.placa}"),
                          );
                        }).toList(),
                    onChanged:
                        (novoValor) => controller.idCavalo.value = novoValor!,
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  final String? valorSelecionado =
                      carretaController.carretas.any(
                            (item) =>
                                item.id.toString() ==
                                controller.idCarreta.value,
                          )
                          ? controller.idCarreta.value
                          : null;

                  return DropdownComponent(
                    label: 'Carreta',
                    value: valorSelecionado,
                    prefixIcon: Icon(
                      Icons.rv_hookup, // Icone para a Carreta/Engate
                      color: AppColors.agroGreen,
                    ),
                    hintText: 'Escolha a Carreta',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, selecione uma carreta';
                      }
                      return null;
                    },
                    items:
                        carretaController.carretas
                            .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text("${item.tipo}-${item.placa}"),
                              );
                            })
                            .toList(),
                    onChanged:
                        (novoValor) => controller.idCarreta.value = novoValor!,
                  );
                }),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'RFID',
                  hintText: 'Digite a placa',
                  prefixIcon: Icons.directions_car_outlined,
                  keyboardType: TextInputType.text,
                  controller: controller.RFID,
                  onChanged: (value) => controller.RFIDRead.value = value,
                  enabled: true,
                ),
                const SizedBox(height: 16),
                ButtonComponent(
                  text: 'Salvar',
                  onPressed: () => controller.salvar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
