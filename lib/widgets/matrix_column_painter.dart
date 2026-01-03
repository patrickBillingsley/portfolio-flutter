import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:patrick_billingsley_portfolio/constants.dart';
import 'package:patrick_billingsley_portfolio/main.dart';

class MatrixColumnPainter extends CustomPainter {
  final Animation<double> controller;
  final List<String>? chars;
  final double? charHeight;
  final Function({required List<String> chars, required double charHeight}) characterSetter;

  MatrixColumnPainter({
    required this.controller,
    this.chars,
    this.charHeight = 0,
    required this.characterSetter,
  });

  ui.TextStyle get defaultStyle => ui.TextStyle(
    fontSize: 20,
    fontFamily: 'SourceCodePro',
  );

  double _calcCharHeight(double width) {
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle());
    builder.pushStyle(defaultStyle);
    builder.addText('A');
    final temp = builder.build()..layout(ui.ParagraphConstraints(width: width));

    return temp.height;
  }

  Paint _gradientFrom(Size size) {
    final stops = [0.01, 0.02, 0.1, 0.4, 0.95, 0.95];
    final range = List.generate(chars!.length + 40, (index) {
      return index - 20;
    });
    final index = (clampDouble(range.length * controller.value, 0, range.length - 1)).floor();
    final top = charHeight! * range[index];
    return Paint()
      ..shader = LinearGradient(
        begin: AlignmentGeometry.topCenter,
        end: AlignmentGeometry.bottomCenter,
        stops: stops,
        colors: [
          Color(0x00000000),
          CustomColors.matrixGreen.shade600,
          CustomColors.matrixGreen.shade500,
          CustomColors.matrixGreen.shade400,
          CustomColors.matrixGreen.shade300,
          Color(0x00000000),
        ],
      ).createShader(Rect.fromLTWH(0, top, size.width, size.height));
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (chars == null || charHeight == null) {
      final charHeight = _calcCharHeight(size.width);
      final charCount = (size.height / charHeight).round();
      characterSetter.call(
        chars: characters.sample(charCount),
        charHeight: charHeight,
      );

      return;
    }

    final paint = _gradientFrom(Size(size.width, charHeight! * 20));
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle());
    builder.pushStyle(
      ui.TextStyle(
        fontSize: 20,
        fontFamily: 'SourceCodePro',
        foreground: paint,
      ),
    );
    builder.addText(chars!.join('\n'));
    final paragraph = builder.build()..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(MatrixColumnPainter oldDelegate) {
    return true;
  }
}
