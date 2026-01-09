import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/menu_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FittedBox(
                child: Text(
                  'Patrick Billingsley',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Opacity(
                opacity: 0,
                child: Text(
                  'A',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              MenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}
