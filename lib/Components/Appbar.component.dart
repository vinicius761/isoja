import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Config/AppColors.config.dart';

class AppbarComponent extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? routeToGoBack;
  final List<Widget>? actions;

  const AppbarComponent({
    super.key,
    required this.title,
    this.routeToGoBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final ScaffoldState? scaffold = Scaffold.maybeOf(context);
    final bool hasDrawer = scaffold?.hasDrawer ?? false;

    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColors.lightGray,
      foregroundColor: Colors.black,

      leading: leadingButton(context, hasDrawer),

      actions: actions,
      shape: const Border(
        bottom: BorderSide(color: AppColors.border, width: 1),
      ),
    );
  }

  Widget leadingButton(BuildContext context, bool hasDrawer) {
    if (hasDrawer) {
      return IconButton(
        icon: const Icon(Icons.menu, size: 24),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      );
    }

    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      onPressed: () {
        if (routeToGoBack != null) {
          Get.toNamed(routeToGoBack!);
        } else {
          Get.back();
        }
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
