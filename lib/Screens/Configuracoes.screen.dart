import 'package:flutter/material.dart';
import 'package:isoja/Components/Appbar.component.dart';

class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarComponent(title: 'Configurações'),
      body: Column(children: []),
    );
  }
}
