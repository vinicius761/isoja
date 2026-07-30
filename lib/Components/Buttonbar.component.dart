import 'package:flutter/material.dart';

class ButtonbarComponent extends StatelessWidget {
  final bool loading;
  final String label;
  final VoidCallback? onPress;

  final Color? backgroundColor;
  final Color? labelColor;
  final Color? loadingColor;

  final Widget? prefixIcon; // 👈 NOVO

  const ButtonbarComponent({
    super.key,
    this.onPress,
    required this.label,
    required this.loading,
    this.backgroundColor,
    this.labelColor,
    this.loadingColor,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor?.withOpacity(0.6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child:
            loading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: loadingColor ?? labelColor ?? Colors.white,
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      const SizedBox(width: 8),
                    ],
                    Text(
                      label,
                      style: TextStyle(fontSize: 18, color: labelColor),
                    ),
                  ],
                ),
      ),
    );
  }
}
