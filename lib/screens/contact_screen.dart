import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/main.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';

class ContactScreen extends StatelessWidget with Navigation {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email'),
            TextField(
              cursorColor: CustomColors.matrixGreen,
              cursorWidth: 12,
              cursorHeight: 12,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  gapPadding: 0,
                ),
                focusedBorder: OutlineInputBorder(
                  gapPadding: 0,
                  borderSide: BorderSide(
                    color: CustomColors.matrixGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
