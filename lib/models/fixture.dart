import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';

class Fixture extends Object {
  static const defaultAnimationDuration = Duration(seconds: 1);

  final int? id;
  final Color? color;
  final double zoom;
  final Offset offset;
  final Duration animationDuration;

  const Fixture({
    this.id,
    this.color,
    this.zoom = 1.0,
    this.offset = Offset.zero,
    this.animationDuration = defaultAnimationDuration,
  });

  Key? get key => id == null ? null : Key('fixture_$id');
  Stream<Fixture> get stream => FixtureBloc().streamFor(key);

  bool within(int? interleave, int? offset) {
    if (id == null || interleave == null) {
      return true;
    }

    offset ??= 0;

    return (id! + offset) % interleave == 0;
  }

  Offset calculateOffsetFrom(Fixture from, {required Animation<double> controller}) {
    final xTween = Tween<double>(begin: from.offset.dx, end: offset.dx);
    final yTween = Tween<double>(begin: from.offset.dy, end: offset.dy);

    return Offset(
      xTween.evaluate(controller),
      yTween.evaluate(controller),
    );
  }

  Fixture copyWith({
    int? id,
    Color? color,
    double? zoom,
    Offset? offset,
    Duration? animationDuration,
  }) {
    return Fixture(
      id: id ?? this.id,
      color: color ?? this.color,
      zoom: zoom ?? this.zoom,
      offset: offset ?? this.offset,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }
}
