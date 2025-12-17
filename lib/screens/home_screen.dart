import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController = ScrollController(initialScrollOffset: center);

  Size get availableSpace => MediaQuery.sizeOf(context);
  double get containerHeight => availableSpace.height;
  double get containerWidth => availableSpace.width * 0.7;

  double get center => scrollOffsetFor(3);

  double scrollOffsetFor(int index) {
    final containerCenter = containerWidth * index / 2;
    return containerCenter - availableSpace.width / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (_, index) {
            return Container(
              height: containerHeight,
              width: containerWidth,
              color: index.isEven ? Colors.blueGrey.shade900 : Colors.grey.shade900,
            );
          },
        ),
      ),
    );
  }
}
