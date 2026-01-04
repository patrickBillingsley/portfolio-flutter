import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MatrixTransitionScreen extends StatefulWidget {
  const MatrixTransitionScreen({super.key});

  @override
  State<MatrixTransitionScreen> createState() => _MatrixTransitionScreenState();
}

class _MatrixTransitionScreenState extends State<MatrixTransitionScreen> {
  late File file;
  late RiveWidgetController controller;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    initRive();
  }

  @override
  void dispose() {
    file.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> initRive() async {
    file = (await File.asset('assets/animations/matrix_transition.riv', riveFactory: Factory.rive))!;
    controller = RiveWidgetController(file);
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const SizedBox();
    }

    return RiveWidget(
      controller: controller,
      fit: Fit.cover,
    );
  }
}
