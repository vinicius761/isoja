import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/DrawerItem.component.dart';
import 'package:isoja/Components/DrawerSubItem.component.dart';
import 'package:isoja/Config/AppColors.config.dart';
import 'package:isoja/Controllers/Layout.controller.dart';
import 'package:isoja/Controllers/Login.controller.dart';
import 'package:isoja/Utils/CapitalizarNome.util.dart';

class DrawerComponent extends StatelessWidget {
  DrawerComponent({super.key});

  final loginController = Get.find<LoginController>();
  final controller = Get.find<LayoutController>();

  @override
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
                            loginController
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
                            loginController.userLogado.value?.nome ?? '',
                          ),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 14),
                        const Divider(color: AppColors.border),
                      ],
                    ),
                  ),

                  ...controller.drawerItems.map((item) {
                    if (item.children != null && item.children!.isNotEmpty) {
                      return DrawerItemComponent(
                        icon: item.icon,
                        title: item.title,
                        children:
                            item.children!.map((subItem) {
                              return DrawerSubItemComponent(
                                icon: subItem.icon,
                                title: subItem.title,
                                onTap:
                                    subItem.onTap ??
                                    () {
                                      Get.back();
                                      if (subItem.route != null) {
                                        Get.toNamed(subItem.route!);
                                      }
                                    },
                              );
                            }).toList(),
                      );
                    }

                    return DrawerItemComponent(
                      icon: item.icon,
                      title: item.title,
                      onTap:
                          item.onTap ??
                          () {
                            Get.back();
                            if (item.route != null) {
                              Get.toNamed(item.route!);
                            }
                          },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
