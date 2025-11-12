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

  int _interleave = 0;
  int _offset = 0;

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          FixtureBloc().move(Offset(0, -10), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowDown:
          FixtureBloc().move(Offset(0, 10), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowLeft:
          FixtureBloc().move(Offset(-10, 0), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowRight:
          FixtureBloc().move(Offset(10, 0), interleave: _interleave, offset: _offset);
      }
    }
  }

  void _onInterleaveChanged(double interleaveString) {
    setState(() {
      _interleave = interleaveString.toInt();
    });
  }

  void _onOffsetChanged(double offset) {
    setState(() {
      _offset = offset.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: _handleKeyEvent,
      focusNode: _focus,
      autofocus: true,
      child: Material(
        child: Stack(
          children: [
            widget.child,
            Positioned(
              height: 200,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Interleave',
                          style: Theme.of(context).primaryTextTheme.labelLarge,
                        ),
                        Slider(
                          value: _interleave.toDouble(),
                          min: 1,
                          max: 10,
                          divisions: 8,
                          onChanged: _onInterleaveChanged,
                        ),
                        Text(
                          _interleave.toString(),
                          style: Theme.of(context).primaryTextTheme.labelLarge,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Offset',
                          style: Theme.of(context).primaryTextTheme.labelLarge,
                        ),
                        Slider(
                          value: _offset.toDouble(),
                          max: 10,
                          divisions: 9,
                          onChanged: _onOffsetChanged,
                        ),
                        Text(
                          _offset.toString(),
                          style: Theme.of(context).primaryTextTheme.labelLarge,
                        ),
                      ],
                    ),
                    Spacer(),
                    FilledButton(
                      onPressed: FixtureBloc().nextScene,
                      style: FilledButton.styleFrom(
                        fixedSize: Size(100, 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(16),
                        ),
                      ),
                      child: Text('Tap'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
