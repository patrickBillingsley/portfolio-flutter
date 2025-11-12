import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_widget.dart';
import 'package:patrick_billingsley_portfolio/widgets/keyboard_controller.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _sceneIndex = 0;

  List<Fixture> get _currentScene => _scenes[_sceneIndex];

  final List<List<Fixture>> _scenes = [
    List.generate(100, (index) {
      return Fixture(
        key: Key('fixture_$index'),
        color: Colors.blueGrey,
      );
    }),
    List.generate(100, (index) {
      final key = Key('fixture_$index');
      return Fixture(
        key: key,
        color: index % 3 == 0 ? Colors.green : Colors.red,
        offset: Offset(
          index % 3 == 0 ? 100 : 0,
          index % 3 == 0 ? 10 : 0,
        ),
      );
    }),
    List.generate(100, (index) {
      final key = Key('fixture_$index');
      return Fixture(
        key: key,
        color: Color.lerp(Colors.green, Colors.red, index / 100),
      );
    }),
    List.generate(100, (index) {
      final key = Key('fixture_$index');
      return Fixture(
        key: key,
        color: index.isEven ? Colors.blue : Colors.blueGrey,
        offset: Offset(
          index.isEven ? -20 : 20,
          index.isEven ? 25 : -25,
        ),
      );
    }),
  ];

  void _nextScene() {
    if (_sceneIndex + 1 >= _scenes.length) {
      _sceneIndex = 0;
    } else {
      _sceneIndex = _sceneIndex + 1;
    }

    FixtureBloc().push(_scenes[_sceneIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardController(
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: Stack(
          children: [
            GridView.count(
              crossAxisCount: 10,
              padding: const EdgeInsets.all(12),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                ..._currentScene.map(FixtureWidget.new),
              ],
            ),
            Positioned(
              width: 200,
              height: 200,
              bottom: 16,
              right: 16,
              child: FilledButton(
                onPressed: _nextScene,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
                child: Text('Tap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
