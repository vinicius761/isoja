import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Components/Select.component.dart';
import 'package:isoja/Components/StepperForm.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Motorista.controller.dart';
import 'package:isoja/Utils/mascaraCampo/data.dart';
import 'package:isoja/Utils/mascaraCampo/documentosPessoais.dart';

class CadastroMotoristaScreen extends StatelessWidget {
  const CadastroMotoristaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MotoristaController>();

    final List<FormStep> steps = [
      // ETAPA 1: DADOS PESSOAIS E IDENTIFICAÇÃO
      FormStep(
        title: 'Dados Pessoais',
        subtitle: 'Identificação',
        validate:
            () => controller.formKeyStep1.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep1,
          child: Column(
            children: [
              InputComponent(
                label: 'Nome Completo *',
                controller: controller.nomeController,
                prefixIcon: Icons.person,
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Nome Reduzido / Apelido',
                controller: controller.nreduzController,
                prefixIcon: Icons.badge,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'CPF *',
                controller: controller.cgcController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.badge_outlined,
                inputFormatters: [maskCpf],
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Matrícula',
                controller: controller.matController,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Data de Nascimento',
                controller: controller.datnasController,
                keyboardType: TextInputType.datetime,
                prefixIcon: Icons.calendar_today,
                inputFormatters: [maskData],
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Estado Civil',
                controller: controller.estcivController,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 2: DOCUMENTAÇÃO E CNH
      FormStep(
        title: 'Documentos',
        subtitle: 'RG e CNH',
        validate:
            () => controller.formKeyStep2.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep2,
          child: Column(
            children: [
              InputComponent(
                label: 'RG *',
                controller: controller.rgController,
                inputFormatters: [maskRg],
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe o RG' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Órgão Emissor',
                controller: controller.rgorgController,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'UF RG',
                controller: controller.rgestController,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Número CNH *',
                controller: controller.numcnhController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.card_membership,
                inputFormatters: [maskCnh],
                validator:
                    (v) => v == null || v.isEmpty ? 'Informe a CNH' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Registro CNH',
                controller: controller.regcnhController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Cat. CNH *',
                controller: controller.catcnhController,
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Emissão CNH',
                controller: controller.dtecnhController,
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Validade CNH *',
                controller: controller.dtvcnhController,
                keyboardType: TextInputType.datetime,
                validator: (v) => v == null || v.isEmpty ? 'Obrigatório' : null,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Município CNH',
                controller: controller.muncnhController,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'UF CNH',
                controller: controller.estcnhController,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 3: ENDEREÇO E CONTATO
      FormStep(
        title: 'Contato',
        subtitle: 'Endereço e Telefones',
        validate:
            () => controller.formKeyStep3.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep3,
          child: Column(
            children: [
              InputComponent(
                label: 'Endereço',
                controller: controller.endController,
                prefixIcon: Icons.home,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Bairro',
                controller: controller.bairroController,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'CEP',
                controller: controller.cepController,
                inputFormatters: [maskCep],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Município',
                controller: controller.munController,
                prefixIcon: Icons.location_city,
              ),
              const SizedBox(height: 12),
              InputComponent(label: 'UF', controller: controller.estController),
              const SizedBox(height: 12),
              InputComponent(
                label: 'DDD',
                controller: controller.dddController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Telefone Principal',
                controller: controller.telController,
                inputFormatters: [maskTelefone],
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'E-mail',
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email,
              ),
            ],
          ),
        ),
      ),

      // ETAPA 4: VÍNCULOS E GERENCIAMENTO DE RISCO
      FormStep(
        title: 'Vínculos',
        subtitle: 'Tipo / Risco',
        validate:
            () => controller.formKeyStep4.currentState?.validate() ?? false,
        content: Form(
          key: controller.formKeyStep4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => SelectComponent<String>(
                  labelText: 'Tipo de Motorista',
                  value: controller.tipmot.value,
                  prefixIcon: const Icon(Icons.badge),
                  items: const [
                    SelectOption(value: '1', label: '1 - Próprio'),
                    SelectOption(value: '2', label: '2 - Terceiro'),
                    SelectOption(value: '3', label: '3 - Agregado'),
                  ],
                  onChanged: (val) => controller.setTipoMotorista(val),
                ),
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Fornecedor / Transportadora',
                controller: controller.fornecController,
                prefixIcon: Icons.store,
              ),
              const SizedBox(height: 12),
              InputComponent(
                label: 'Nº Liberação Seguro / Gerenciadora',
                controller: controller.numsegController,
                prefixIcon: Icons.security,
              ),
              const SizedBox(height: 12),
              Obx(
                () => SwitchListTile(
                  title: const Text('Carga Perigosa (MOPP)?'),
                  value: controller.carper.value,
                  onChanged: (val) => controller.carper.value = val,
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

      // ETAPA 5: REVISÃO E CONFIRMAÇÃO
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
                      'Nome: ${controller.nomeController.text}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'CPF: ${controller.cgcController.text}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'CNH: ${controller.numcnhController.text} (Cat. ${controller.catcnhController.text})',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Tipo: ${controller.descricaoTipoMotorista}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkBlue,
                      ),
                    ),
                    Text(
                      'Telefone: (${controller.dddController.text}) ${controller.telController.text}',
                      style: const TextStyle(
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
      appBar: const AppbarComponent(title: 'Cadastro de Motorista'),
      body: CustomStepperForm(
        steps: steps,
        submitButtonText: 'Salvar Motorista',
        onComplete: () async {
          await controller.salvar();
        },
      ),
    );
  }
}
