import 'package:flutter/material.dart';

class GpsCaptureComponent extends StatelessWidget {
  final bool isLoading;
  final String coordenadas;
  final VoidCallback onCapture;

  const GpsCaptureComponent({
    super.key,
    required this.isLoading,
    required this.coordenadas,
    required this.onCapture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: isLoading ? null : onCapture,
            icon: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.gps_fixed, color: Colors.green),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(coordenadas, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}
