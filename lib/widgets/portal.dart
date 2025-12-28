import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Portal extends StatefulWidget {
  final VoidCallback? onTap;
  final int index;
  final Color color;

  const Portal({
    super.key,
    this.onTap,
    required this.index,
    this.color = Colors.red,
  });

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> with TickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final Animation<double> _rotationAnimation = CurvedAnimation(
    parent: _rotationController,
    curve: Curves.easeOut,
  );

  late Tween<double> _rotationTween = Tween(
    begin: _rotationDegreesFor(widget.index),
    end: _rotationDegreesFor(widget.index),
  );

  late final AnimationController _zAxisController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _zAxisAnimation = CurvedAnimation(
    parent: _zAxisController,
    curve: Curves.easeInOut,
  );

  late final Tween<double> _zAxisTween = Tween(
    begin: 0,
    end: MediaQuery.sizeOf(context).width,
  );

  @override
  void initState() {
    super.initState();
    _rotationController.addListener(_refresh);
    _zAxisController.addListener(_refresh);
  }

  @override
  void didUpdateWidget(Portal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _rotationTween = Tween(
        begin: _rotationTween.evaluate(_rotationAnimation),
        end: _rotationDegreesFor(widget.index),
      );
      _rotationController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _rotationController.removeListener(_refresh);
    _zAxisController.removeListener(_refresh);
    super.dispose();
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap?.call();
    } else {
      if (_zAxisController.isForwardOrCompleted) {
        _zAxisController.reverse();
      } else {
        _zAxisController.forward();
      }
    }
  }

  double _rotationDegreesFor(int index) {
    final factor = 45.0;
    return factor * index;
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.sizeOf(context);
    final radius = space.width;
    final radians = _rotationTween.evaluate(_rotationAnimation) * pi / 180;

    return GestureDetector(
      onTap: _onTap,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translateByVector3(Vector3(radius * sin(radians), 0, radius * cos(radians) - _zAxisTween.evaluate(_zAxisAnimation)))
          ..rotateY(radians),
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Container(
            width: space.width * 0.8,
            height: space.height,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
