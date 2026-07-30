import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Buttonbar.component.dart';
import 'package:isoja/Utils/Tema.dart';

enum TipoMidia { camera, galeria }

class SelecionarFotoDialog {
  static Future<TipoMidia?> abrir({
    required String titulo,
    required String descricao,
  }) {
    return Get.dialog<TipoMidia>(
      AlertDialog(
        title: Text(titulo),
        content: Text(descricao),
        actions: [
          ButtonbarComponent(
            prefixIcon: Icon(Icons.photo_camera_back, color: Tema.textPrimary),
            backgroundColor: Tema.primaryDark,
            labelColor: Tema.textPrimary,
            onPress: () => Get.back(result: TipoMidia.camera),
            label: "Tirar Foto",
            loading: false,
          ),
          SizedBox(height: 16),
          ButtonbarComponent(
            prefixIcon: Icon(
              Icons.add_photo_alternate,
              color: Tema.textPrimary,
            ),
            backgroundColor: Tema.primaryDark,
            labelColor: Tema.textPrimary,
            onPress: () => Get.back(result: TipoMidia.galeria),
            label: "Escolher da Galeria",
            loading: false,
          ),
        ],
      ),
    );
  }
}
