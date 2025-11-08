import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/controllers/fixture_controller.dart';
import 'package:patrick_billingsley_portfolio/services/mouse_service.dart';
import 'package:patrick_billingsley_portfolio/widgets/fixture_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final FixtureController _fixtureController = FixtureController(vsync: this, lowerBound: 0.5, upperBound: 2.0, value: 1.0);

  @override
  void dispose() {
    _fixtureController.dispose();
    super.dispose();
  }

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
        body: Stack(
          children: [
            FixtureField(
              controller: _fixtureController,
            ),
            Positioned(
              width: 200,
              height: 200,
              bottom: 16,
              right: 16,
              child: FilledButton(
                onPressed: () {
                  if (_fixtureController.isAnimating) {
                    _fixtureController.stop();
                  } else {
                    _fixtureController.pulse();
                  }
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                ),
                child: Text(_fixtureController.isAnimating ? 'Stop' : 'Pulse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
