import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class RadioComponent<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;
  final Color? activeColor;

  const RadioComponent({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.activeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio<T>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: activeColor ?? AppColors.agroGreen,
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: 8),
              Text(label!, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    }

    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor ?? AppColors.agroGreen,
    );
  }
}
