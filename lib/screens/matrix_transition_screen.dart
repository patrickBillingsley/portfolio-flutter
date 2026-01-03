import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/matrix_column.dart';

class MatrixTransitionScreen extends StatefulWidget {
  final Animation<double> animation;

  const MatrixTransitionScreen({
    super.key,
    required this.animation,
  });

  @override
  State<MatrixTransitionScreen> createState() => _MatrixTransitionScreenState();
}

class _MatrixTransitionScreenState extends State<MatrixTransitionScreen> {
  List<double>? top;
  List<double>? left;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.biggest.width;
        final columnCount = (width / 10).round();
        final random = Random();
        top ??= List.generate(columnCount, (_) => 600 * random.nextDouble());
        left ??= List.generate(columnCount, (index) => max(5.0, 20 * index * random.nextDouble()));

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: List.generate(columnCount, (index) {
              return Positioned(
                key: ValueKey('column-$index'),
                top: top?[index],
                left: left?[index],
                bottom: 0,
                child: MatrixColumn(
                  animation: widget.animation,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
