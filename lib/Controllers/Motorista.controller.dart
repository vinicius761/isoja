import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Api/Motorista.api.dart';
import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Model/Motorista.model.dart';

class MotoristaController extends GetxController {
  // Chaves para validação de cada etapa
  final formKeyStep1 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();
  final formKeyStep3 = GlobalKey<FormState>();
  final formKeyStep4 = GlobalKey<FormState>();

  // Status de carregamento
  var isLoading = false.obs;

  // Lista para a tela de listagem
  RxList<Motorista> motoristas = <Motorista>[].obs;
  final api = MotoristaApi();

  // Step 1: Dados Pessoais
  final codController = TextEditingController();
  final nomeController = TextEditingController();
  final nreduzController = TextEditingController();
  final cgcController = TextEditingController();
  final matController = TextEditingController();
  final datnasController = TextEditingController();
  final estcivController = TextEditingController();

  // Step 2: Documentos e CNH
  final rgController = TextEditingController();
  final rgorgController = TextEditingController();
  final rgestController = TextEditingController();
  final numcnhController = TextEditingController();
  final regcnhController = TextEditingController();
  final catcnhController = TextEditingController();
  final dtecnhController = TextEditingController();
  final dtvcnhController = TextEditingController();
  final muncnhController = TextEditingController();
  final estcnhController = TextEditingController();

  // Step 3: Endereço e Contato
  final endController = TextEditingController();
  final bairroController = TextEditingController();
  final cepController = TextEditingController();
  final munController = TextEditingController();
  final estController = TextEditingController();
  final dddController = TextEditingController();
  final telController = TextEditingController();
  final emailController = TextEditingController();
  final controller = Get.find<LoginController>();

  // Step 4: Vínculos e Gerenciamento de Risco
  final tipmot = '1'.obs; // 1 - Próprio, 2 - Terceiro, 3 - Agregado
  final fornecController = TextEditingController();
  final numsegController = TextEditingController();
  var carper = false.obs; // Carga perigosa
  var ativo = true.obs;

  void setTipoMotorista(String? value) {
    if (value != null) tipmot.value = value;
  }

  String get descricaoTipoMotorista {
    switch (tipmot.value) {
      case '1':
        return '1 - Próprio';
      case '2':
        return '2 - Terceiro';
      case '3':
        return '3 - Agregado';
      default:
        return '1 - Próprio';
    }
  }

  @override
  onInit() {
    buscaMotoristas();
    super.onInit();
  }

  Future<void> buscaMotoristas() async {
    isLoading.value = true;
    try {
      final res = await api.buscaMotorista();

      if (res.statusCode == 200 && res.body != null) {
        final dynamic bodyData = res.body;

        if (bodyData is List) {
          final List<Motorista> listaNovosMotorista =
              bodyData.map((item) => Motorista.fromJson(item)).toList();

          motoristas.assignAll(listaNovosMotorista);
        }
      }
    } catch (e) {
      print('Erro ao buscar motoristas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Motorista? buscarPorDa4Cod(int da4Cod) {
    final motorista = motoristas.firstWhereOrNull((m) => m.da4Cod == da4Cod);
    print(motorista!.da4Cod);
    return motorista;
  }

  Future<void> salvar() async {
    isLoading.value = true;
    try {
      final novoMotorista = Motorista(
        da4Nome: nomeController.text,
        da4Nreduz: nreduzController.text,
        da4Cgc: cgcController.text,
        da4Mat: matController.text,
        da4Datnas: datnasController.text,
        da4Estciv: estcivController.text,
        da4Rg: rgController.text,
        da4Rgorg: rgorgController.text,
        da4Rgest: rgestController.text,
        da4Numcnh: numcnhController.text,
        da4Regcnh: regcnhController.text,
        da4Catcnh: catcnhController.text,
        da4Dtecnh: dtecnhController.text,
        da4Dtvcnh: dtvcnhController.text,
        da4Muncnh: muncnhController.text,
        da4Estcnh: estcnhController.text,
        da4End: endController.text,
        da4Bairro: bairroController.text,
        da4Cep: cepController.text,
        da4Mun: munController.text,
        da4Est: estController.text,
        da4Ddd: dddController.text,
        da4Tel: telController.text,
        da4Email: emailController.text,
        da4Tipmot: tipmot.value,
        da4Fornec: fornecController.text,
        da4Numseg: numsegController.text,
        da4Carper: carper.value ? '1' : '2',
        da4Status: ativo.value ? '1' : '2',
        da4Filial: controller.userFilialSelecionada.value!.codFilial.toString(),
        da4Loja: '01',
        da4Filbas: '01',
        da4Filatu: '01',
        da4Pais: '105',
        da4Blqmot: '2',
        da4Valseg: 0.0,
        da4Altura: 0.0,
        da4Peso: 0.0,
        da4Ajuda1: '',
        da4Ajuda2: '',
        da4Ajuda3: '',
        da4Pai: '',
        da4Mae: '',
        da4Telrec: '',
        da4Falcom: '',
        da4Corpel: '',
        da4Corcab: '',
        da4Corbar: '',
        da4Corolh: '',
        da4Sinais: '',
        da4Libseg: '',
        da4Dtivsg: '',
        da4Dtfvsg: '',
        da4Comiss: '',
        da4Bitmap: '',
        da4Rgdt: '',
        da4Idope: '',
        da4Codmun: '',
        da4Applog: '',
        da4Codcli: '',
        da4Lojcli: '',
      );

      final res = await api.criarMotorista(novoMotorista);

      if (res.statusCode == 201) {
        Get.back();
        ToastMessageComponent.success('Motorista cadastrado com sucesso!');
      }

      await buscaMotoristas();
    } catch (e) {
      ToastMessageComponent.error('Falha ao salvar motorista: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codController.dispose();
    nomeController.dispose();
    nreduzController.dispose();
    cgcController.dispose();
    matController.dispose();
    datnasController.dispose();
    estcivController.dispose();
    rgController.dispose();
    rgorgController.dispose();
    rgestController.dispose();
    numcnhController.dispose();
    regcnhController.dispose();
    catcnhController.dispose();
    dtecnhController.dispose();
    dtvcnhController.dispose();
    muncnhController.dispose();
    estcnhController.dispose();
    endController.dispose();
    bairroController.dispose();
    cepController.dispose();
    munController.dispose();
    estController.dispose();
    dddController.dispose();
    telController.dispose();
    emailController.dispose();
    fornecController.dispose();
    numsegController.dispose();
    super.onClose();
  }
}
