import 'dart:io';
import 'dart:convert';

import 'package:isoja/Controllers/Impressora.controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

Future<void> imprimirEtiquetaL42({
  required String ip,
  required String textoPrincipal,
  int porta = 9100,
  double larguraEtiquetaMm = 100.0,
}) async {
  final controller = Get.put(ControllerConfigImpressora());
  final config = await controller.buscarConfiguracao();

  try {
    print("Conectando na impressora ${controller.ipBalanca}...");

    Socket socket = await Socket.connect(
      config!.ipBalanca,
      int.parse(config.portBalanca!),
      timeout: Duration(seconds: 5),
    );

    StringBuffer buffer = StringBuffer();
    buffer.write("N\n");

    // 1. Definição da Etiqueta 100x50 mm em pontos (8 pontos por mm)
    int larguraTotalPontos = 800; // 100mm * 8
    int alturaTotalPontos = 400; // 50mm * 8

    // 2. Cálculo da Largura (Fonte 5 com multiplicador horizontal 2 = ~48 pontos por caractere)
    int larguraTextoPontos = textoPrincipal.length * 48;
    int coordenadaX = ((larguraTotalPontos - larguraTextoPontos) / 2).round();
    if (coordenadaX < 0) coordenadaX = 0;

    // 3. Cálculo da Altura (Fonte 5 com multiplicador vertical 2 = 96 pontos de altura real)
    int alturaTextoPontos = 96;
    int coordenadaY = ((alturaTotalPontos - alturaTextoPontos) / 2).round();
    if (coordenadaY < 0) coordenadaY = 0;

    // 4. Comando EPL2 enviado com as coordenadas perfeitamente centralizadas
    buffer.write("A$coordenadaX,$coordenadaY,0,5,2,2,N,\"$textoPrincipal\"\n");

    buffer.write("P1\n");

    socket.add(latin1.encode(buffer.toString()));

    await socket.flush();
    socket.destroy();
    print("Comando EPL2 enviado com sucesso!");
  } on SocketException catch (e) {
    print("Erro de conexão: ${e.message} (Código OS: ${e.osError?.errorCode})");
    rethrow;
  } catch (e) {
    print("Erro inesperado: $e");
    rethrow;
  }
}
