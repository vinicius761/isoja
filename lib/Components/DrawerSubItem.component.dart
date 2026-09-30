import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class DrawerSubItemComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerSubItemComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      leading: Icon(icon, color: AppColors.agroGreen),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondary,
        ),
      ),
      onTap: onTap,
    );
  }
}
