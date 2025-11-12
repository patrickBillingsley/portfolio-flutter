import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';
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
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: KeyboardController(),
        ),
        GridView.count(
          crossAxisCount: 10,
          padding: const EdgeInsets.all(12),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          children: [
            ...FixtureBloc().currentScene.map(FixtureWidget.new),
          ],
        ),
      ],
    );
  }
}
