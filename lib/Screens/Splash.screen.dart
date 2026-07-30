import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/Logo.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Splash.controller.dart';

class Splashscreen extends StatelessWidget {
  Splashscreen({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            LogoComponent(offset: 80),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(12),
                border: BoxBorder.all(width: 1, color: AppColors.border),
              ),
              child: Obx(() {
                double valorAlvo = controller.progress.value;
                String textoAtual = controller.loadingText.value;
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: valorAlvo),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.easeInOutCubic,
                  builder: (context, value, child) {
                    int porcentagem = (value * 100).toInt();
                    return Column(
                      children: [
                        Text(
                          textoAtual,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 8,
                            backgroundColor: AppColors.lightGray,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.agroGreen,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "$porcentagem%",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
