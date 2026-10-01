import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class SelectOption<T> {
  final T value;
  final String label;

  const SelectOption({required this.value, required this.label});
}

class SelectComponent<T> extends StatelessWidget {
  final T? value;
  final List<SelectOption<T>> items;
  final String labelText;
  final String? hintText;
  final ValueChanged<T?> onChanged;
  final String? Function(T?)? validator;
  final bool isExpanded;
  final Widget? prefixIcon;

  const SelectComponent({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.labelText = 'Selecione uma opção',
    this.hintText,
    this.validator,
    this.isExpanded = true,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            color: AppColors.darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: isExpanded,
          validator: validator,
          iconEnabledColor: AppColors.agroGreen,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColors.lightGray,
            prefixIconColor: AppColors.agroGreen,
            prefixIcon: prefixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
          ),
          items:
              items.map((SelectOption<T> option) {
                return DropdownMenuItem<T>(
                  value: option.value,
                  child: Text(
                    option.label,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                );
              }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
