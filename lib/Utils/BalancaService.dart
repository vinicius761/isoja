import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:isoja/Components/ToastMessage.component.dart';
import 'package:isoja/Controllers/Balanca.controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class BalancaService {
  String ip = '';
  final controller = Get.put(ControllerConfigBalanca());

  int porta = 0;
  Socket? _socket;
  Timer? _timerDeSeguranca;

  Stream<double?> lerPeso() async* {
    final config = await controller.buscarConfiguracao();

    if (config!.ipBalanca! == '' &&
        config.portBalanca! == '' &&
        config.portBalanca! == null &&
        config!.ipBalanca! == null) {
      ToastMessageComponent.info('Configure a  IP e a Porta');
      fecharConexao();
      return;
    }

    ip = config.ipBalanca!;
    porta = int.parse(config.portBalanca!);

    try {
      _socket = await Socket.connect(
        ip,
        porta,
        timeout: const Duration(seconds: 2),
      );
      _socket!.setOption(SocketOption.tcpNoDelay, true);

      print("Conectado à balança em modo Raw TCP!");

      _timerDeSeguranca = Timer(const Duration(seconds: 2), () {
        fecharConexao();
      });

      yield* _socket!
          .map((data) {
            final dadosLimpos =
                data
                    .where((byte) => byte >= 32 || byte == 10 || byte == 13)
                    .toList();

            String resultado = latin1.decode(dadosLimpos);
            print("Dados brutos (Raw) recebidos: $resultado");

            double? peso = extrairPeso(resultado);
            print("Peso processado: $peso");

            return peso;
          })
          .handleError((error) {
            ToastMessageComponent.error("Erro na conexão Raw: $error");
            fecharConexao();
          });

      // Evento de finalização
      _timerDeSeguranca?.cancel();
      fecharConexao();
    } catch (e) {
      ToastMessageComponent.error("Erro ao conectar modo Raw: $e");
      print("Erro ao conectar modo Raw: $e");
      // ToastMessageComponent.error("Não foi possível conectar: $e");
    }
  }

  double? extrairPeso(String rawData) {
    final regex = RegExp(r'[0-9]+(\.[0-9]+)?');
    final match = regex.stringMatch(rawData);
    return match != null ? double.tryParse(match) : null;
  }

  void fecharConexao() {
    print("Limpando recursos e fechando Socket...");
    _timerDeSeguranca?.cancel(); // Para o timer se ele ainda estiver rodando
    _socket?.destroy();
    _socket = null;
  }
}
