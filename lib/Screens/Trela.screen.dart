import 'package:flutter/material.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/CavaloMecanico.controller.dart';
import 'package:isoja/Components/Dropdown.component.dart';
import 'package:get/get.dart';
import 'package:isoja/Controllers/Carreta.controller.dart';

class TrelaScreen extends StatelessWidget {
  const TrelaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarretaController>();
    final cavaloController = Get.find<CavaloMecanicoController>();
    final carretaController = Get.find<CarretaController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppbarComponent(title: 'Cadastro de Carreta'),
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
                                item.id == controller.idProprietario.value,
                          )
                          ? controller.idProprietario.value
                          : null;

                  return DropdownComponent(
                    label: 'Proprietário',
                    value: valorSelecionado,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: AppColors.agroGreen,
                    ),
                    hintText:
                        cavaloController.cavalos.isEmpty
                            ? 'Carregando proprietários...'
                            : 'Escolha o proprietário',
                    enabled: cavaloController.cavalos.isNotEmpty,
                    items:
                        cavaloController.cavalos.map<DropdownMenuItem<String>>((
                          item,
                        ) {
                          return DropdownMenuItem<String>(
                            value: item.id,
                            child: Text(item.nome),
                          );
                        }).toList(),
                    onChanged:
                        (novoValor) =>
                            controller.idProprietario.value = novoValor!,
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  final String? valorSelecionado =
                      carretaController.carretas.any(
                            (item) =>
                                item.id == controller.idProprietario.value,
                          )
                          ? controller.idProprietario.value
                          : null;

                  return DropdownComponent(
                    label: 'Carreta',
                    value: valorSelecionado,
                    prefixIcon: Icon(
                      Icons.category_outlined,
                      color: AppColors.agroGreen,
                    ),
                    hintText: 'Escolha o Carreta',
                    items:
                        carretaController.carretas
                            .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.placa),
                              );
                            })
                            .toList(),
                    onChanged:
                        (novoValor) => controller.tipo.value = novoValor!,
                  );
                }),
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
