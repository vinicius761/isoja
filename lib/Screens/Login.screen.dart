import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Components/Logo.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Utils/Validators/CampoVazio.validator.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LogoComponent(offset: 80),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputComponent(
                        label: 'Login',
                        hintText: 'Digite seu usuário',
                        prefixIcon: Icons.person_2_outlined,
                        controller: controller.user,
                        validator: (value) => validarCampoVazio(value, 'Login'),
                      ),
                      const SizedBox(height: 20),
                      InputComponent(
                        label: 'Senha',
                        hintText: 'Digite sua senha',
                        prefixIcon: Icons.lock_outline,
                        isPassword: true,
                        controller: controller.senha,
                        validator: (value) => validarCampoVazio(value, 'Senha'),
                      ),
                      const SizedBox(height: 20),
                      ButtonComponent(
                        text: 'Entrar',
                        onPressed: () => controller.entrar(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
