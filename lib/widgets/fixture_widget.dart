import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

class FixtureWidget extends StatefulWidget {
  final FixtureController controller;
  final Fixture fixture;

  const FixtureWidget({
    super.key,
    required this.controller,
    required this.fixture,
  });

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
    reverseDuration: const Duration(milliseconds: 400),
  );

  late final Tween<double> _zoomTween = Tween(
    begin: widget.fixture.zoom,
    end: widget.fixture.zoom,
  );

  Animation<double> get _zoomAnimation => _zoomTween.animate(_animationController);

  late final StreamSubscription<Fixture> _fixtureSubscription;

  late Fixture _fixture = widget.fixture;
  late double _zoom = _fixture.zoom;

  @override
  void initState() {
    super.initState();
    _fixtureSubscription = widget.controller.streamFor(widget.fixture).listen(_handleFixture);
    _animationController.addListener(
      () => setState(() {
        _zoom = _zoomAnimation.value;
      }),
    );
  }

  @override
  void dispose() {
    _fixtureSubscription.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _handleFixture(Fixture fixture) {
    _fixture = fixture;
    _zoomTween.begin = _zoom;
    _zoomTween.end = fixture.zoom;

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromCircle(
        center: _fixture.center,
        radius: _fixture.radius * _zoom,
      ),
      child: ClipOval(
        child: Container(
          color: _fixture.color,
        ),
      ),
    );
  }
}
