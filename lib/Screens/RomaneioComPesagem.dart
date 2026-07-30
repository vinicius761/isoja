import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/CustomResponsiveTable.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Components/Select.component.dart';
import 'package:isoja/Components/TabBar.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/RomaneioCadastro.controller.dart';

class RomaneioComPesagemScreen extends StatelessWidget {
  RomaneioComPesagemScreen({super.key});

  final controller = Get.put(RomaneioCadastroController());

  Widget _getFormByTabIndex(int index) {
    switch (index) {
      case 0:
        return PrincipalForm();
      case 1:
        return AnaliseForm();
      case 2:
        return PesagemForm();
      case 3:
        return ControleForm();
      default:
        return const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('Outros Formulários'),
        );
    }
  }

  Widget _getTableByTabIndex(int index) {
    switch (index) {
      case 0:
        return ResponsiveTable(
          headers: const [
            'Seq',
            'Class',
            'Cod.I.T.D.',
            'Des.I.T.D.',
            'Peso Base',
            'Obrigatório',
            'Resultado',
            '% Desc',
            'Qt Descontad',
            'Des Resultad',
          ],
          rows: const [],
        );
      case 1:
        return ResponsiveTable(
          headers: const [
            'Seq. Cla.',
            'Item',
            'Cod.I.T.D.',
            'Des.I.T.D.',
            'Peso Base',
            'Resultado',
            '% Desc',
            'Qt Descontad',
            'Des Resultad',
            'Tabela Alt',
            'Produto Alt',
          ],
          rows: const [],
        );
      case 2:
        return ResponsiveTable(
          headers: const [
            'Item Rom.',
            'Cod.Entidade',
            'Loj.Entidade',
            'Nom.Entidade',
            'Nom.Loj.Ent.',
            'Cod. Safra',
            'Talhao',
            'Cod. Produto',
            'Des. Produto',
            'Unid.Med.',
            'Local',
            'Cod. Instr.',
            'Contrato',
            'Desc.Contr.',
            'Oper.Fis.',
            'TES',
            'Perc.Div.',
            'Qtd. Fisica',
            'Lote',
            'Form.Prop.',
            'Serie NF',
            'Numero NF',
            'Item DocFis',
            'Emissao NF',
            'Especie NF',
            'Chave NFe',
            'Mens.p/ Nota',
            'Qtd. Fiscal',
            'Vlr. Unit.',
            'Valor Total',
            'Valor Frete',
            'Valor Seguro',
            'Valor Despes',
            'Ser. NFP',
            'Num. NFP',
            'Transacao',
            'TIP MOV',
            'Cond. Pg.',
            'Pedido',
            'Sts. Fiscal',
            'Data Transac',
            'Transf.Serv.',
            'Num.Aut.',
            'ID Moviment.',
            'SubTipo Ctrl',
            'Desc Subtipo',
            'Fil. Origem',
            'Nr Aviso',
            'DCO',
            'Seq. DCO',
            'Seq. NLN',
            'Ins.Estadual',
            'Presença Com',
            'Cod Intermed',
          ],
          rows: const [],
        );
      case 3:
        return ResponsiveTable(
          headers: const [
            'Item Rom.',
            'Cod.Entidade',
            'Loj.Entidade',
            'Nom.Entidade',
            'Nom.Loj.Ent.',
            'Cod. Safra',
            'Talhao',
            'Cod. Produto',
            'Des. Produto',
            'Unid.Med.',
            'Local',
            'Cod. Instr.',
            'Contrato',
            'Desc.Contr.',
            'Oper.Fis.',
            'TES',
            'Perc.Div.',
            'Qtd. Fisica',
            'Lote',
            'Form.Prop.',
            'Serie NF',
            'Numero NF',
            'Item DocFis',
            'Emissao NF',
            'Especie NF',
            'Chave NFe',
            'Mens.p/ Nota',
            'Qtd. Fiscal',
            'Vlr. Unit.',
            'Valor Total',
            'Valor Frete',
            'Valor Seguro',
            'Valor Despes',
            'Ser. NFP',
            'Num. NFP',
            'Transacao',
            'TIP MOV',
            'Cond. Pg.',
            'Pedido',
            'Sts. Fiscal',
            'Data Transac',
            'Transf.Serv.',
            'Num.Aut.',
            'ID Moviment.',
            'SubTipo Ctrl',
            'Desc Subtipo',
            'Fil. Origem',
            'Nr Aviso',
            'DCO',
            'Seq. DCO',
            'Seq. NLN',
            'Ins.Estadual',
            'Presença Com',
            'Cod Intermed',
          ],
          rows: const [],
        );
      default:
        return const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text('Outros Formulários'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarComponent(title: 'Romaneio com Pesagem'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBarComponent(
              controller: controller.tabController,
              tabs: controller.tabs,
            ),
            AnimatedBuilder(
              animation: controller.tabController,
              builder: (context, _) {
                return _getFormByTabIndex(controller.tabController.index);
              },
            ),
            const SizedBox(height: 12),
            TabBarComponent(
              controller: controller.tabTabelaController,
              tabs: controller.tabsTabela,
            ),

            AnimatedBuilder(
              animation: controller.tabController,
              builder: (context, _) {
                return _getTableByTabIndex(
                  controller.tabTabelaController.index,
                );
              },
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ButtonComponent(
                text: 'Salvar',
                onPressed: () {
                  // Lógica de gravação do formulário
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrincipalForm extends StatelessWidget {
  PrincipalForm({super.key});

  final controller = Get.find<RomaneioCadastroController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Principal',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          InputComponent(
            label: 'Código Romaneio',
            hintText: 'Digite o código',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Tipo',
              hintText: 'Escolha o tipo',
              value: controller.selectedTipo.value,
              items: controller.tipo,
              onChanged: (newValue) => controller.selectedTipo.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Contrato',
              hintText: 'Escolha o contrato',
              value: controller.selectedContrato.value,
              items: controller.contratos,
              onChanged:
                  (newValue) => controller.selectedContrato.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Número Autorização',
              hintText: 'Escolha a autorização',
              value: controller.selectedAutorizacao.value,
              items: controller.autorizacao,
              onChanged:
                  (newValue) => controller.selectedAutorizacao.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Número Placa',
              hintText: 'Escolha a placa',
              value: controller.selectedPlacas.value,
              items: controller.placas,
              onChanged:
                  (newValue) => controller.selectedPlacas.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Código Transporte',
              hintText: 'Escolha o transporte',
              value: controller.selectedTransporte.value,
              items: controller.transportes,
              onChanged:
                  (newValue) => controller.selectedTransporte.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Código Motorista',
              hintText: 'Escolha o motorista',
              value: controller.selectedMotorista.value,
              items: controller.motoristas,
              onChanged:
                  (newValue) => controller.selectedMotorista.value = newValue,
            ),
          ),
        ],
      ),
    );
  }
}

class AnaliseForm extends StatelessWidget {
  AnaliseForm({super.key});

  final controller = Get.find<RomaneioCadastroController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Análise',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Código da Safra',
              hintText: 'Escolha a safra',
              value: controller.selectedTipo.value,
              items: controller.tipo,
              onChanged: (newValue) => controller.selectedTipo.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Ticket',
            hintText: 'Digite o ticket',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Tabela',
            hintText: 'Digite o ticket',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Talhão',
            hintText: 'Digite o ticket',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Variedade',
            hintText: 'Digite o ticket',
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Unidade Beneficiamento',
            hintText: 'Digite o ticket',
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}

class PesagemForm extends StatelessWidget {
  PesagemForm({super.key});

  final controller = Get.find<RomaneioCadastroController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pesagem',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Data Peso 1',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Hora Peso 1',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Pesagem 1',
            hintText: '0,000',
            enabled: false,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Mod. Pes 1',
            hintText: '0,000',
            enabled: false,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Data Peso 2',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Hora Peso 2',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Pesagem 2',
            hintText: '0,000',
            enabled: false,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Mod. Pes 2',
            hintText: '0,000',
            enabled: false,
            controller: TextEditingController(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Peso Subtotal',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Peso Desconto',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Peso Base',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Peso D.Extr',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Peso Liquido',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Sts. Pesagem',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          InputComponent(
            label: 'Qtd. Fisica',
            hintText: '',
            enabled: false,
            controller: TextEditingController(),
          ),
        ],
      ),
    );
  }
}

class ControleForm extends StatelessWidget {
  ControleForm({super.key});

  final controller = Get.find<RomaneioCadastroController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Controle',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Sts.Romaneio',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Sts.Fiscal',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Sts.Contrat',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Fil.Relacion',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Rom.Relacion',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Data.Rom.',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: InputComponent(
                  label: 'Data. Transac',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InputComponent(
                  label: 'Tipo Control',
                  hintText: '',
                  enabled: false,
                  controller: TextEditingController(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(
            () => SelectComponent<String>(
              labelText: 'Código da Safra',
              hintText: 'Escolha a safra',
              value: controller.selectedTipo.value,
              items: [
                SelectOption(label: 'Sim', value: '0'),
                SelectOption(label: 'Não', value: '1'),
              ],
              onChanged: (newValue) => controller.selectedTipo.value = newValue,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
