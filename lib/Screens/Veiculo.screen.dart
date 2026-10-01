import 'package:flutter/material.dart';
import 'package:isoja/Components/Appbar.component.dart';
import 'package:isoja/Components/Drawer.component.dart';
import 'package:isoja/Config/AppColors.config.dart';

class VeiculoScreen extends StatelessWidget {
  VeiculoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarComponent(title: 'Veículos'),
      drawer: DrawerComponent(),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
