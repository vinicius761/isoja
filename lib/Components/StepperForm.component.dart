import 'package:flutter/material.dart';
import 'package:isoja/Config/AppColors.config.dart';

class FormStep {
  final String title;
  final String? subtitle;
  final Widget content;
  final bool Function()? validate;

  FormStep({
    required this.title,
    this.subtitle,
    required this.content,
    this.validate,
  });
}

class CustomStepperForm extends StatefulWidget {
  final List<FormStep> steps;
  final Future<void> Function() onComplete;
  final String submitButtonText;

  const CustomStepperForm({
    Key? key,
    required this.steps,
    required this.onComplete,
    this.submitButtonText = 'Finalizar',
  }) : super(key: key);

  @override
  State<CustomStepperForm> createState() => _CustomStepperFormState();
}

class _CustomStepperFormState extends State<CustomStepperForm> {
  int _currentStep = 0;
  bool _isSubmitting = false;

  bool get _isFirstStep => _currentStep == 0;
  bool get _isLastStep => _currentStep == widget.steps.length - 1;

  void _handleNext() async {
    final currentStepData = widget.steps[_currentStep];

    if (currentStepData.validate != null) {
      final isValid = currentStepData.validate!();
      if (!isValid) return;
    }

    if (_isLastStep) {
      setState(() => _isSubmitting = true);
      try {
        await widget.onComplete();
      } finally {
        if (mounted) setState(() => _isSubmitting = false);
      }
    } else {
      setState(() => _currentStep += 1);
    }
  }

  void _handleBack() {
    if (!_isFirstStep) {
      setState(() => _currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(
                context,
              ).colorScheme.copyWith(primary: AppColors.primaryBlue),
              disabledColor: Colors.grey.shade400,
            ),
            child: Stepper(
              type: StepperType.vertical,
              currentStep: _currentStep,
              onStepTapped: (index) {
                if (index < _currentStep) {
                  setState(() => _currentStep = index);
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return const SizedBox.shrink();
              },
              steps:
                  widget.steps.asMap().entries.map((entry) {
                    int index = entry.key;
                    FormStep step = entry.value;

                    return Step(
                      title: Text(
                        step.title,
                        style: TextStyle(color: AppColors.primaryBlue),
                      ),
                      subtitle:
                          step.subtitle != null
                              ? Text(
                                step.subtitle!,
                                style: TextStyle(color: AppColors.darkBlue),
                              )
                              : null,
                      isActive: _currentStep >= index,
                      state:
                          _currentStep > index
                              ? StepState.complete
                              : (_currentStep == index
                                  ? StepState.editing
                                  : StepState.indexed),
                      content: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: step.content,
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.lightGray,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!_isFirstStep)
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: _isSubmitting ? null : _handleBack,
                  child: const Text('Voltar'),
                )
              else
                const SizedBox.shrink(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: _isSubmitting ? null : _handleNext,
                child:
                    _isSubmitting
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(
                          _isLastStep ? widget.submitButtonText : 'Próximo',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
