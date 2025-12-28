import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension CustomColors on Colors {
  static const MaterialColor matrixGreen = MaterialColor(_matrixGreenPrimaryValue, {
    400: Color(0xFF00FF41),
    500: Color(_matrixGreenPrimaryValue),
    600: Color(0xFF003B00),
  });
  static const int _matrixGreenPrimaryValue = 0xFF008F11;

  static const Color matrixBlack = Color(0xFF0D0208);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: CustomColors.matrixBlack,
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
          ),
        ),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('Knock Knock, Neo'),
        ),
      ),
    );
  }
}
