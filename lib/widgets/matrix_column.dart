import 'package:flutter/widgets.dart';
import 'package:patrick_billingsley_portfolio/widgets/matrix_column_painter.dart';

class MatrixColumn extends StatefulWidget {
  final Animation<double> animation;

  const MatrixColumn({
    super.key,
    required this.animation,
  });

  @override
  State<MatrixColumn> createState() => _MatrixColumnState();
}

class _MatrixColumnState extends State<MatrixColumn> {
  List<String>? _chars;
  double? _charHeight;

  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.animation.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  void _setCharacters({required List<String> chars, required double charHeight}) {
    _chars = chars;
    _charHeight = charHeight;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MatrixColumnPainter(
        controller: widget.animation,
        chars: _chars,
        charHeight: _charHeight,
        characterSetter: _setCharacters,
      ),
    );
  }
}
