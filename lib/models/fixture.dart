import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';

class Fixture extends Object {
  static const defaultAnimationDuration = Duration(seconds: 1);

  final Key? key;
  final Color? color;
  final double zoom;

  final Offset offset;
  Offset calculateOffsetFrom(Fixture from, {required Animation<double> controller}) {
    final xTween = Tween<double>(begin: from.offset.dx, end: offset.dx);
    final yTween = Tween<double>(begin: from.offset.dy, end: offset.dy);

    return Offset(
      xTween.evaluate(controller),
      yTween.evaluate(controller),
    );
  }

  final Duration animationDuration;

  const Fixture({
    this.key,
    this.color,
    this.zoom = 1.0,
    this.offset = Offset.zero,
    this.animationDuration = defaultAnimationDuration,
  });

  Stream<Fixture> get stream => FixtureBloc().streamFor(key);

  Fixture copyWith({
    Key? key,
    Color? color,
    double? zoom,
    Offset? offset,
    Duration? animationDuration,
  }) {
    return Fixture(
      key: key ?? this.key,
      color: color ?? this.color,
      zoom: zoom ?? this.zoom,
      offset: offset ?? this.offset,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
