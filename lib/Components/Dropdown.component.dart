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
            color: enabled ? AppColors.darkBlue : AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          menuMaxHeight: 300,
          value: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          borderRadius: BorderRadius.circular(12),
          alignment: Alignment.bottomLeft,
          style: TextStyle(
            color: enabled ? AppColors.darkBlue : AppColors.textSecondary,
            fontSize: 16,
          ),
          hint: Text(
            hintText ?? 'Selecione uma opção',
            style: const TextStyle(color: AppColors.textSecondary),
          ),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: enabled ? AppColors.lightGray : Colors.grey.shade200,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border, width: 1),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primaryBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
