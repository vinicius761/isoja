import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Config/AppColors.config.dart';

class ListComponent<T> extends StatelessWidget {
  const ListComponent({
    super.key,
    required this.items,
    required this.titleBuilder,
    this.subtitleBuilder,
    this.iconData = Icons.directions_car,
    this.isLoading = false,
    this.emptyMessage = 'Nenhum dado encontrado.',
    this.onTapItem,
    this.onRefresh, // <--- 1. Novo parâmetro para o refresh
  });

  final List<T> items;
  final String Function(T item) titleBuilder;
  final String Function(T item)? subtitleBuilder;
  final IconData iconData;
  final bool isLoading;
  final String emptyMessage;
  final Function(T item)? onTapItem;
  final Future<void> Function()? onRefresh; // <--- Callback assíncrono

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Obx(() {
      if (items.isEmpty) {
        return RefreshIndicator(
          color: Colors.white,
          backgroundColor: AppColors.primaryBlue,
          strokeWidth: 3.0,
          displacement: 40.0,
          onRefresh: onRefresh ?? () async {},
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: Text(
                    emptyMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: AppColors.primaryBlue,
        strokeWidth: 3.0,
        displacement: 40.0,
        onRefresh: onRefresh ?? () async {},
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return ListTile(
              leading: Icon(iconData, color: AppColors.primaryBlue),
              title: Text(
                titleBuilder(item),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkBlue,
                ),
              ),
              subtitle:
                  subtitleBuilder != null
                      ? Text(
                        subtitleBuilder!(item),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      )
                      : null,
              trailing: const Icon(
                Icons.chevron_right,
                color: AppColors.primaryBlue,
              ),
              onTap: () {
                if (onTapItem != null) {
                  onTapItem!(item);
                }
              },
            );
          },
        ),
      );
    });
  }
}
