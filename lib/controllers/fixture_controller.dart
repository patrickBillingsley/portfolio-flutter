import 'dart:async';

import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:rxdart/subjects.dart';

class FixtureController {
  final BehaviorSubject<Set<Fixture>> _subject = BehaviorSubject.seeded({});
  List<Fixture> get fixtures => List.from(_subject.value);

  Stream<Fixture> streamFor(Fixture fixture) {
    return _subject.stream.map((event) {
      return event.firstWhere((f) => f.key == fixture.key);
    });
  }

  void register(Fixture fixture) {
    final updatedFixtures = fixtures
      ..remove(fixture)
      ..add(fixture);
    _subject.add(updatedFixtures.toSet());
  }

  Future<void> pulse() async {
    final duration = const Duration(milliseconds: 100);
    for (var i = 0; i < fixtures.length; i++) {
      final fixture = fixtures.elementAt(i);
      _subject.add(
        Set<Fixture>.from(
          fixtures..replaceRange(i, i, [
            fixture.copyWith(
              zoom: 0.5,
            ),
          ]),
        ),
      );
      await Future.delayed(duration);
    }
    for (var i = 0; i < fixtures.length; i++) {
      final fixture = fixtures.elementAt(i);
      _subject.add(
        Set<Fixture>.from(
          fixtures..replaceRange(i, i, [
            fixture.copyWith(
              zoom: 1.0,
            ),
          ]),
        ),
      );
      await Future.delayed(duration);
    }
  }
}
