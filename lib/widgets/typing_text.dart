import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TypingText extends StatefulWidget {
  final String text;

  const TypingText(
    this.text, {
    super.key,
  });

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  Timer? _timer;

  String _text = '';

  @override
  void initState() {
    super.initState();
    _typeCharacters();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _typeCharacters() {
    final min = 50;
    final max = 150;

    _timer = Timer(
      Duration(milliseconds: _randomNumber(min, max)),
      () {
        if (!mounted) return;

        if (_text.length >= widget.text.length) {
          _timer?.cancel();
          _timer = null;
          return;
        }

        setState(() {
          _text = _text + widget.text[_text.length];
        });

        _typeCharacters();
      },
    );
  }

  int _randomNumber(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  @override
  Widget build(BuildContext context) {
    return Text(_text);
  }
}
