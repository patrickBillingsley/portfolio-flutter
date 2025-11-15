import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:vector_math/vector_math_64.dart';

class FixtureWidget extends StatefulWidget {
  final Fixture fixture;

  FixtureWidget(
    this.fixture,
  ) : super(key: fixture.key);

  @override
  State<FixtureWidget> createState() => _FixtureWidgetState();
}

class _FixtureWidgetState extends State<FixtureWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final StreamSubscription<Fixture> _subscription;
  late final StreamSubscription<Message> _messageSubscription;

  late Fixture _fixture = widget.fixture;
  late Fixture _previousFixture = widget.fixture;

  @override
  void initState() {
    super.initState();
    _subscription = widget.fixture.stream.listen(_setFixture);
    _messageSubscription = FixtureBloc().messageStream.listen(_handleMessage);
    _animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _messageSubscription.cancel();
    _animationController.removeListener(() => setState(() {}));
  }

  void _setFixture(Fixture nextFixture) {
    setState(() {
      _previousFixture = _fixture.copyWith(
        position: _fixture.calculatePositionFrom(
          _previousFixture,
          controller: _animationController,
        ),
      );
      _fixture = nextFixture;
    });

    _animationController.forward(from: 0);
  }

  void _handleMessage(Message message) {
    if (!message.pertainsTo(_fixture)) {
      return;
    }

    final Fixture? update;
    switch (message) {
      case MoveMessage _:
        update = _fixture.copyWith(position: _fixture.position + message.position);
      case ZoomMessage _:
        update = _fixture.copyWith(zoom: message.zoom);
      default:
        update = null;
    }

    if (update != null) {
      _setFixture(update);
    }
  }

  @override
  Widget build(BuildContext context) {
    final position = _fixture.calculatePositionFrom(_previousFixture, controller: _animationController);
    return Transform(
      transform: Matrix4.identity()
        ..translateByVector3(
          Vector3(position.x, position.y, position.z),
        ),
      child: Transform.scale(
        scale: _fixture.calculateZoomFrom(
          _previousFixture,
          controller: _animationController,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FixtureBloc().push([
              _fixture.copyWith(
                borderRadius: _fixture.borderRadius == 0 ? 50 : 0,
              ),
            ]);
          },
          child: AnimatedContainer(
            duration: _fixture.animationDuration,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_fixture.borderRadius),
              color: _fixture.color,
            ),
            alignment: Alignment.center,
            // child: Text(_fixture.zoom.toString()),
          ),
        ),
      ),
    );
  }
}
