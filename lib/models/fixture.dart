import 'package:flutter/material.dart';

class Fixture extends ChangeNotifier {
  final int col;
  final int row;
  Offset _center;
  double _radius;
  Color _color;
  double _zoom;

  Offset get center => _center;
  double get radius => _radius;
  Color get color => _color;
  double get zoom => _zoom;

  Fixture({
    this.col = 0,
    this.row = 0,
    Offset center = Offset.zero,
    double radius = 100,
    Color color = Colors.red,
    double zoom = 1.0,
  }) : _center = center,
       _radius = radius,
       _color = color,
       _zoom = zoom;

  Key get key => Key('fixture_${col}_$row');

  void update({
    Offset? center,
    double? radius,
    Color? color,
    double? zoom,
  }) {
    _center = center ?? _center;
    _radius = radius ?? _radius;
    _color = color ?? _color;
    _zoom = zoom ?? _zoom;

    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Fixture && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
