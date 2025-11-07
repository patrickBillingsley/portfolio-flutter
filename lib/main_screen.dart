import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/services/mouse_service.dart';
import 'package:patrick_billingsley_portfolio/widgets/polka_dots.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: MouseService().setPosition,
      onExit: MouseService().clearPosition,
      child: Scaffold(
        backgroundColor: Colors.black87,
        body: PolkaDots(
          image: Image.asset(
            'images/flutter_dash.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
