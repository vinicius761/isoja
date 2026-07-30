import 'package:isoja/Utils/Tema.dart';
import 'package:flutter/material.dart';

class SwitchComponent extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged; // Mudou para opcional (?)
  final String? label;
  final bool enabled; // Nova prop para controlar o estado

  const SwitchComponent({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.enabled = true, // Por padrão, ele vem habilitado
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (label != null)
          Text(
            label!,
            // Opcional: diminui a opacidade do texto se estiver desabilitado
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: enabled ? Colors.black : Colors.black38,
            ),
          ),
        Switch(
          value: value,
          // Se 'enabled' for true, usa o onChanged original. Se for false, passa null.
          onChanged: enabled ? onChanged : null,
          activeColor: Tema.primaryDark,
        ),
      ],
    );
  }
}
