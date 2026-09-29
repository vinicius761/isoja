import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/Dropdown.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Carreta.controller.dart';
import 'package:isoja/Controllers/Proprietario.controller.dart';
import 'package:isoja/Utils/Validators/CampoVazio.validator.dart';

class CadastroCarretaScreen extends StatelessWidget {
  const CadastroCarretaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarretaController>();
    final proprietarioController = Get.find<ProprietarioController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppbarComponent(title: 'Cadastro de Cavalo Mecânico'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                Obx(() {
                  final String? valorSelecionado =
                      proprietarioController.proprietarios.any(
                            (item) =>
                                item.id == controller.idProprietario.value,
                          )
                          ? controller.idProprietario.value
                          : null;

                  return DropdownComponent(
                    label: 'Proprietário',
                    value: valorSelecionado,
                    hintText:
                        proprietarioController.proprietarios.isEmpty
                            ? 'Carregando proprietários...'
                            : 'Escolha o proprietário',
                    enabled: proprietarioController.proprietarios.isNotEmpty,
                    items:
                        proprietarioController.proprietarios
                            .map<DropdownMenuItem<String>>((item) {
                              return DropdownMenuItem<String>(
                                value: item.id,
                                child: Text(item.nome),
                              );
                            })
                            .toList(),
                    onChanged:
                        (novoValor) =>
                            controller.idProprietario.value = novoValor!,
                  );
                }),
                const SizedBox(height: 16),
                Obx(() {
                  final String? valorSelecionado =
                      controller.tiposCarreta.any(
                            (item) => item == controller.idProprietario.value,
                          )
                          ? controller.idProprietario.value
                          : null;

                  return DropdownComponent(
                    label: 'Tipo',
                    value: valorSelecionado,
                    hintText:
                        controller.tiposCarreta.isEmpty
                            ? 'Carregando Tipo...'
                            : 'Escolha o Tipo',
                    enabled: controller.tiposCarreta.isNotEmpty,
                    items:
                        controller.tiposCarreta.map<DropdownMenuItem<String>>((
                          item,
                        ) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                    onChanged:
                        (novoValor) =>
                            controller.idProprietario.value = novoValor!,
                  );
                }),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Placa',
                  hintText: 'Digite a placa',
                  prefixIcon: Icons.directions_car_outlined,
                  keyboardType: TextInputType.text,
                  controller: controller.placa,
                  validator: (value) => validarCampoVazio(value, 'Placa'),
                ),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Renavam',
                  hintText: 'Digite o Renavam',
                  prefixIcon: Icons.badge_outlined,
                  controller: controller.renavam,
                  keyboardType: TextInputType.number,
                  validator: (value) => validarCampoVazio(value, 'Renavam'),
                ),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Quantidade de Eixo',
                  hintText: 'Digite a quantidade de eixo',
                  prefixIcon: Icons.commute_outlined,
                  controller: controller.eixos,
                  keyboardType: TextInputType.text,
                  validator: (value) => validarCampoVazio(value, 'eixo'),
                ),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Ano de Fabricação',
                  hintText: 'Digite o ano de fabricação',
                  prefixIcon: Icons.calendar_today_outlined,
                  controller: controller.anoFabricacao,
                  keyboardType: TextInputType.number,
                  validator:
                      (value) => validarCampoVazio(value, 'Ano de Fabricação'),
                ),
                const SizedBox(height: 20),
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
