import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:isoja/Utils/Tema.dart';

class MenuOption {
  final IconData icon;
  final String label;
  final String title;
  final Color color;
  final String route;

  const MenuOption({
    required this.title,
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });
}

class HomeCard extends StatelessWidget {
  final MenuOption option;
  final VoidCallback onTap;

  const HomeCard({super.key, required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        splashColor: option.color.withOpacity(0.1),
        highlightColor: option.color.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: option.color.withOpacity(0.4),
                ),
                child: Center(
                  child: FaIcon(option.icon, size: 24, color: option.color),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Tema.surface,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
