import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/main.dart';

class Markdown extends StatelessWidget {
  final String text;

  const Markdown({
    super.key,
    required this.text,
  });

  List<InlineSpan> process(BuildContext context) {
    final children = <InlineSpan>[];
    final lines = text.split('\n');
    for (final line in lines) {
      String text;
      TextStyle? style;

      if (line.startsWith('#')) {
        final parts = line.split('#');
        final headingLevel = parts.where((part) => part.isEmpty).length;
        switch (headingLevel) {
          case 1:
            style = Theme.of(context).primaryTextTheme.headlineLarge;
          case 2:
            style = Theme.of(context).primaryTextTheme.headlineMedium;
          case 3:
            style = Theme.of(context).primaryTextTheme.headlineSmall;
        }

        text = '${parts.last.trimLeft()}\n';
      } else {
        text = '$line\n';
        style = Theme.of(context).textTheme.bodyMedium;
      }

      var bold = true;
      final boldStyle = style?.copyWith(
        color: CustomColors.matrixBlack,
        backgroundColor: CustomColors.matrixGreen,
        fontWeight: FontWeight.bold,
      );
      final parts = text.split('**');
      for (final part in parts) {
        bold = !bold;
        if (part.isNotEmpty) {
          children.add(
            TextSpan(
              text: part,
              style: bold ? boldStyle : style,
            ),
          );
        }
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: process(context),
      ),
    );
  }
}
