import 'package:isoja/Utils/Tema.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class RangeComponent extends StatelessWidget {
  final String label;
  final RxString value;
  final double min;
  final double max;

  const RangeComponent({
    super.key,
    required this.label,
    required this.value,
    this.min = 5,
    this.max = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final current = double.tryParse(value.value) ?? min;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("$label: ${current.toStringAsFixed(0)}"),

          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Tema.primaryDark,
              inactiveTrackColor: Tema.primaryDark.withOpacity(0.3),
              thumbColor: Tema.primaryDark,
              overlayColor: Tema.primaryDark.withOpacity(0.2),
              valueIndicatorColor: Tema.primaryDark,
              valueIndicatorTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Slider(
              value: current.clamp(min, max),
              min: min,
              max: max,
              divisions: (max - min).toInt(),
              label: current.toStringAsFixed(0),
              onChanged: (val) {
                value.value = val.toStringAsFixed(0);
              },
            ),
          ),
        ],
      );
    });
  }
}
