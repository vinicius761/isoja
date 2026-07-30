import 'package:flutter/material.dart';
import 'package:isoja/Utils/Tema.dart';

class IconButtonComponent extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool isLoading;

  const IconButtonComponent({
    super.key,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.borderRadius = 8,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Tema.primaryDark;
    final txtColor = textColor ?? Tema.textPrimary;

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child:
          isLoading
              ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: txtColor,
                ),
              )
              : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: txtColor),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
    );
  }
}
