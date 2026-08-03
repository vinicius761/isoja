import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class DropdownComponent extends StatelessWidget {
  final String label;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final String? hintText;
  final bool enabled;

  const DropdownComponent({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.prefixIcon,
    this.hintText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // Opcional: muda a cor do label se estiver desativado
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          menuMaxHeight: 300,
          value: value,
          items: items,
          // Se enabled for false, o onChanged recebe null e trava o componente
          onChanged: enabled ? onChanged : null,
          validator: validator,
          hint: Text(
            hintText ?? 'Selecione uma opção',
            style: TextStyle(
              color: enabled ? AppColors.darkBlue : Colors.grey.shade400,
              fontSize: 16,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            // Cor de fundo leve para indicar que está travado
            filled: !enabled,
            fillColor: enabled ? Colors.transparent : Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            // Adicionada a borda para quando o campo estiver desativado
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
