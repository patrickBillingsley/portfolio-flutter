import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/matrix_column.dart';

class RandomText extends StatefulWidget {
  const RandomText({super.key});

  @override
  State<RandomText> createState() => _RandomTextState();
}

class _RandomTextState extends State<RandomText> {
  Timer? _timer;
  String _character = characters.sample(1).first;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      setState(() {
        _character = characters.sample(1).first;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(_character);
  }
}
