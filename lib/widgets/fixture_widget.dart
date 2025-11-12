import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
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
  late final StreamSubscription<Message> _messageSubscription;

  late Fixture _fixture = widget.fixture;
  late Fixture _previousFixture = widget.fixture;

  @override
  void initState() {
    super.initState();
    _subscription = widget.fixture.stream.listen(_setFixture);
    _messageSubscription = FixtureBloc().messageStream.listen(_handleMessage);
    _positionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
    _messageSubscription.cancel();
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

  void _handleMessage(Message message) {
    if (!message.pertainsTo(_fixture)) {
      return;
    }

    if (message is MoveMessage) {
      _updateFixture(offset: _fixture.offset + message.position);
    }
  }

  void _updateFixture({Offset? offset, Color? color}) {
    _setFixture(
      _fixture.copyWith(
        offset: offset,
        color: color,
        animationDuration: Duration(milliseconds: 100),
      ),
    );
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
          alignment: Alignment.center,
          child: Text(_fixture.id.toString()),
        ),
      ),
    );
  }
}
