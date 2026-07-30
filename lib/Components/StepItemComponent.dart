import 'package:flutter/material.dart';

class StepItemComponent {
  final String title;
  final String subtitle;
  final Widget content;
  final int stepIndex;
  final int currentStep;

  StepItemComponent({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.stepIndex,
    required this.currentStep,
  });

  Step build() {
    return Step(
      title: Text(title),
      subtitle: Text(subtitle),
      isActive: currentStep >= stepIndex,
      state: currentStep > stepIndex ? StepState.complete : StepState.editing,
      content: content,
    );
  }
}
