import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Components/Select.component.dart';
import 'package:isoja/Components/StepperForm.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Veiculo.controller.dart';

class CadastroVeiculoScreen extends StatelessWidget {
  const CadastroVeiculoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VeiculoController>();

    final List<FormStep> steps = [
      // ETAPA 1: IDENTIFICAÇÃO BÁSICA
      FormStep(
        title: 'Básico',
        subtitle: 'Identificação',
        validate:
            () => controller.formKeyStep1.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep1,
          child: Column(
            children: [
              InputComponent(
                label: 'Código do Veículo *',
                controller: controller.codController,
                prefixIcon: Icons.qr_code,
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe o código' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Descrição / Modelo *',
                hintText: 'Ex: SCANIA R450',
                controller: controller.descricaoController,
                prefixIcon: Icons.directions_bus,
                enabled: true,
                validator:
                    (v) =>
                        v == null || v.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: InputComponent(
                      label: 'Placa *',
                      controller: controller.placaController,
                      validator:
                          (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 1,
                    child: InputComponent(
                      label: 'UF *',
                      controller: controller.estplaController,
                      validator:
                          (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Município da Placa',
                controller: controller.munplaController,
                prefixIcon: Icons.location_city,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 2: DOCUMENTAÇÃO
      FormStep(
        title: 'Documentos',
        subtitle: 'Chassi / RENAVAM',
        validate:
            () => controller.formKeyStep2.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep2,
          child: Column(
            children: [
              InputComponent(
                label: 'Número do Chassi *',
                controller: controller.chassiController,
                prefixIcon: Icons.subtitles,
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe o chassi' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'RENAVAM *',
                controller: controller.renavamController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.badge,
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe o RENAVAM' : null,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'Ano Fab.',
                      controller: controller.anoFabController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputComponent(
                      label: 'Ano Mod.',
                      controller: controller.anoModController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: InputComponent(
                      label: 'Qtd. Eixos',
                      controller: controller.qtdEixosController,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: InputComponent(
                      label: 'Tipo Veículo',
                      controller: controller.tipoVeiculoController,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      // ETAPA 3: CAPACIDADES E DIMENSÕES
      FormStep(
        title: 'Capacidade',
        subtitle: 'Pesos e Medidas',
        validate:
            () => controller.formKeyStep3.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep3,
          child: Column(
            children: [
              InputComponent(
                label: 'Capacidade Nominal (kg)',
                controller: controller.capacidadeNominalController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.scale,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Capacidade Máxima (kg)',
                controller: controller.capacidadeMaximaController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.scale,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Tara / Peso Vazio (kg)',
                controller: controller.taraController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.fitness_center,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Volume Máximo (m³)',
                controller: controller.volumeMaximoController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.view_in_ar,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 4: VÍNCULOS E PROPRIEDADE
      FormStep(
        title: 'Vínculos',
        subtitle: 'Frota / Motorista',
        validate:
            () => controller.formKeyStep4.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SelectComponent<String>(
                  labelText: 'Tipo de Frota',
                  value: controller.tipoFrota.value,
                  prefixIcon: const Icon(Icons.local_shipping_outlined),
                  items: const [
                    SelectOption(value: '1', label: '1 - Própria'),
                    SelectOption(value: '2', label: '2 - Terceiro'),
                    SelectOption(value: '3', label: '3 - Agregado'),
                  ],
                  onChanged: (val) => controller.setTipoFrota(val),
                ),
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Cód. Motorista Habitual',
                controller: controller.motoristaController,
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Cód. Fornecedor / Proprietário',
                controller: controller.fornecedorController,
                prefixIcon: Icons.store,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Grupo de Veículos',
                controller: controller.grupoVeiculoController,
                prefixIcon: Icons.category,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 5: SEGURO E RASTREAMENTO
      FormStep(
        title: 'Segurança',
        subtitle: 'Seguro e CIV',
        validate:
            () => controller.formKeyStep5.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep5,
          child: Column(
            children: [
              InputComponent(
                label: 'Apólice / Liberação Seguro',
                controller: controller.apoliceSeguroController,
                prefixIcon: Icons.security,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Certificado Inspeção Veicular (CIV)',
                controller: controller.civController,
                prefixIcon: Icons.verified_user,
              ),
              const SizedBox(height: 12),
              Obx(
                () => SwitchListTile(
                  title: const Text('Possui Rastreador?'),
                  value: controller.possuiRastreador.value,
                  onChanged: (val) => controller.possuiRastreador.value = val,
                ),
              ),
              Obx(
                () => SwitchListTile(
                  title: const Text('Cadastro Ativo?'),
                  value: controller.ativo.value,
                  onChanged: (val) => controller.ativo.value = val,
                ),
              ),
            ],
          ),
        ),
      ),

      // ETAPA 6: CONFIRMAÇÃO E REVISÃO
      FormStep(
        title: 'Revisão',
        subtitle: 'Confirmar Dados',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Confira as informações antes de salvar:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.darkBlue,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                border: Border.all(width: 1, color: AppColors.border),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Veículo: ${controller.descricaoController.text}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Placa: ${controller.placaController.text} - ${controller.estplaController.text}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Chassi: ${controller.chassiController.text}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'RENAVAM: ${controller.renavamController.text}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Frota: ${controller.descricaoTipoFrota}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Rastreador: ${controller.possuiRastreador.value ? "Sim" : "Não"}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppbarComponent(title: 'Cadastro Veículo'),
      body: CustomStepperForm(
        steps: steps,
        submitButtonText: 'Salvar Veículo',
        onComplete: () async {
          await controller.salvarVeiculo();
        },
      ),
    );
  }
}
