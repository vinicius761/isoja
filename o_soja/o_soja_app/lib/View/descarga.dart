import 'package:flutter/material.dart';
import 'package:o_soja/controller/descarga_control.dart';

class FormDescargaScreen extends StatefulWidget {
  const FormDescargaScreen({super.key});

  @override
  State<FormDescargaScreen> createState() => _FormDescargaScreenState();
}

class _FormDescargaScreenState extends State<FormDescargaScreen> {
  final DescargaController _controller = DescargaController();

  @override
  void initState() {
    super.initState();
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
        title: const Text("Registro de Descarga"),
        backgroundColor: const Color(0xFF1565C0), // Azul Forte
        foregroundColor: Colors.white,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _controller.currentStep,
        onStepContinue: () => _controller.nextStep(context, 3),
        onStepCancel: _controller.prevStep,
        
        controlsBuilder: (context, details) {
          final isLast = _controller.currentStep == 2;
          return Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1565C0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(isLast ? 'ENCERRAR TICKET' : 'PRÓXIMO'),
                  ),
                ),
                if (_controller.currentStep > 0) ...[
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text('Voltar', style: TextStyle(color: Colors.grey)),
                  ),
                ]
              ],
            ),
          );
        },

        steps: [
          // --- PASSO 1: VINCULAR CARGA ---
          Step(
            title: const Text('Vincular Carga'),
            subtitle: const Text('Qual caminhão chegou?'),
            isActive: _controller.currentStep >= 0,
            state: _controller.currentStep > 0 ? StepState.complete : StepState.editing,
            content: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller.ticketController,
                    decoration: const InputDecoration(
                      labelText: 'Nº do Ticket ou Placa',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.confirmation_number_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Botão de QR Code simulado
                IconButton.filled(
                  onPressed: _controller.lerQrCode,
                  icon: const Icon(Icons.qr_code_scanner),
                  style: IconButton.styleFrom(backgroundColor: Colors.blue[100], foregroundColor: Colors.blue[900]),
                  tooltip: "Ler Ticket",
                )
              ],
            ),
          ),

          // --- PASSO 2: BALANÇA ---
          Step(
            title: const Text('Pesagem'),
            subtitle: const Text('Dados da Balança Rodoviária'),
            isActive: _controller.currentStep >= 1,
            state: _controller.currentStep > 1 ? StepState.complete : StepState.editing,
            content: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller.pesoBrutoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Peso Bruto (kg)', border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _controller.taraController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: 'Tara Veículo (kg)', border: OutlineInputBorder()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // CARD DE DESTAQUE DO CÁLCULO
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Column(
                    children: [
                      Text("PESO LÍQUIDO", style: TextStyle(color: Colors.blue[900], fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(
                        "${_controller.pesoLiquido.toStringAsFixed(0)} kg",
                        style: TextStyle(color: Colors.blue[800], fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // --- PASSO 3: CLASSIFICAÇÃO (Umidade) ---
          Step(
            title: const Text('Qualidade (Classificação)'),
            isActive: _controller.currentStep >= 2,
            state: _controller.currentStep == 2 ? StepState.editing : StepState.complete,
            content: Column(
              children: [
                TextFormField(
                  controller: _controller.umidadeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Umidade (%)',
                    hintText: 'Ex: 14.5',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.water_drop_outlined), // Ícone de gota
                    suffixText: '%',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.impurezaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Impureza / Avariados (%)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.grain), // Ícone de grão
                    suffixText: '%',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}