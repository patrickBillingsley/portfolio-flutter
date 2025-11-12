import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/main_screen.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';

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
      offset: Offset(
        index % 3 == 0 ? 100 : 0,
        index % 3 == 0 ? 10 : 0,
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
      offset: Offset(
        index.isEven ? -20 : 20,
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
      home: MainScreen(),
    );
  }
}
