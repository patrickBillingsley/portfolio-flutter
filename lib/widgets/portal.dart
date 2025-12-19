import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class Portal extends StatefulWidget {
  final int index;
  final Color color;

  const Portal({
    super.key,
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
    begin: _rotationFor(widget.index),
    end: _rotationFor(widget.index),
  );

  late final AnimationController _zAxisController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _zAxisAnimation = CurvedAnimation(
    parent: _zAxisController,
    curve: Curves.easeInOut,
  );

  final Tween<double> _zAxisTween = Tween(
    begin: 0,
    end: 1000,
  );

  @override
  void initState() {
    super.initState();
    _rotationController.addListener(_refresh);

    _zAxisController.value = 1.0;
    _zAxisController.addListener(_refresh);
  }

  @override
  void didUpdateWidget(Portal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _rotationTween = Tween(
        begin: _rotationTween.evaluate(_rotationAnimation),
        end: _rotationFor(widget.index),
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

  void _selectPortal() {
    if (_zAxisController.isForwardOrCompleted) {
      _zAxisController.reverse();
    } else {
      _zAxisController.forward();
    }
  }

  double _rotationFor(int index) {
    final factor = 0.8;
    return factor * index;
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: _selectPortal,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_rotationTween.evaluate(_rotationAnimation))
          ..translateByVector3(Vector3(0, 0, _zAxisTween.evaluate(_zAxisAnimation))),
        child: OverflowBox(
          maxWidth: double.infinity,
          maxHeight: double.infinity,
          child: Container(
            width: space.width,
            height: space.height * 1.15,
            color: widget.color,
          ),
        ),
      ),
    );
  }
}
