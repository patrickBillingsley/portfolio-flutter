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
      return _subject.stream;
    }

    return _subject.stream.where((fixture) => fixture.key == key);
  }

  final PublishSubject<Message> _messageSubject = PublishSubject();
  Stream<Message> get messageStream => _messageSubject.stream;

  void push(List<Fixture> fixtures) {
    fixtures.forEach(_subject.sink.add);
  }

  void move(Offset offset) {
    _messageSubject.sink.add(MoveMessage(offset));
  }
}

abstract class Message {
  const Message();
}

class MoveMessage extends Message {
  final Offset offset;

  const MoveMessage(this.offset);
}
