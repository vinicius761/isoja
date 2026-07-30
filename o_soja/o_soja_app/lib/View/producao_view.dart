import 'package:flutter/material.dart';
import 'package:o_soja/controller/producao_control.dart';

class FormProducaoScreen extends StatefulWidget {
  const FormProducaoScreen({super.key});

  @override
  State<FormProducaoScreen> createState() => _FormProducaoScreenState();
}

class _FormProducaoScreenState extends State<FormProducaoScreen> {
  final ProducaoController _controller = ProducaoController();

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
        title: const Text("Apontar Produção"),
        backgroundColor: const Color(0xFF2E7D32), // Verde Escuro Agro
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
            tooltip: 'Histórico',
          ),
        ],
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _controller.currentStep,
        onStepContinue: () => _controller.nextStep(context, 3),
        onStepCancel: _controller.prevStep,

        // Customização dos Botões
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
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                    ),
                    child: Text(
                      isLast ? 'CONFIRMAR COLHEITA' : 'CONTINUAR',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                if (_controller.currentStep > 0) ...[
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: details.onStepCancel,
                    child: const Text(
                      'Voltar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ],
            ),
          );
        },

        steps: [
          // --- PASSO 1: LOCALIZAÇÃO E ORIGEM ---
          Step(
            title: const Text('Origem da Colheita'),
            subtitle: const Text('Onde você está colhendo?'),
            isActive: _controller.currentStep >= 0,
            state: _controller.currentStep > 0
                ? StepState.complete
                : StepState.editing,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListenableBuilder(
                  listenable: _controller,
                  builder: (context, child) {
                    return DropdownButtonFormField<String>(
                      value: _controller.talhaoSelecionado, // Usa o getter
                      items:
                          _controller.dropdownTalhoes, // Usa a lista pré-pronta
                      onChanged: (val) =>
                          _controller.talhaoSelecionado = val, // Usa o setter
                      decoration: const InputDecoration(
                        labelText: 'Selecione o Talhão',
                        prefixIcon: Icon(Icons.map_outlined),
                        border: OutlineInputBorder(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Botão de Captura de GPS
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _controller.capturarGps,
                        icon: _controller.isGpsLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.gps_fixed, color: Colors.green),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Coordenada do Talhão",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _controller.coordenadasGPS,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- PASSO 2: MAQUINÁRIO ---
          Step(
            title: const Text('Equipamento'),
            subtitle: const Text('Qual máquina está operando?'),
            isActive: _controller.currentStep >= 1,
            state: _controller.currentStep > 1
                ? StepState.complete
                : StepState.editing,
            content: Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Máquina / Colheitadeira',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.agriculture), // Ícone de trator
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  value: _controller.maquinaSelecionada,
                  items: _controller.listaMaquinas
                      .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                      .toList(),
                  onChanged: (val) => _controller.maquinaSelecionada = val,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _controller.culturaController,
                  readOnly: true, // Campo travado só para visualização
                  decoration: const InputDecoration(
                    labelText: 'Cultura Atual',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.grass),
                    filled: true,
                    fillColor: Color(
                      0xFFE8F5E9,
                    ), // Fundo verdinho claro para indicar readonly
                  ),
                ),
              ],
            ),
          ),

          // --- PASSO 3: QUANTIDADE (Opcional ou Parcial) ---
          Step(
            title: const Text('Volume Parcial'),
            subtitle: const Text('Quantidade descarregada'),
            isActive: _controller.currentStep >= 2,
            state: _controller.currentStep == 2
                ? StepState.editing
                : StepState.complete,
            content: Column(
              children: [
                TextFormField(
                  controller: _controller.pesoController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Peso / Quantidade',
                    hintText: '0.00',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.scale),
                    suffixText: 'kg',
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "* Se não houver balança no local, deixar em branco.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
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
