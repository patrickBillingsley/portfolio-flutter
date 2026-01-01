import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:patrick_billingsley_portfolio/constants.dart';
import 'package:patrick_billingsley_portfolio/widgets/matrix_column_painter.dart';

class MatrixColumn extends StatefulWidget {
  const MatrixColumn({super.key});

  @override
  State<MatrixColumn> createState() => _MatrixColumnState();
}

class _MatrixColumnState extends State<MatrixColumn> {
  final List<String> _characters = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 140), (_) {
      setState(() {
        if (_characters.length > 60) {
          _characters.clear();
        }
        _characters.add(characters.sample(1).first);
        // final random = Random().nextInt(_characters.length);
        // _characters.replaceRange(random, random, [characters.sample(1).first]);
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
    return CustomPaint(
      painter: MatrixColumnPainter(
        characters: _characters,
      ),
    );

    // return ShaderMask(
    //   blendMode: BlendMode.srcATop,
    //   shaderCallback: (bounds) {
    //     return LinearGradient(
    //       begin: AlignmentGeometry.topCenter,
    //       end: AlignmentGeometry.bottomCenter,
    //       stops: [0.0, 0.02, 0.1, 0.4, 0.9],
    //       colors: [
    //         CustomColors.matrixBlack,
    //         CustomColors.matrixGreen.shade600,
    //         CustomColors.matrixGreen.shade500,
    //         CustomColors.matrixGreen.shade400,
    //         CustomColors.matrixGreen.shade300,
    //       ],
    //     ).createShader(bounds);
    //   },
    //   child: SingleChildScrollView(
    //     physics: NeverScrollableScrollPhysics(),
    //     child: Column(
    //       children: List.generate(_characterCount, (index) {
    //         return Opacity(
    //           opacity: index < _characterCount - _maxCharacterCount ? 0 : 1,
    //           child: RandomText(
    //             key: ValueKey(index),
    //           ),
    //         );
    //       }),
    //     ),
    //   ),
    // );
  }
}
