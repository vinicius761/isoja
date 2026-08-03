import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: AppColors.primaryBlue),
    );
  }
}
