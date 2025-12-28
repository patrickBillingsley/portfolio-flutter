import 'package:flutter/material.dart';

mixin Navigation {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void show() {
    assert(this is Widget);
    assert(navigatorKey.currentState != null);
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (_) => this as Widget,
      ),
    );
  }
}
