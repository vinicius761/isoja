import 'package:flutter/material.dart';

class BuildRowComponent extends StatelessWidget {
  final String label;
  final String? value;

  const BuildRowComponent({super.key, required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    final displayValue =
        (value != null && value!.trim().isNotEmpty) ? value! : '-';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(displayValue)),
        ],
      ),
    );
  }
}
