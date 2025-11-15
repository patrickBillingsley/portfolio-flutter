import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/services/scroll_service.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

class DistanceScrollWidget extends StatefulWidget {
  const DistanceScrollWidget({super.key});

  @override
  State<DistanceScrollWidget> createState() => _DistanceScrollWidgetState();
}

class _DistanceScrollWidgetState extends State<DistanceScrollWidget> {
  late final StreamSubscription<Offset> _scrollSubscription;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollSubscription = ScrollService().offsetStream.listen(_setScrollController);
  }

  @override
  void dispose() {
    _scrollSubscription.cancel();
    super.dispose();
  }

  void _setScrollController(Offset offset) {
    _scrollController.jumpTo(offset.dy);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translateByVector3(Vector3(0, 900, 0))
        ..rotateX(1.1),
      alignment: AlignmentGeometry.topLeft,
      child: SingleChildScrollView(
        controller: _scrollController,
        clipBehavior: Clip.none,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Column(
            spacing: 1200,
            children: List.generate(40, (index) {
              return SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: FixtureWidget(
                        Fixture(
                          id: index,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateX(-1)
                        ..rotateY(-0.1)
                        ..translateByVector3(Vector3(0, 0, -60)),
                      alignment: Alignment.bottomCenter,
                      child: Icon(
                        Icons.email_sharp,
                        size: 200,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
