import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class ResponsiveTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final Color? headerBackgroundColor;
  final double columnSpacing;
  final String emptyMessage;

  const ResponsiveTable({
    super.key,
    required this.headers,
    required this.rows,
    this.headerBackgroundColor,
    this.columnSpacing = 24.0,
    this.emptyMessage = 'Nenhum registro encontrado.',
  });

  @override
  Widget build(BuildContext context) {
    if (headers.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: columnSpacing,
        headingRowColor: WidgetStateProperty.all(
          headerBackgroundColor ??
              Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        columns:
            headers
                .map(
                  (header) => DataColumn(
                    label: Text(
                      header,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList(),
        // SE ESTIVER VAZIO: exibe 1 linha com a mensagem centralizada
        rows:
            rows.isEmpty
                ? [
                  DataRow(
                    cells: [
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              emptyMessage,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Preenche as demais células necessárias para bater com a quantidade de colunas
                      ...List.generate(
                        headers.length - 1,
                        (_) => const DataCell(SizedBox.shrink()),
                      ),
                    ],
                  ),
                ]
                // SE TIVER DADOS: renderiza as linhas normalmente
                : rows
                    .map(
                      (row) => DataRow(
                        cells: row.map((cell) => DataCell(Text(cell))).toList(),
                      ),
                    )
                    .toList(),
      ),
    );
  }
}
