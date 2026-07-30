import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool isOutlined;
  final IconData? icon;
  final Color? backgroundColor;

  const ButtonComponent({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.isOutlined = false,
    this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Define a cor de fundo padrão (Azul da marca) ou a cor customizada fornecida
    final Color buttonColor = backgroundColor ?? AppColors.primaryBlue;

    // Define se o botão está de fato ativo e clicável
    final bool active = !isDisabled && !isLoading && onPressed != null;

    return SizedBox(
      width: double.infinity, // Ocupa toda a largura disponível por padrão
      height: 54, // Altura confortável para cliques em dispositivos móveis
      child:
          isOutlined
              ? OutlinedButton(
                onPressed: active ? onPressed : null,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: active ? buttonColor : AppColors.border,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _buildButtonContent(active, isOutlined: true),
              )
              : ElevatedButton(
                onPressed: active ? onPressed : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  disabledBackgroundColor: AppColors.lightGray,
                  elevation: 0, // Visual plano (flat) e moderno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _buildButtonContent(active, isOutlined: false),
              ),
    );
  }

  // Helper para construir o conteúdo interno do botão (texto, ícone ou loading)
  Widget _buildButtonContent(bool active, {required bool isOutlined}) {
    if (isLoading) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined ? AppColors.primaryBlue : AppColors.background,
          ),
        ),
      );
    }

    final Color contentColor =
        isOutlined
            ? (active
                ? (backgroundColor ?? AppColors.primaryBlue)
                : AppColors.textSecondary)
            : (active ? AppColors.background : AppColors.textSecondary);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: contentColor, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: contentColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
