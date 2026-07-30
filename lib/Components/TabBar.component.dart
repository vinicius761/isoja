import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class TabBarComponent extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;
  final Color selectedColor;
  final Color unselectedColor;
  final Color indicatorColor;
  final ValueChanged<int>? onTap;

  const TabBarComponent({
    super.key,
    required this.controller,
    required this.tabs,
    this.selectedColor = AppColors.agroGreen,
    this.unselectedColor = AppColors.textSecondary,
    this.indicatorColor = AppColors.agroGreen,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(color: AppColors.lightGray),
      child: TabBar(
        // PERMITE A ROLAGEM HORIZONTAL
        isScrollable: true,
        // Define se as abas ficam alinhadas à esquerda quando scrollable
        tabAlignment: TabAlignment.start,
        // Espaçamento interno de cada aba para dar respiro aos textos
        labelPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        controller: controller,
        onTap: onTap,
        indicator: BoxDecoration(color: indicatorColor),
        labelColor: Colors.white,
        unselectedLabelColor: unselectedColor,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs.map((title) => Tab(text: title)).toList(),
      ),
    );
  }
}
