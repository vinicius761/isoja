import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:isoja/Components/FormProgress.component.dart';

class MultiStepFormController extends GetxController {
  var currentStep = 0.obs;
  final int totalSteps;

  late PageController pageController;
  var formData = <String, dynamic>{}.obs;

  MultiStepFormController({required this.totalSteps});

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
      _animateToCurrentPage();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
      _animateToCurrentPage();
    }
  }

  void _animateToCurrentPage() {
    pageController.animateToPage(
      currentStep.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void updateData(String key, dynamic value) {
    formData[key] = value;
  }

  bool get isLastStep => currentStep.value == totalSteps - 1;
  bool get isFirstStep => currentStep.value == 0;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class FormstepperComponent extends StatelessWidget {
  final List<Widget> steps;
  final VoidCallback onSubmit;
  final String tag;

  const FormstepperComponent({
    Key? key,
    required this.steps,
    required this.onSubmit,
    this.tag = 'default',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      MultiStepFormController(totalSteps: steps.length),
      tag: tag,
    );

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => FormProgressTracker(
              totalSteps: steps.length,
              currentStep: controller.currentStep.value,
            ),
          ),

          // O conteúdo que desliza
          Expanded(
            child: PageView(
              controller: controller.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: steps,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!controller.isFirstStep)
                OutlinedButton(
                  onPressed: controller.previousStep,
                  child: const Text('Voltar'),
                )
              else
                const SizedBox.shrink(),

              ElevatedButton(
                onPressed: () {
                  if (controller.isLastStep) {
                    onSubmit();
                  } else {
                    controller.nextStep();
                  }
                },
                child: Text(controller.isLastStep ? 'Finalizar' : 'Avançar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
