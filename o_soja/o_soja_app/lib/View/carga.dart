import 'package:flutter/material.dart';
import 'package:o_soja/controller/carga_control.dart';


class FormCargaScreen extends StatefulWidget {
  const FormCargaScreen({super.key});

  @override
  State<FormCargaScreen> createState() => _FormCargaScreenState();
}

class _FormCargaScreenState extends State<FormCargaScreen> {
  // Instancia o Controller
  final CargaController _controller = CargaController();

  @override
  void initState() {
    super.initState();
    // Ouve mudanças no controller para atualizar a tela
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Carga"),
        backgroundColor: const Color(0xFF1B5E20), // Verde
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _controller.currentStep,
        onStepContinue: () => _controller.nextStep(context, 3), // 3 é o numero de passos
        onStepCancel: _controller.prevStep,
        
        // Customização dos Botões do Stepper
        controlsBuilder: (context, details) {
          final isLastStep = _controller.currentStep == 2;
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLastStep ? Colors.orange[800] : Colors.green[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(isLastStep ? 'FINALIZAR & RASTREAR' : 'PRÓXIMO'),
                  ),
                ),
                if (_controller.currentStep > 0) ...[
                  const SizedBox(width: 12),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Voltar'),
                  ),
                ]
              ],
            ),
          );
        },
        
        steps: [
          // Passo 1
          Step(
            title: const Text('Identificação'),
            content: TextFormField(
              controller: _controller.placaController,
              decoration: const InputDecoration(
                labelText: 'Placa do Caminhão', 
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_shipping)
              ),
            ),
            isActive: _controller.currentStep >= 0,
            state: _controller.currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          
          // Passo 2
          Step(
            title: const Text('Motorista'),
            content: TextFormField(
              controller: _controller.motoristaController,
              decoration: const InputDecoration(
                labelText: 'Nome do Motorista', 
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person)
              ),
            ),
            isActive: _controller.currentStep >= 1,
            state: _controller.currentStep > 1 ? StepState.complete : StepState.editing,
          ),
          
          // Passo 3
          Step(
            title: const Text('Carga'),
            content: TextFormField(
              controller: _controller.pesoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso Estimado (kg)', 
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.scale),
                suffixText: 'kg'
              ),
            ),
            isActive: _controller.currentStep >= 2,
            state: _controller.currentStep == 2 ? StepState.editing : StepState.complete,
          ),
        ],
      ),
    );
  }
}