import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/services/mouse_service.dart';

class PolkaDots extends StatelessWidget {
  final Widget image;

  const PolkaDots({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final cellWidth = constraints.biggest.width * 0.1;
        final columnCount = constraints.biggest.width / cellWidth;
        final rowCount = constraints.biggest.height / cellWidth;
        final initialOffset = Offset(cellWidth * 0.5, cellWidth * 0.5);

        final dots = <Widget>[];
        for (var row = 0; row < rowCount; row++) {
          for (var column = 0; column < columnCount; column++) {
            final offset = Offset(cellWidth * column, cellWidth * row) + initialOffset;
            dots.add(
              Positioned.fill(
                child: PolkaDot(
                  offset: offset,
                  width: cellWidth,
                  height: cellWidth,
                  child: image,
                ),
              ),
            );
          }
        }

        return Stack(
          children: dots,
        );
      },
    );
  }
}

class PolkaDot extends StatefulWidget {
  final Offset offset;
  final double width;
  final double height;
  final Widget child;

  PolkaDot({
    super.key,
    required this.offset,
    required this.width,
    required this.height,
    required this.child,
  }) : area = Rect.fromCenter(center: offset, width: width, height: height);

  final Rect area;

  @override
  State<PolkaDot> createState() => _PolkaDotState();
}

class _PolkaDotState extends State<PolkaDot> {
  late final StreamSubscription<Offset> _mousePositionSubscription;

  Offset _mousePosition = Offset(-1, -1);
  double get radius {
    final distance = (widget.offset - _mousePosition).distance;
    final maxDistance = widget.width * 2;
    final normalizedDistance = (distance / maxDistance).clamp(0.0, 1.0);
    final radiusFactor = 0.2 + (1.0 - normalizedDistance);

    return widget.width * radiusFactor;
  }

  @override
  void initState() {
    super.initState();
    _mousePositionSubscription = MouseService().positionStream.listen(_setMousePosition);
  }

  @override
  void dispose() {
    _mousePositionSubscription.cancel();
    super.dispose();
  }

  void _setMousePosition(Offset position) {
    print('Updating position!');
    setState(() {
      _mousePosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipper: _PolkaDotClipper(
        center: widget.offset,
        radius: radius,
      ),
      child: widget.child,
    );
  }
}

class _PolkaDotClipper extends CustomClipper<Rect> {
  final Offset center;
  final double radius;

  const _PolkaDotClipper({
    required this.center,
    required this.radius,
  });

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(
      center: center,
      radius: radius,
    );
  }

  @override
  bool shouldReclip(_PolkaDotClipper oldClipper) {
    return center != oldClipper.center || radius != oldClipper.radius;
  }
}
