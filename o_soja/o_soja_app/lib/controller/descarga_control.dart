import 'package:flutter/material.dart';

class DescargaController extends ChangeNotifier {
  int currentStep = 0;

  // -- Identificação --
  final ticketController = TextEditingController(); // Código da carga que chegou
  
  // -- Pesagem --
  final pesoBrutoController = TextEditingController();
  final taraController = TextEditingController();
  
  // -- Qualidade --
  final umidadeController = TextEditingController();
  final impurezaController = TextEditingController();
  
  // Variável calculada
  double pesoLiquido = 0.0;

  DescargaController() {
    // Adiciona "ouvintes" para calcular automaticamente quando digitar - Setstate
    
    pesoBrutoController.addListener(_calcularLiquido);
    taraController.addListener(_calcularLiquido);
  }

  void _calcularLiquido() {
    double bruto = double.tryParse(pesoBrutoController.text) ?? 0;
    double tara = double.tryParse(taraController.text) ?? 0;
    
    pesoLiquido = bruto - tara;
    if (pesoLiquido < 0) pesoLiquido = 0;
    
    notifyListeners(); // Atualiza a tela com o novo cálculo
  }

  void nextStep(BuildContext context, int totalSteps) {
    if (currentStep < totalSteps - 1) {
      currentStep++;
      notifyListeners();
    } else {
      _finalizarDescarga(context);
    }
  }

  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  // Simula busca do ticket pelo QR Code - Se for celular Zebra
  void lerQrCode() {
    ticketController.text = "TKT-9023 (Soja)";
    notifyListeners();
  }

  void _finalizarDescarga(BuildContext context) {
    print("Descarga Finalizada: Líquido $pesoLiquido kg | Umidade: ${umidadeController.text}%");
    
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Descarga registrada! Ticket encerrado.'),
        backgroundColor: Colors.blue[800],
      ),
    );
  }

  @override
  void dispose() {
    ticketController.dispose();
    pesoBrutoController.dispose();
    taraController.dispose();
    umidadeController.dispose();
    impurezaController.dispose();
    super.dispose();
  }
}