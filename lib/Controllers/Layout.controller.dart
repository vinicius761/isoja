import 'package:get/state_manager.dart';

import 'package:flutter/material.dart';

class DrawerMenuItem {
  final IconData icon;
  final String title;
  final String? route;
  final VoidCallback? onTap;
  final List<DrawerMenuItem>? children;

  DrawerMenuItem({
    required this.icon,
    required this.title,
    this.route,
    this.onTap,
    this.children,
  });
}

class LayoutController extends GetxController {
  final List<DrawerMenuItem> drawerItems = [
    DrawerMenuItem(icon: Icons.home_outlined, title: 'Início', route: '/'),
    DrawerMenuItem(
      icon: Icons.person_outline,
      title: 'Teste rfId',
      route: '/rfid',
    ),
    DrawerMenuItem(
      icon: Icons.add_circle_outline,
      title: 'Cadastros',
      children: [
        DrawerMenuItem(
          icon: Icons.person_outline,
          title: 'Proprietário',
          route: '/cadastro-proprietario',
        ),
        DrawerMenuItem(
          icon: Icons.local_shipping_outlined,
          title: 'Cavalo Mecânico',
          route: '/cadastro-cavalo-mecanico',
        ),
      ],
    ),
  ];
}
