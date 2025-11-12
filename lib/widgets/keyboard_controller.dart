import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';

class KeyboardController extends StatefulWidget {
  final Widget child;

  const KeyboardController({
    super.key,
    required this.child,
  });

  @override
  State<KeyboardController> createState() => _KeyboardControllerState();
}

class _KeyboardControllerState extends State<KeyboardController> {
  final FocusNode _focus = FocusNode();

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          FixtureBloc().move(Offset(0, -10));
        case LogicalKeyboardKey.arrowDown:
          FixtureBloc().move(Offset(0, 10));
        case LogicalKeyboardKey.arrowLeft:
          FixtureBloc().move(Offset(-10, 0));
        case LogicalKeyboardKey.arrowRight:
          FixtureBloc().move(Offset(10, 0));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: _handleKeyEvent,
      focusNode: _focus,
      autofocus: true,
      child: widget.child,
    );
  }
}
