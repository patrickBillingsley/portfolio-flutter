import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/distance_scroll_widget.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_grid.dart';
import 'package:patrick_billingsley_portfolio/widgets/keyboard_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  void _nextWidget() {
    setState(() {
      if (_index + 1 >= widgets.length) {
        _index = 0;
      } else {
        _index = _index + 1;
      }
    });
  }

  List<Widget> get widgets => [
    FixtureGrid(),
    DistanceScrollWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black87,
          ),
          widgets[_index],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: KeyboardController(
              onTap: _nextWidget,
            ),
          ),
        ],
      ),
    );
  }
}
