import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  final double offset;

  LogoComponent({super.key, this.offset = 0});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Transform.scale(
        scale: 1.8,
        child: Image.asset('assets/logo4.jpg'),
      ),
    );
  }
}
