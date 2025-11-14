import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/main_screen.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/services/scroll_service.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

final scenes = [
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: Colors.blueGrey,
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: index % 3 == 0 ? Colors.green : Colors.red,
      position: Vector3(
        index % 3 == 0 ? 100 : 0,
        index % 3 == 0 ? 10 : 0,
        index % 3 == 0 ? 30 : -60,
      ),
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: Color.lerp(Colors.green, Colors.red, index / 100),
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: index.isEven ? Colors.blue : Colors.blueGrey,
      position: Vector3(
        index.isEven ? -20 : 20,
        index.isEven ? 25 : -25,
        index.isEven ? 25 : -25,
      ),
    );
  }),
];

void main() {
  FixtureBloc().scenes.addAll(scenes);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Listener(
        onPointerSignal: ScrollService().updateScrollOffset,
        child: MainScreen(),
      ),
    );
  }
}
