import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:rxdart/subjects.dart';

class FixtureBloc {
  static FixtureBloc? _instance;

  factory FixtureBloc() {
    return _instance ??= FixtureBloc._();
  }

  FixtureBloc._();

  final PublishSubject<Fixture> _subject = PublishSubject();
  Stream<Fixture> streamFor(Key? key) {
    if (key == null) {
      _subject.stream;
    }

    return _subject.stream.where((fixture) => fixture.key == key);
  }

  void push(List<Fixture> fixtures) {
    fixtures.forEach(_subject.sink.add);

    // for (var i = 0; i < 100; i++) {
    //   final key = Key('fixture_$i');
    //   // final color = i < 50 ? Colors.red : Colors.blue;
    //   final color = i % 3 == 0 ? Colors.green : Colors.red;

    //   _subject.sink.add(
    //     Fixture(
    //       key: key,
    //       color: color,
    //     ),
    //   );
    // }
  }
}
