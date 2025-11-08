import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

class FixtureWidget extends StatefulWidget {
  final FixtureController controller;
  final Fixture fixture;

  FixtureWidget({
    required this.controller,
    required this.fixture,
  }) : super(key: fixture.key);

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.register(widget.fixture);
    widget.fixture.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.fixture.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromCircle(
        center: widget.fixture.center,
        radius: widget.fixture.radius * widget.fixture.zoom,
      ),
      child: ClipOval(
        child: Container(
          color: widget.fixture.color,
        ),
      ),
    );
  }
}
