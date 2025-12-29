import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';

class MenuScreen extends StatelessWidget with Navigation {
  final String? title;
  final List<Widget> options;

  const MenuScreen({
    super.key,
    this.title,
    this.options = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            if (title != null)
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ...options,
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
