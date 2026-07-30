import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Select.component.dart';

class RomaneioCadastroController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  final List<String> tabs = [
    'Principal',
    'Análise',
    'Pesagem',
    'Controle',
    'Outros',
  ];

  late TabController tabBodyController;
  final List<String> tabsBody = [
    'Classificação',
    'Historico',
    'Comercialização',
    'Integração',
  ];

  final List<SelectOption<String>> tipo = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedTipo = RxnString();

  final List<SelectOption<String>> contratos = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedContrato = RxnString();

  final List<SelectOption<String>> autorizacao = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedAutorizacao = RxnString();

  final List<SelectOption<String>> placas = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedPlacas = RxnString();

  final List<SelectOption<String>> transportes = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedTransporte = RxnString();

  final List<SelectOption<String>> motoristas = const [
    SelectOption(
      value: '(E) Entrada por Produção',
      label: '(E) Entrada por Produção',
    ),
    SelectOption(
      value: '(S) Remessa para Depósito',
      label: '(S) Remessa para Depósito',
    ),
    SelectOption(
      value: '(E) Entrda para Depósito',
      label: '(E) Entrda para Depósito',
    ),
    SelectOption(value: '(S) Saída para Venda', label: '(S) Saída para Venda'),
    SelectOption(
      value: '(E) Entrada por Compra',
      label: '(E) Entrada por Compra',
    ),
    SelectOption(
      value: '(S) Devolução de Depósito',
      label: '(S) Devolução de Depósito',
    ),
    SelectOption(
      value: '(E) Devolução de Remessa',
      label: '(E) Devolução de Remessa',
    ),
  ];

  final selectedMotorista = RxnString();

  late TabController tabTabelaController;

  final List<String> tabsTabela = [
    'Classificação',
    'Histórico Classificação',
    'Comercialização',
    'Integração Romaneio',
  ];

  @override
  void onInit() {
    super.onInit();
    // Inicialização dos controllers de abas
    tabController = TabController(length: tabs.length, vsync: this);
    tabBodyController = TabController(length: tabsBody.length, vsync: this);

    // INICIALIZAÇÃO NECESSÁRIA:
    tabTabelaController = TabController(length: tabsTabela.length, vsync: this);
  }

  @override
  void onClose() {
    // É importante fazer o dispose de todos os TabControllers
    tabController.dispose();
    tabBodyController.dispose();
    tabTabelaController.dispose();
    super.onClose();
  }
}
