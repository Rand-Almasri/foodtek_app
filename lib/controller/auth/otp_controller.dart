import 'package:flutter/material.dart';

class OTPController {
  final TextEditingController controller;
  final List<FocusNode> focusNodes;
  final List<TextEditingController> textControllers;

  OTPController(int length)
      : controller = TextEditingController(),
        focusNodes = List.generate(length, (index) => FocusNode()),
        textControllers = List.generate(length, (index) => TextEditingController());

  void updateFocus(int index) {
    if (index < focusNodes.length - 1) {
      focusNodes[index + 1].requestFocus();
    } else {
      FocusScope.of(focusNodes[index].context!).unfocus();
    }
  }

  void dispose() {
    controller.dispose();
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var textController in textControllers) {
      textController.dispose();
    }
  }
}
