import 'package:flutter/material.dart';

class Fixture extends Object {
  final Key? key;
  final Offset center;
  final double radius;
  final Color color;
  final double zoom;

  const Fixture({
    this.key,
    this.center = Offset.zero,
    this.radius = 100,
    this.color = Colors.red,
    this.zoom = 1.0,
  });

  Fixture copyWith({
    double? zoom,
  }) {
    return Fixture(
      key: key,
      center: center,
      radius: radius,
      color: color,
      zoom: zoom ?? this.zoom,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Fixture && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
