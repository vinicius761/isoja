import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/Dropdown.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/CavaloMecanico.controller.dart';
import 'package:isoja/Controllers/Proprietario.controller.dart';
import 'package:isoja/Utils/Validators/CampoVazio.validator.dart';

class CadastroCavaloMecanicoScreen extends StatelessWidget {
  const CadastroCavaloMecanicoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CavaloMecanicoController>();
    // Instancia o controller correto do Proprietário
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
                  label: 'Marca',
                  hintText: 'Digite a marca',
                  prefixIcon: Icons.branding_watermark_outlined,
                  controller: controller.marca,
                  keyboardType: TextInputType.text,
                  validator: (value) => validarCampoVazio(value, 'Marca'),
                ),
                const SizedBox(height: 16),
                InputComponent(
                  label: 'Modelo',
                  hintText: 'Digite o modelo',
                  prefixIcon: Icons.commute_outlined,
                  controller: controller.modelo,
                  keyboardType: TextInputType.text,
                  validator: (value) => validarCampoVazio(value, 'Modelo'),
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
