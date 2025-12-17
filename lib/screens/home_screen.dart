import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController = ScrollController(initialScrollOffset: center);

  int itemCount = 5;
  int selectedIndex = 2;

  Size get availableSpace => MediaQuery.sizeOf(context);
  double get containerHeight => availableSpace.height;
  double get containerWidth => availableSpace.width * 0.7;

  double get center => scrollOffsetFor(2);

  double scrollOffsetFor(int index) {
    final leftEdge = containerWidth * index;
    return leftEdge - (availableSpace.width * 0.15);
  }

  void _nextIndex() {
    if (selectedIndex >= itemCount) return;

    _scrollController.animateTo(
      scrollOffsetFor(++selectedIndex),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  void _lastIndex() {
    if (selectedIndex <= 0) return;

    _scrollController.animateTo(
      scrollOffsetFor(--selectedIndex),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemExtent: containerWidth,
              itemCount: itemCount,
              itemBuilder: (_, index) {
                final showGrid = index == 2;

                return Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: index.isEven ? Colors.blueGrey.shade900 : Colors.grey.shade900,
                  child: Stack(
                    children: [
                      Center(
                        child: showGrid ? FixtureGrid() : Text('Hello'),
                      ),
                    ],
                  ),
                );
              },
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipPath(
                    clipper: LeftClipper(),
                    child: GestureDetector(
                      onTap: _lastIndex,
                      child: Container(
                        width: availableSpace.width * 0.05,
                        height: availableSpace.width * 0.1,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: RightClipper(),
                    child: GestureDetector(
                      onTap: _nextIndex,
                      child: Container(
                        width: availableSpace.width * 0.05,
                        height: availableSpace.width * 0.1,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
