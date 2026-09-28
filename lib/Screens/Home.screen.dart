import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Drawer.component.dart';
import 'package:isoja/Components/Graficos.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Utils/CapitalizarNome.util.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Início'),
      drawer: DrawerComponent(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: AppColors.agroGreen,
                ),
                SizedBox(width: 8),
                Text(
                  'Olá ${capitalizarNome(controller.userLogado.value?.nome ?? '').split(' ').first}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              "${controller.userFilialSelecionada.value?.codFilial ?? ''} - ${capitalizarNome(controller.userFilialSelecionada.value?.filialDesc ?? '')}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            // GraficoPizza(
            //   titulo: 'Distribuição de Umidade (%)',
            //   dados: dadosUmidade,
            // ),

            // const SizedBox(height: 15),

            // GraficoBarras(
            //   titulo: 'Estimativa de Perda (%)',
            //   dados: dadosPerda,
            //   maxY: 5.0,
            // ),
          ],
        ),
      ),
    );
  }
}
