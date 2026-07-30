import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Config/AppColors.config.dart';

class ToastrComponent {
  static void show({
    required String message,
    String title = "Aviso",
    bool isError = false,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? AppColors.red : AppColors.primaryBlue,
      colorText: Colors.white,
      icon: Icon(
        isError ? Icons.error_outline : Icons.check_circle_outline,
        color: Colors.white,
        size: 30,
      ),
      margin: const EdgeInsets.all(15),
      borderRadius: 8,
      duration: const Duration(seconds: 6),
      instantInit: true,
      // Deixa com mais cara de Toast flutuante
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
