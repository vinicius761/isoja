import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Button.component.dart';
import 'package:isoja/Components/Input.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Proprietario.controller.dart';
import 'package:isoja/Utils/Formaters/maskFormater.util.dart';
import 'package:isoja/Utils/Validators/CampoVazio.validator.dart';

class CadastroProprietarioScreen extends StatelessWidget {
  const CadastroProprietarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProprietarioController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Cadastro de Prorietário'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                InputComponent(
                  label: 'Nome',
                  hintText: 'Digite seu nome',
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.text,
                  controller: controller.nome,
                  validator: (value) => validarCampoVazio(value, 'Nome'),
                ),
                SizedBox(height: 16),
                InputComponent(
                  label: 'CPF',
                  hintText: 'Digite seu CPF',
                  prefixIcon: Icons.badge_outlined,
                  controller: controller.cpfCnpj,
                  keyboardType: TextInputType.number,
                  inputFormatters: [cpfFormatterUtil],
                  validator: (value) => validarCampoVazio(value, 'CPF'),
                ),
                SizedBox(height: 16),
                InputComponent(
                  label: 'Telefone',
                  hintText: 'Digite seu telefone',
                  prefixIcon: Icons.phone_outlined,
                  controller: controller.telefone,
                  keyboardType: TextInputType.text,
                  inputFormatters: [maskCelular(), maskTelefoneFixo()],
                  validator: (value) => validarCampoVazio(value, 'Telefone'),
                ),
                SizedBox(height: 16),
                InputComponent(
                  label: 'E-mail',
                  hintText: 'Digite seu e-mail',
                  prefixIcon: Icons.email_outlined,
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validarCampoVazio(value, 'E-mail'),
                ),
                SizedBox(height: 20),
                ButtonComponent(
                  text: 'Salvar',
                  onPressed: () => controller.salvar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
