import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/services/scroll_service.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

class KeyboardController extends StatefulWidget {
  const KeyboardController({super.key});

  @override
  State<KeyboardController> createState() => _KeyboardControllerState();
}

class _KeyboardControllerState extends State<KeyboardController> {
  final FocusNode _focus = FocusNode();

  int _interleave = 1;
  int _offset = 0;
  double _zoom = 1.0;

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          FixtureBloc().move(Vector3(0, -10, 0), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowDown:
          FixtureBloc().move(Vector3(0, 10, 0), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowLeft:
          FixtureBloc().move(Vector3(-10, 0, 0), interleave: _interleave, offset: _offset);
        case LogicalKeyboardKey.arrowRight:
          FixtureBloc().move(Vector3(10, 0, 0), interleave: _interleave, offset: _offset);
      }
    }
  }

  void _onInterleaveChanged(int interleave) {
    setState(() {
      _interleave = interleave;
      if (_offset > interleave) {
        _offset = _interleave;
      }
    });
  }

  void _onOffsetChanged(int offset) {
    setState(() {
      _offset = offset;
    });
  }

  void _onZoomChanged(double zoom) {
    setState(() {
      _zoom = zoom;
    });
    FixtureBloc().zoom(_zoom, interleave: _interleave, offset: _offset);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      onKeyEvent: _handleKeyEvent,
      focusNode: _focus,
      autofocus: true,
      child: Material(
        color: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ControlSlider<int>(
                onChanged: _onInterleaveChanged,
                label: 'Interleave',
                min: 1,
                value: _interleave,
              ),
              ControlSlider<int>(
                onChanged: _onOffsetChanged,
                label: 'Offset',
                max: _interleave,
                value: _offset,
              ),
              ControlSlider<double>(
                onChanged: _onZoomChanged,
                label: 'Zoom',
                max: 3.0,
                value: _zoom,
              ),
              StreamBuilder<Offset>(
                stream: ScrollService().offsetStream,
                builder: (context, snapshot) {
                  final offset = snapshot.data;

                  return Column(
                    children: [
                      Text(
                        'Scroll Offset',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                      Text(
                        'x: ${offset?.dx ?? '?'} y: ${offset?.dy ?? '?'}',
                        style: Theme.of(context).primaryTextTheme.labelLarge,
                      ),
                    ],
                  );
                },
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
    );
  }
}

class ControlSlider<T extends num> extends StatelessWidget {
  final Function(T)? onChanged;
  final String label;
  final T min;
  final T max;
  final T value;

  ControlSlider({
    super.key,
    this.onChanged,
    this.label = '',
    T? min,
    T? max,
    T? value,
  }) : min = min ?? 0 as T,
       max = max ?? 10 as T,
       value = math.max(min ?? 0 as T, value ?? 0 as T);

  int? get divisions {
    switch (T) {
      case const (int):
        return (max - min).toInt();
      case const (double):
      default:
        return null;
    }
  }

  void _onChanged(double value) {
    switch (T) {
      case const (int):
        onChanged?.call(value.toInt() as T);
      case const (double):
        onChanged?.call(double.parse(value.toStringAsFixed(2)) as T);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
        Slider(
          onChanged: _onChanged,
          min: min.toDouble(),
          max: max.toDouble(),
          divisions: divisions,
          value: value.toDouble(),
        ),
        Text(
          value.toString(),
          style: Theme.of(context).primaryTextTheme.labelLarge,
        ),
      ],
    );
  }
}
