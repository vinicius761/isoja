import 'package:flutter/material.dart';

// Classe de configuração da ação
class TableAction {
  final String value;
  final String label;
  final String? labelAcao;
  final IconData icon;
  final Color iconColor;

  const TableAction({
    required this.value,
    required this.label,
    required this.icon,
    this.labelAcao,
    this.iconColor = Colors.black,
  });
}

class TableComponent extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;
  final List<TableAction> actions;
  final Function(String value, int index)? onActionSelected;
  final String actionsHeaderLabel;
  final String emptyMessage; // 1. Nova prop adicionada

  const TableComponent({
    super.key,
    required this.headers,
    required this.rows,
    this.actions = const [],
    this.onActionSelected,
    this.actionsHeaderLabel = 'Ações',
    this.emptyMessage = 'Nenhum registro encontrado.', // 2. Valor padrão
  });

  @override
  Widget build(BuildContext context) {
    // Exibe a coluna apenas se houver ações na lista
    final showActions = actions.isNotEmpty && onActionSelected != null;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                ...headers.map((h) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        h,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                }),
                if (showActions)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        actionsHeaderLabel,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Container(height: 1, color: Colors.grey.shade300),

          // 3. Verificação de lista vazia
          if (rows.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 16.0,
              ),
              child: Center(
                child: Text(
                  emptyMessage,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            // ROWS (Só renderiza se rows NÃO estiver vazio)
            ...rows.asMap().entries.map((entry) {
              int index = entry.key;
              List<String> row = entry.value;

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    ...row.map((cell) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            cell,
                            style: const TextStyle(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }),
                    if (showActions)
                      Expanded(
                        child: Center(
                          child: Wrap(
                            spacing: 4.0,
                            runSpacing: 4.0,
                            alignment: WrapAlignment.center,
                            children:
                                actions.map((action) {
                                  return Tooltip(
                                    message: action.label,
                                    child: IconButton(
                                      icon: Icon(action.icon),
                                      color: action.iconColor,
                                      iconSize: 22,
                                      onPressed: () {
                                        onActionSelected!(action.value, index);
                                      },
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}
