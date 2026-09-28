import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class DrawerItemComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color textColor;
  final List<Widget> children;
  final Color? backgroundColor; // Opcional: para customizar a cor de fundo

  const DrawerItemComponent({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor = AppColors.primaryBlue,
    this.textColor = AppColors.darkBlue,
    this.children = const <Widget>[],
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isNotEmpty) {
      return ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        backgroundColor:
            backgroundColor ?? AppColors.primaryBlue.withOpacity(0.05),
        collapsedBackgroundColor: Colors.transparent,
        leading: Icon(icon, color: iconColor),
        title: Text(
          title,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
        iconColor: iconColor,
        collapsedIconColor: iconColor,
        childrenPadding: const EdgeInsets.only(left: 16.0),
        children: children,
      );
    }

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
    );
  }
}
