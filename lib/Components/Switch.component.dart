import 'package:isoja/Config/AppColors.config.dart';
import 'package:flutter/material.dart';

class SwitchComponent extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final bool enabled;

  const SwitchComponent({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: enabled ? Colors.black : Colors.black38,
            ),
          ),
        Switch(
          value: value,
          onChanged: enabled ? onChanged : null,
          activeColor: AppColors.darkBlue,
        ),
      ],
    );
  }
}
