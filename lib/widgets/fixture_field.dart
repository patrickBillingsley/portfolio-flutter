import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';

class FixtureField extends StatefulWidget {
  final FixtureController? controller;

  const FixtureField({
    super.key,
    this.controller,
  });

  @override
  State<FixtureField> createState() => _FixtureFieldState();
}

class _FixtureFieldState extends State<FixtureField> {
  late final FixtureController _controller = widget.controller ?? FixtureController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cellWidth = screenWidth * 0.1;
    final fixtureCount = screenWidth / cellWidth;
    final initialOffset = Offset(cellWidth * 0.5, cellWidth * 0.5);

    final fixtures = <Fixture>[];
    for (var i = 0; i < fixtureCount; i++) {
      final offset = initialOffset + Offset(cellWidth * i, 0);
      final fixture = Fixture(
        key: Key('fixture_$i'),
        center: offset,
        radius: cellWidth * 0.5,
      );

      _controller.register(fixture);

      fixtures.add(fixture);
    }

    return Stack(
      children: [
        ...fixtures.map((fixture) {
          return FixtureWidget(
            controller: _controller,
            fixture: fixture,
          );
        }),
      ],
    );
  }
}
