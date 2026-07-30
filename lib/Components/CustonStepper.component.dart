import 'package:flutter/material.dart';
import 'package:isoja/Utils/Tema.dart';

class CustomStepperComponent extends StatelessWidget {
  final int currentStep;
  final List<Step> steps;
  final VoidCallback onContinue;
  final VoidCallback onCancel;
  final Widget Function(BuildContext, ControlsDetails)? controlsBuilder;

  const CustomStepperComponent({
    super.key,
    required this.currentStep,
    required this.steps,
    required this.onContinue,
    required this.onCancel,
    this.controlsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: Tema.primaryDark,
          onPrimary: Colors.white,
        ),
      ),
      child: Stepper(
        type: StepperType.vertical,
        currentStep: currentStep,
        onStepContinue: onContinue,
        onStepCancel: onCancel,
        controlsBuilder: controlsBuilder,
        steps: steps,
      ),
    );
  }
}
