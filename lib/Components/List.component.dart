import 'package:flutter/material.dart';

class ListComponent<T> extends StatelessWidget {
  const ListComponent({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.isLoading = false,
    this.emptyMessage = 'Nenhum dado encontrado.',
  });
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final bool isLoading;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (items.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return itemBuilder(context, items[index]);
      },
    );
  }
}
