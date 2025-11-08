import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';

class FixtureField extends StatefulWidget {
  final FixtureController controller;

  const FixtureField({
    super.key,
    required this.controller,
  });

  @override
  State<FixtureField> createState() => _FixtureFieldState();
}

class _FixtureFieldState extends State<FixtureField> {
  late final FixtureController _controller = widget.controller;

  final List<Fixture> _fixtures = [];

  @override
  void initState() {
    super.initState();
    _controller.initialize(10, 10);
    _initFixtures();
  }

  void _initFixtures() {
    _fixtures.clear();
    for (var row = 0; row < _controller.rows; row++) {
      for (var col = 0; col < _controller.cols; col++) {
        _fixtures.add(Fixture(col: col, row: row));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final screenWidth = screenSize.width;

    final cellWidth = screenWidth * 0.1;
    final initialOffset = Offset(cellWidth * 0.5, cellWidth * 0.5);

    for (final fixture in _fixtures) {
      final offset = initialOffset + Offset(cellWidth * fixture.col, cellWidth * fixture.row);
      fixture.update(
        center: offset,
        radius: cellWidth * 0.5,
      );
    }

    return Stack(
      children: [
        ..._fixtures.map((fixture) {
          return FixtureWidget(
            controller: _controller,
            fixture: fixture,
          );
        }),
      ],
    );
  }
}
