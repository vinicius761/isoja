import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Api/Veiculo.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Model/Veiculo.model.dart';

class VeiculoController extends GetxController {
  // Chaves para validação das etapas do formulário
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();
  final formKeyStep4 = GlobalKey<FormState>();
  final formKeyStep5 = GlobalKey<FormState>();

  // Controllers - Identificação e Localização
  final filialController = TextEditingController(text: '01');
  final codController = TextEditingController();
  final descricaoController = TextEditingController();
  final placaController = TextEditingController();
  final estplaController = TextEditingController();
  final codmunController = TextEditingController();
  final munplaController = TextEditingController();
  final tagController = TextEditingController();

  // Controllers - Documentação
  final chassiController = TextEditingController();
  final renavamController = TextEditingController();
  final anoFabController = TextEditingController();
  final anoModController = TextEditingController();
  final marcaController = TextEditingController();
  final corController = TextEditingController();
  final tipoVeiculoController = TextEditingController();
  final qtdEixosController = TextEditingController(text: '0');

  // Controllers - Capacidades
  final capacidadeNominalController = TextEditingController();
  final capacidadeMaximaController = TextEditingController();
  final taraController = TextEditingController();
  final volumeMaximoController = TextEditingController();

  // Controllers - Vínculos
  final motoristaController = TextEditingController();
  final fornecedorController = TextEditingController();
  final grupoVeiculoController = TextEditingController();

  // Controllers - Seguro e Operacional
  final apoliceSeguroController = TextEditingController();
  final civController = TextEditingController();

  // Estados Reativos
  var tipoFrota = '1'.obs; // 1 = Própria, 2 = Terceiro, 3 = Agregado
  var ativo = true.obs;
  var possuiRastreador = true.obs;

  final api = VeiculoApi();
  final controller = Get.find<LoginController>();

  RxList<Veiculo> vaiculos = <Veiculo>[].obs;

  @override
  void onClose() {
    filialController.dispose();
    codController.dispose();
    descricaoController.dispose();
    placaController.dispose();
    estplaController.dispose();
    codmunController.dispose();
    munplaController.dispose();
    tagController.dispose();
    chassiController.dispose();
    renavamController.dispose();
    anoFabController.dispose();
    anoModController.dispose();
    marcaController.dispose();
    corController.dispose();
    tipoVeiculoController.dispose();
    qtdEixosController.dispose();
    capacidadeNominalController.dispose();
    capacidadeMaximaController.dispose();
    taraController.dispose();
    volumeMaximoController.dispose();
    motoristaController.dispose();
    fornecedorController.dispose();
    grupoVeiculoController.dispose();
    apoliceSeguroController.dispose();
    civController.dispose();
    super.onClose();
  }

  buscaVeiculos() {}

  void setTipoFrota(String? val) {
    if (val != null) tipoFrota.value = val;
  }

  String get descricaoTipoFrota {
    switch (tipoFrota.value) {
      case '1':
        return 'Própria';
      case '2':
        return 'Terceiro';
      case '3':
        return 'Agregado';
      default:
        return 'Não especificado';
    }
  }

  Veiculo get toModel => Veiculo(
    filial: controller.userFilialSelecionada.value!.codFilial.toString(),
    cod: codController.text,
    descricao: descricaoController.text,
    placa: placaController.text,
    estpla: estplaController.text,
    codmun: codmunController.text,
    munpla: munplaController.text,
    tag: tagController.text,
    ativo: ativo.value ? "1" : "2",
    capacn: double.tryParse(capacidadeNominalController.text) ?? 0.0,
    capacm: double.tryParse(capacidadeMaximaController.text) ?? 0.0,
    tara: double.tryParse(taraController.text) ?? 0.0,
    volmax: double.tryParse(volumeMaximoController.text) ?? 0.0,
    anofab: anoFabController.text,
    anomod: anoModController.text,
    chassi: chassiController.text,
    renava: renavamController.text,
    marvei: marcaController.text,
    corvei: corController.text,
    tipvei: tipoVeiculoController.text,
    qtdeix: double.tryParse(qtdEixosController.text) ?? 0.0,
    frovei: tipoFrota.value,
    motori: motoristaController.text,
    codfor: fornecedorController.text,
    codgru: grupoVeiculoController.text,
    libseg: apoliceSeguroController.text,
    civ: civController.text,
    veiras: possuiRastreador.value ? "S" : "N",
    unitiz: 'TON',
  );

  // Leitura do modelo ajustada
  void loadFromModel(Veiculo model) {
    filialController.text = model.filial;
    codController.text = model.cod;
    descricaoController.text = model.descricao;
    placaController.text = model.placa;
    estplaController.text = model.estpla;
    codmunController.text = model.codmun;
    munplaController.text = model.munpla;
    tagController.text = model.tag;
    ativo.value = model.ativo == "1";
    capacidadeNominalController.text = model.capacn.toString();
    capacidadeMaximaController.text = model.capacm.toString();
    taraController.text = model.tara.toString();
    volumeMaximoController.text = model.volmax.toString();
    anoFabController.text = model.anofab;
    anoModController.text = model.anomod;
    chassiController.text = model.chassi;
    renavamController.text = model.renava;
    marcaController.text = model.marvei;
    corController.text = model.corvei;
    tipoVeiculoController.text = model.tipvei;
    qtdEixosController.text = model.qtdeix.toString();
    tipoFrota.value = model.frovei;
    motoristaController.text = model.motori;
    fornecedorController.text = model.codfor;
    grupoVeiculoController.text = model.codgru;
    apoliceSeguroController.text = model.libseg;
    civController.text = model.civ;
    possuiRastreador.value = model.veiras == "S";
  }

  Future<void> salvarVeiculo() async {
    try {
      final Veiculo veiculo = toModel;

      final response = await api.criarVeiculo(veiculo);

      if (response.statusCode == 201) {
        ToastMessageComponent.success('Veiculo salvo com sucesso.');
        Get.back();
      }
    } catch (e) {
      ToastMessageComponent.error('Erro ao cadastrar veículo.');
    }
  }
}
