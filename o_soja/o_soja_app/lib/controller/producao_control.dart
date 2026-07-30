import 'package:flutter/material.dart';




class ProducaoController extends ChangeNotifier {

    // -- Dados Produtivos --
  final culturaController = TextEditingController(text: "Soja");
  final pesoController = TextEditingController();

  // -- Simulando GPS --
  String coordenadasGPS = "Aguardando captura...";
  bool isGpsLoading = false;

  // Listas de Dados (Dados Brutos)
  final List<String> listaTalhoes = ['Talhão 01', 'Talhão 02', 'Várzea 03'];
  final List<String> listaMaquinas = ['Colheitadeira 01', 'Colheitadeira 02', 'Colheitadeira 03'];

  // Listas de Itens Pré-construídas: O REMÉDIO CONTRA ESTOURO DE MEMÓRIA
  // Criamos as listas de Widgets uma única vez
  late List<DropdownMenuItem<String>> dropdownTalhoes;
  late List<DropdownMenuItem<String>> dropdownMaquinas;
  // Construtor vazio, já que não estamos usando o banco ainda
  ProducaoController() {
    _inicializarListas();
  }

  int currentStep = 0;

  // -- Identificação da Origem (Variáveis Privadas) --
  String? _talhaoSelecionado;
  String? _maquinaSelecionada;

  // Getters para a View ler os valores
  String? get talhaoSelecionado => _talhaoSelecionado;
  String? get maquinaSelecionada => _maquinaSelecionada;

  // Setters com notifyListeners(): O REMÉDIO CONTRA O TRAVAMENTO
  set talhaoSelecionado(String? valor) {
    if (_talhaoSelecionado == valor) return; // Evita rebuild desnecessário
    _talhaoSelecionado = valor;
    notifyListeners(); 
  }

  set maquinaSelecionada(String? valor) {
    if (_maquinaSelecionada == valor) return;
    _maquinaSelecionada = valor;
    notifyListeners();
  }


  void _inicializarListas() {
    dropdownTalhoes = listaTalhoes
        .map((t) => DropdownMenuItem<String>(value: t, child: Text(t)))
        .toList();

    dropdownMaquinas = listaMaquinas
        .map((m) => DropdownMenuItem<String>(value: m, child: Text(m)))
        .toList();
  }

  // -- Navegação do Stepper --
  void nextStep(BuildContext context, int totalSteps) {
    if (currentStep < totalSteps - 1) {
      currentStep++;
      notifyListeners();
    } else {
      _finalizarProcesso(context);
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  Future<void> capturarGps() async {
    isGpsLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    coordenadasGPS = "-15.6032, -56.0921 (Precisão: 4m)";
    isGpsLoading = false;
    notifyListeners();
  }

  void _finalizarProcesso(BuildContext context) {
    // Por enquanto apenas printa, já que não tem banco
    print("RESUMO: $talhaoSelecionado | $maquinaSelecionada | ${pesoController.text}");
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Apontamento realizado com sucesso!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    culturaController.dispose();
    pesoController.dispose();
    super.dispose();
  }
}