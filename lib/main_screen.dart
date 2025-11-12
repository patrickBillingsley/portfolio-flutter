import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';
import 'package:patrick_billingsley_portfolio/widgets/keyboard_controller.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardController(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: GridView.count(
          crossAxisCount: 10,
          padding: const EdgeInsets.all(12),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: [
            ...FixtureBloc().currentScene.map(FixtureWidget.new),
          ],
        ),
      ),
    );
  }
}
