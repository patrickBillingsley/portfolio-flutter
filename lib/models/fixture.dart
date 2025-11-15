import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:vector_math/vector_math.dart';

class Fixture extends Object {
  static const defaultAnimationDuration = Duration(seconds: 1);

  final int? id;
  final Color? color;
  final double zoom;
  final Vector3 position;
  final Duration animationDuration;
  final double borderRadius;

  Fixture({
    this.id,
    this.color,
    this.zoom = 1.0,
    Vector3? position,
    this.animationDuration = defaultAnimationDuration,
    this.borderRadius = 0,
  }) : position = position ?? Vector3.zero();

  Key? get key => id == null ? null : Key('fixture_$id');
  Stream<Fixture> get stream => FixtureBloc().streamFor(key);

  bool within(int? interleave, int? offset) {
    if (id == null || interleave == null) {
      return true;
    }

    offset ??= 0;

    return (id! + offset) % interleave == 0;
  }

  Vector3 calculatePositionFrom(Fixture from, {required Animation<double> controller}) {
    return Vector3(
      Tween<double>(begin: from.position.x, end: position.x).evaluate(controller),
      Tween<double>(begin: from.position.y, end: position.y).evaluate(controller),
      Tween<double>(begin: from.position.z, end: position.z).evaluate(controller),
    );
  }

  double calculateZoomFrom(Fixture from, {required Animation<double> controller}) {
    final tween = Tween<double>(begin: from.zoom, end: zoom);
    return tween.evaluate(controller);
  }

  Fixture copyWith({
    int? id,
    Color? color,
    double? zoom,
    Vector3? position,
    Duration? animationDuration,
    double? borderRadius,
  }) {
    return Fixture(
      id: id ?? this.id,
      color: color ?? this.color,
      zoom: zoom ?? this.zoom,
      position: position ?? this.position,
      animationDuration: animationDuration ?? this.animationDuration,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
}
