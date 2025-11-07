import 'package:flutter/gestures.dart';
import 'package:rxdart/subjects.dart';

class MouseService {
  static MouseService? _instance;

  factory MouseService() {
    return _instance ??= MouseService._();
  }

  MouseService._();

  final PublishSubject<Offset> _positionSubject = PublishSubject();
  Stream<Offset> get positionStream => _positionSubject.stream;

  void setPosition(PointerHoverEvent event) {
    _positionSubject.add(event.position);
  }

  void clearPosition(PointerExitEvent event) {
    _positionSubject.add(Offset(-1000, -1000));
  }
}
