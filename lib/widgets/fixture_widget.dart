import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

class FixtureWidget extends StatefulWidget {
  final Fixture fixture;

  FixtureWidget(
    this.fixture,
  ) : super(key: fixture.key);

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _positionController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final StreamSubscription<Fixture> _subscription;

  late Fixture _fixture = widget.fixture;
  late Fixture _previousFixture = widget.fixture;

  @override
  void initState() {
    super.initState();
    _subscription = widget.fixture.stream.listen(_setFixture);
    _positionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _positionController.removeListener(() => setState(() {}));
  }

  void _setFixture(Fixture nextFixture) {
    setState(() {
      _previousFixture = _fixture.copyWith(
        offset: _fixture.calculateOffsetFrom(
          _previousFixture,
          controller: _positionController,
        ),
      );
      _fixture = nextFixture;
    });

    _positionController.forward(from: 0);
  }

  void _updateFixture() {
    final color = _fixture.color == Colors.red ? Colors.green : Colors.red;

    setState(() {
      _fixture = _fixture.copyWith(
        color: color,
        animationDuration: Duration(milliseconds: 100),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _fixture.calculateOffsetFrom(
        _previousFixture,
        controller: _positionController,
      ),
      child: GestureDetector(
        onTap: _updateFixture,
        child: AnimatedContainer(
          duration: _fixture.animationDuration,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _fixture.color,
          ),
        ),
      ),
    );
  }
}
