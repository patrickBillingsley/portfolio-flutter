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
        reverseTransitionDuration: const Duration(milliseconds: 2),
        pageBuilder: (context, animation, secondaryAnimation) => this as Widget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (animation.isCompleted) {
            return child;
          }

          return Stack(
            children: [
              ClipRect(
                clipper: SwipeClipper(animation: animation),
                child: child,
              ),
              if (!animation.isCompleted && animation.isForwardOrCompleted) MatrixTransitionScreen(),
            ],
          );
        },
      ),
    );
  }
}

class SwipeClipper extends CustomClipper<Rect> {
  final Animation<double> animation;

  const SwipeClipper({
    required this.animation,
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height * animation.value,
    );
  }

  @override
  bool shouldReclip(_) => true;
}
