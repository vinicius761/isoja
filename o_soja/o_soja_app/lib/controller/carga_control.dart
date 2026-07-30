import 'package:flutter/material.dart';

class CargaController extends ChangeNotifier {
  // Estado Atual do Passo a Passo
  int currentStep = 0;

  // Controladores dos Campos de Texto
  final placaController = TextEditingController();
  final motoristaController = TextEditingController();
  final pesoController = TextEditingController();

  // Função para avançar passo
  void nextStep(BuildContext context, int totalSteps) {
    if (currentStep < totalSteps - 1) {
      currentStep++;
      notifyListeners(); // Avisa a View para redesenhar
    } else {
      _finalizarProcesso(context);
    }
  }

  // Função para voltar passo
  void prevStep() {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    }
  }

  // Simula o salvamento e feedback
  void _finalizarProcesso(BuildContext context) {
    // AQUI ENTRARIA A LÓGICA DE BANCO DE DADOS / API
    print("Salvando Carga: ${placaController.text} - ${pesoController.text}kg");
    
    Navigator.pop(context); // Fecha a tela
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Carga registrada e GPS iniciado!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Limpeza de memória
  @override
  void dispose() {
    placaController.dispose();
    motoristaController.dispose();
    pesoController.dispose();
    super.dispose();
  }
}