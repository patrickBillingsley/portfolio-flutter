import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/screens/matrix_transition_screen.dart';

mixin Navigation {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void show() {
    assert(this is Widget);
    assert(navigatorKey.currentState != null);
    navigatorKey.currentState!.push(
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 2),
        reverseTransitionDuration: const Duration(seconds: 2),
        pageBuilder: (context, animation, secondaryAnimation) => this as Widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Stack(
            children: [
              FadeTransition(
                opacity: animation,
                child: child,
              ),
              if (animation.value < 1.0)
                MatrixTransitionScreen(
                  animation: animation,
                ),
            ],
          );
        },
      ),
    );
  }
}
