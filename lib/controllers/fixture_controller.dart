import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

class FixtureController {
  Ticker? _ticker;

  final List<Fixture> _fixtures = [];

  bool get isPlaying => _ticker?.isActive ?? false;

  void register(Fixture fixture) {
    _fixtures.insert(fixture.index, fixture);
  }

  void stop() {
    _ticker?.stop();
    for (final fixture in _fixtures) {
      fixture.update(zoom: 1.0);
    }
  }

  void pulse({
    Duration? duration,
    double min = 0.5,
    double max = 1.0,
  }) {
    _ticker?.dispose();
    _ticker = Ticker((elapsed) {
      if (duration != null && elapsed > duration) {
        _ticker?.stop();
        return;
      }

      final timeInSeconds = elapsed.inMilliseconds / 1000.0;
      for (var i = 0; i < _fixtures.length; i++) {
        final sineWave = SineWaveGenerator(phase: 90 * (i + 1));
        _fixtures[i].update(
          zoom: sineWave.getNormalizedValue(timeInSeconds, min: min, max: max),
        );
      }
    })..start();
  }
}

class SineWaveGenerator {
  double frequency;
  double amplitude;
  double phase;

  SineWaveGenerator({
    this.frequency = 1.0,
    this.amplitude = 1.0,
    this.phase = 90.0,
  });

  double getValue(double time) {
    return amplitude * sin(2 * pi * frequency * time + phase);
  }

  double getNormalizedValue(double time, {double min = 0.0, double max = 1.0}) {
    final normalizedValue = (getValue(time) + amplitude) / (2 * amplitude);
    return min + normalizedValue * (max - min);
  }
}
