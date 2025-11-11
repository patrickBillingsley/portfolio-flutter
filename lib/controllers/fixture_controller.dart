import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

class FixtureController with ChangeNotifier {
  final AnimationController _animation;
  final double lowerBound;
  final double upperBound;
  final int cols;
  final int rows;

  final List<List<Fixture?>> _fixtures = [];
  List<Fixture> get fixtures => List.from(_fixtures.flattenedToList.nonNulls);

  FixtureController({
    double? value,
    this.lowerBound = double.negativeInfinity,
    this.upperBound = double.infinity,
    this.cols = 10,
    this.rows = 10,
    required TickerProvider vsync,
  }) : assert(upperBound >= lowerBound),
       _animation = AnimationController(
         vsync: vsync,
         lowerBound: lowerBound,
         upperBound: upperBound,
         value: value,
       ) {
    for (var row = 0; row < rows; row++) {
      _fixtures.add(List<Fixture?>.filled(cols, null));
    }
    _animation.addListener(_pulse);
  }

  double get value => _animation.value;
  bool get isAnimating => _animation.isAnimating;

  @override
  void dispose() {
    _animation.removeListener(_pulse);
    _animation.dispose();
    super.dispose();
  }

  void register(Fixture fixture) {
    _fixtures[fixture.row][fixture.col] = fixture;
  }

  void stop({bool canceled = true}) {
    _animation.stop();
    notifyListeners();
  }

  void reset() {}

  void pulse({
    Duration duration = const Duration(seconds: 120),
    double min = 0.5,
    double max = 1.0,
    Color colorMin = Colors.blue,
    Color colorMax = Colors.cyanAccent,
  }) {
    _animation.repeat(min: min, max: max, reverse: true, period: duration);
    notifyListeners();
  }

  void _pulse() {
    // final timeInSeconds = (_animation.lastElapsedDuration?.inMilliseconds ?? 0) / 1000.0;
    for (var i = 0; i < fixtures.length; i++) {
      final fixture = fixtures[i];
      // final sineWave = SineWaveGenerator(phase: 90 * (i + 1));
      final normalizedValue = sin(2 * pi * i * _animation.value);
      final newOffset = Offset(fixture.originCenter.dx * normalizedValue, fixture.originCenter.dy * normalizedValue);
      fixture.update(
        center: newOffset,
        zoom: normalizedValue,
        color: Color.lerp(
          (_animation.value > 0.5 ? Colors.blue : Colors.green),
          (_animation.value > 0.3 ? Colors.orange : Colors.purple),
          normalizedValue,
        ),
      );
    }
  }
}

// class SineWaveGenerator {
//   double frequency;
//   double amplitude;
//   double phase;

//   SineWaveGenerator({
//     this.frequency = 1.0,
//     this.amplitude = 1.0,
//     this.phase = 90.0,
//   });

//   double getValue(double time) {
//     return amplitude * sin(2 * pi * frequency * time + phase);
//   }

//   double getNormalizedValue(double time, {double min = 0.0, double max = 1.0}) {
//     final normalizedValue = (getValue(time) + amplitude) / (2 * amplitude);
//     return min + normalizedValue * (max - min);
//   }
// }
