import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // IMPORTANTE: Necessário para o TextInputFormatter
import 'package:isoja/Utils/Tema.dart';

class FormFieldComponent extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool enabled;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Function(String)? onChanged;
  // 1. Adicionado a lista de formatadores aqui
  final List<TextInputFormatter>? inputFormatters;

  FormFieldComponent({
    super.key,
    this.keyboardType,
    this.onChanged,
    this.maxLines,
    this.controller,
    this.initialValue,
    this.readOnly = false,
    this.enabled = true,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.sufixIcon,
    this.obscureText = false,
    this.validator,
    this.inputFormatters, // 2. Adicionado no construtor
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: enabled ? Colors.black : Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          onChanged: onChanged,
          initialValue: controller == null ? initialValue : null,
          canRequestFocus: !readOnly && enabled,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly,
          enabled: enabled,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          // 3. Passado para o TextFormField nativo
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            alignLabelWithHint: true,
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Tema.textSecondary,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Tema.textSecondary,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Tema.primaryDark, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
