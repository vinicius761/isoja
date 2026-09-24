import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/LeitorRfid.controller.dart';

class LeitorRfidScreen extends StatelessWidget {
  const LeitorRfidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LeitorRfidController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Tela com RFID'),
        backgroundColor: AppColors.background,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botão de Conectar / Reconectar RFID
              Obx(() {
                final isConectado = controller.isConectado.value;
                final isCarregando = controller.isConectando.value;

                return ElevatedButton.icon(
                  onPressed:
                      isCarregando
                          ? null
                          : () async {
                            await controller.handleConexao();
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isConectado ? Colors.green : AppColors.background,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  icon:
                      isCarregando
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                          : Icon(
                            isConectado
                                ? Icons.sync
                                : Icons.bluetooth_connected,
                            color: Colors.white,
                          ),
                  label: Text(
                    isCarregando
                        ? 'Processando...'
                        : (isConectado ? 'Reconectar RFID' : 'Conectar RFID'),
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }),

              const SizedBox(height: 30),

              const Text(
                'Aproxime a tag RFID ou escaneie o código de barras',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Exibe o status da caixa de diálogo
              Obx(
                () => Text(
                  controller.isDialogOpen.value
                      ? 'Leitor Ativo em Dialog...'
                      : 'Aguardando Leitura...',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),

              const SizedBox(height: 30),

              // Exibe a tag ou código de barras lido na tela
              Obx(
                () => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: Text(
                    controller.ultimaTagLida.value.isEmpty
                        ? 'Nenhuma tag lida'
                        : controller.ultimaTagLida.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
