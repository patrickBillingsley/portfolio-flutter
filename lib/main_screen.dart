import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/services/mouse_service.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FixtureController _fixtureController = FixtureController();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: MouseService().setPosition,
      onExit: MouseService().clearPosition,
      child: Scaffold(
        backgroundColor: Colors.black87,
        // body: PolkaDots(
        //   image: Image.asset(
        //     'images/flutter_dash.png',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        body: Column(
          children: [
            Expanded(
              child: FixtureField(
                controller: _fixtureController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: FilledButton(
                onPressed: () {
                  if (_fixtureController.isPlaying) {
                    _fixtureController.stop();
                  } else {
                    _fixtureController.pulse(max: 2.0);
                  }
                },
                child: Text(_fixtureController.isPlaying ? 'Stop' : 'Pulse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
