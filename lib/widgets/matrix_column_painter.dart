import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrick_billingsley_portfolio/main.dart';

class MatrixColumnPainter extends CustomPainter {
  final List<String> characters;

  const MatrixColumnPainter({
    required this.characters,
  });

  String get text => characters.join('\n');
  ui.TextStyle get defaultStyle => ui.TextStyle(
    fontSize: 20,
    fontFamily: GoogleFonts.sourceCodePro().fontFamily,
  );

  double _calculateCharacterHeight(double width) {
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle());
    builder.pushStyle(defaultStyle);
    builder.addText('A');
    final temp = builder.build()..layout(ui.ParagraphConstraints(width: width));

    return temp.height;
  }

  Paint _gradientFrom(Size size) {
    final charHeight = _calculateCharacterHeight(size.width);
    final charCount = characters.length;
    final top = charHeight * (charCount - 20);

    return Paint()
      ..shader = LinearGradient(
        begin: AlignmentGeometry.topCenter,
        end: AlignmentGeometry.bottomCenter,
        stops: [0.0, 0.02, 0.1, 0.4, 0.9],
        colors: [
          CustomColors.matrixBlack,
          CustomColors.matrixGreen.shade600,
          CustomColors.matrixGreen.shade500,
          CustomColors.matrixGreen.shade400,
          CustomColors.matrixGreen.shade300,
        ],
      ).createShader(Rect.fromLTWH(0, top, size.width, charHeight * 20));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = _gradientFrom(size);
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle());
    builder.pushStyle(
      ui.TextStyle(
        fontSize: 20,
        fontFamily: GoogleFonts.sourceCodePro().fontFamily,
        foreground: paint,
      ),
    );
    builder.addText(text);
    final paragraph = builder.build()..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(MatrixColumnPainter oldDelegate) {
    return characters.equals(oldDelegate.characters);
  }
}
