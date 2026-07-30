import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class PizzaData {
  final String label;
  final double value;
  final Color color;

  PizzaData({required this.label, required this.value, required this.color});
}

class ColunaData {
  final String label;
  final double value;
  final Color color; // Add esta linha

  ColunaData({
    required this.label,
    required this.value,
    this.color = const Color(0xFFE53935), // Cor padrão (opcional)
  });
}

class GraficoPizza extends StatelessWidget {
  final String titulo;
  final List<PizzaData> dados;

  const GraficoPizza({super.key, required this.titulo, required this.dados});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(width: 1, color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1D1E),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // Gráfico
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 3,
                      centerSpaceRadius: 40,
                      sections:
                          dados.map((item) {
                            return PieChartSectionData(
                              color: item.color,
                              value: item.value,
                              title: '${item.value.toInt()}%',
                              radius: 30,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Legenda dinâmica
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      dados.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: item.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item.label,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
