import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  final Widget child;

  const CardComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: child,
    );
  }
}
