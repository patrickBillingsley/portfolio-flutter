import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';
import 'package:patrick_billingsley_portfolio/widgets/matrix_column.dart';

class MatrixTransitionScreen extends StatefulWidget with Navigation {
  const MatrixTransitionScreen({super.key});

  @override
  State<MatrixTransitionScreen> createState() => _MatrixTransitionScreenState();
}

class _MatrixTransitionScreenState extends State<MatrixTransitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: List.generate(20, (index) {
          return Positioned(
            left: 60.0 * index,
            child: MatrixColumn(),
          );
        }),
      ),
    );
  }
}
