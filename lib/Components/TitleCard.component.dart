import 'package:flutter/material.dart';

class TitleCardComponent extends StatelessWidget {
  final String label;

  const TitleCardComponent({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: TextStyle(fontSize: 20));
  }
}
