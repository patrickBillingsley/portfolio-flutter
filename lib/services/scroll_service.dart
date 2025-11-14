import 'package:flutter/gestures.dart';
import 'package:rxdart/subjects.dart';

class ScrollService {
  static ScrollService? _instance;

  factory ScrollService() {
    return _instance ??= ScrollService._();
  }

  ScrollService._();

  final BehaviorSubject<Offset> _offsetSubject = BehaviorSubject.seeded(Offset.zero);
  Stream<Offset> get offsetStream => _offsetSubject.stream;

  void updateScrollOffset(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      _offsetSubject.add(_offsetSubject.value + event.scrollDelta);
    }
  }
}
