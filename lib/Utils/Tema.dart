import 'package:flutter/material.dart';

class Tema {
  static const Color primary = Color(0xFF38E1E8);
  static const Color primaryDark = Color(0xFF1FA4C9);

  static const Color accent = Color(0xFFA6FF00);

  static const Color background = Color(0xFF0A1F2C);
  static const Color surface = Color(0xFF0D3B66);

  static const Color glow = Color(0xFF7FFBFF);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color gray = Color(0xFF9CA3AF);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0A1F2C), Color(0xFF1FA4C9), Color(0xFF38E1E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
