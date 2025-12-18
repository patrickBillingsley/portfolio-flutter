import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int maxIndex = 4;
  int selectedIndex = 2;
  int indexOffset = -2;

  void _turnRight() {
    if (selectedIndex <= 0) return;

    setState(() {
      selectedIndex--;
      indexOffset--;
    });
  }

  void _turnLeft() {
    if (selectedIndex >= maxIndex) return;

    setState(() {
      selectedIndex++;
      indexOffset++;
    });
  }

  Matrix4 transformFor(int index) {
    final factor = 0.8;

    return Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(factor * index)
      ..translateByVector3(Vector3(0, 0, 1000));
  }

  final List<Color> _colors = const [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.sizeOf(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ...List.generate(5, (index) {
          return Portal(
            index: index + indexOffset,
            color: _colors[index],
          );
        }),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipPath(
                clipper: LeftClipper(),
                child: GestureDetector(
                  onTap: _turnLeft,
                  child: Container(
                    width: space.width * 0.05,
                    height: space.width * 0.1,
                    color: Colors.amber,
                  ),
                ),
              ),
              ClipPath(
                clipper: RightClipper(),
                child: GestureDetector(
                  onTap: _turnRight,
                  child: Container(
                    width: space.width * 0.05,
                    height: space.width * 0.1,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..arcToPoint(
        Offset(0, size.height),
        radius: Radius.circular(size.width),
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, size.height)
      ..arcToPoint(
        Offset(size.width, 0),
        radius: Radius.circular(size.width),
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

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

class _PortalState extends State<Portal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );

  late final Animation<double> _curvedAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late Tween<double> _tween = Tween(
    begin: _rotationFor(widget.index),
    end: _rotationFor(widget.index),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
  }

  @override
  void didUpdateWidget(Portal oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.index != oldWidget.index) {
      _tween = Tween(
        begin: _tween.evaluate(_curvedAnimation),
        end: _rotationFor(widget.index),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  double _rotationFor(int index) {
    final factor = 0.8;
    return factor * index;
  }

  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.sizeOf(context);

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(_tween.evaluate(_curvedAnimation))
        ..translateByVector3(Vector3(0, 0, 1000)),
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: Container(
          width: space.width,
          height: space.height * 1.15,
          color: widget.color,
        ),
      ),
    );
  }
}
