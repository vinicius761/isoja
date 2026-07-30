import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopMessageComponent {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
  }) {
    // Se já houver um pop aberto, fecha antes de abrir o novo
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.dialog(
      // Dialog básico do material
      Dialog(
        backgroundColor: backgroundColor,
      
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Faz o card se ajustar ao tamanho do texto
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha do Título + Botão Fechar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.close, color: textColor, size: 22),
                    onPressed: () {
                      if (Get.isDialogOpen ?? false) {
                        Get.back(); // Fecha o Dialog no GetX
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              // Conteúdo da mensagem
              Text(
                message,
                style: TextStyle(
                  color: textColor.withOpacity(0.9),
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // 🔒 Impede fechar ao clicar fora da tela (obriga a usar o X)
    );
  }

  // 🚀 Atalhos prontos (Idênticos ao que você já usa no Controller)
  static void success(String message) {
    show(title: "Sucesso", message: message, backgroundColor: Colors.green);
  }

  static void error(String message) {
    show(title: "Erro", message: message, backgroundColor: Colors.red);
  }

  static void warning(String message) {
    show(title: "Aviso", message: message, backgroundColor: Colors.orange, textColor: Colors.black);
  }

  static void info(String message) {
    show(title: "Informação", message: message, backgroundColor: Colors.blue);
  }
}