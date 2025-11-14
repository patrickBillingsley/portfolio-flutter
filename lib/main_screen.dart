import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_grid.dart';
import 'package:patrick_billingsley_portfolio/widgets/keyboard_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black87,
        ),
        FixtureGrid(),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: KeyboardController(),
        ),
      ],
    );
  }
}
