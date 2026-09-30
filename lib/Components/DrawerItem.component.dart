import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class DrawerItemComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final List<Widget> children;

  const DrawerItemComponent({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.children = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    if (children.isNotEmpty) {
      return ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        backgroundColor: AppColors.lightGray,
        collapsedBackgroundColor: Colors.transparent,
        leading: Icon(icon, color: AppColors.agroGreen),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconColor: AppColors.agroGreen,
        collapsedIconColor: AppColors.darkBlue,
        childrenPadding: const EdgeInsets.only(left: 30),
        children: children,
      );
    }

    return ListTile(
      leading: Icon(icon, color: AppColors.agroGreen),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.darkBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
