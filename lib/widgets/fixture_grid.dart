import 'dart:async';

import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/services/scroll_service.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';

class FixtureGrid extends StatefulWidget {
  const FixtureGrid({super.key});

  @override
  State<FixtureGrid> createState() => _FixtureGridState();
}

class _FixtureGridState extends State<FixtureGrid> {
  late final StreamSubscription<Offset> _scrollSubscription;

  Offset _scrollOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollSubscription = ScrollService().offsetStream.listen(_setScrollOffset);
  }

  @override
  void dispose() {
    _scrollSubscription.cancel();
    super.dispose();
  }

  void _setScrollOffset(Offset offset) {
    setState(() {
      _scrollOffset = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(_scrollOffset.dx * 0.01)
          ..rotateX(_scrollOffset.dy * 0.01),
        alignment: FractionalOffset.center,
        child: GridView.count(
          crossAxisCount: 10,
          padding: const EdgeInsets.all(12),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          clipBehavior: Clip.none,
          children: [
            ...FixtureBloc().currentScene.map(FixtureWidget.new),
          ],
        ),
      ),
    );
  }
}
