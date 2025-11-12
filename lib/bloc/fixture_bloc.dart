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

  int _sceneIndex = 0;
  final List<List<Fixture>> scenes = [];
  List<Fixture> get currentScene => scenes[_sceneIndex];

  final PublishSubject<Message> _messageSubject = PublishSubject();
  Stream<Message> get messageStream => _messageSubject.stream;

  void push(List<Fixture> fixtures) {
    fixtures.forEach(_subject.sink.add);
  }

  void nextScene() {
    if (_sceneIndex >= scenes.length - 1) {
      _sceneIndex = 0;
    } else {
      _sceneIndex++;
    }

    push(scenes[_sceneIndex]);
  }

  void move(Offset position, {int? interleave, int? offset}) {
    _messageSubject.sink.add(
      MoveMessage(
        position,
        interleave: interleave,
        offset: offset,
      ),
    );
  }
}

abstract class Message {
  final int? interleave;
  final int? offset;

  const Message({
    this.interleave,
    this.offset,
  });

  bool pertainsTo(Fixture fixture) {
    final id = fixture.id;
    if (id == null) {
      return false;
    }

    final interleave = this.interleave ?? 0;
    final offset = this.offset ?? 0;

    return (id + offset) % interleave == 0;
  }
}

class MoveMessage extends Message {
  final Offset position;

  const MoveMessage(
    this.position, {
    super.interleave,
    super.offset,
  });
}
