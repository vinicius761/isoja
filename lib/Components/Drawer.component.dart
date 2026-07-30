import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/DrawerItem.component.dart';
import 'package:isoja/Components/DrawerSubItem.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Utils/CapitalizarNome.util.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({super.key});

  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Botão de fechar colado no topo
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(
                              Icons.close,
                              size: 28,
                              color: AppColors.darkBlue,
                            ),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: ClipRect(
                            child: Transform.scale(
                              scale: 1.8,
                              child: Image.asset(
                                'assets/logo3.jpg',
                                height: 230,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          capitalizarNome(
                            controller
                                    .userFilialSelecionada
                                    .value
                                    ?.filialDesc ??
                                '',
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.darkBlue,
                          ),
                        ),
                        Text(
                          capitalizarNome(
                            controller.userLogado.value?.nome ?? '',
                          ),
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 14),
                        const Divider(color: AppColors.border),
                      ],
                    ),
                  ),

                  DrawerItemComponent(
                    icon: Icons.home_outlined,
                    title: 'Início',
                    onTap: () {
                      Get.back();
                      Get.toNamed('/');
                    },
                  ),
                  DrawerItemComponent(
                    icon: Icons.add_circle_outline,
                    title: 'Cadastro',
                    children: [
                      DrawerSubItemComponent(
                        icon: Icons.factory_outlined,
                        title: 'Apontamento de Produção',
                        onTap: () {
                          Get.back();
                          Get.toNamed('/cadastro-producao');
                        },
                      ),
                    ],
                  ),
                  // DrawerItemComponent(
                  //   icon: Icons.agriculture_outlined,
                  //   title: 'Romaneio',
                  //   onTap: () {
                  //     Get.back();
                  //     Get.toNamed('/lavouras');
                  //   },
                  // ),
                  // DrawerItemComponent(
                  //   icon: Icons.bar_chart_outlined,
                  //   title: 'Relatórios',
                  //   onTap: () {
                  //     Get.back();
                  //     Get.toNamed('/relatorios');
                  //   },
                  // ),
                  // DrawerItemComponent(
                  //   icon: Icons.sync,
                  //   title: 'Sincronizar Dados',
                  //   onTap: () {
                  //     Get.back();
                  //     Get.toNamed('/splash');
                  //   },
                  // ),
                  // DrawerItemComponent(
                  //   icon: Icons.settings_outlined,
                  //   title: 'Configurações',
                  //   onTap: () {
                  //     Get.back();
                  //     Get.toNamed('/configuracoes');
                  //   },
                  // ),
                  // const Divider(color: AppColors.border),
                  // DrawerItemComponent(
                  //   icon: Icons.logout_outlined,
                  //   title: 'Sair',
                  //   iconColor: Colors.redAccent,
                  //   textColor: Colors.redAccent,
                  //   onTap: () => controller.sair(),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
