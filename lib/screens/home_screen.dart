import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrick_billingsley_portfolio/widgets/menu_button.dart';

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
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.focused: CustomColors.matrixGreen.shade600,
              WidgetState.hovered: CustomColors.matrixBlack,
              WidgetState.pressed: CustomColors.matrixGreen.shade400,
              WidgetState.selected: CustomColors.matrixGreen.shade400,
              WidgetState.any: CustomColors.matrixGreen,
            }),
            foregroundColor: WidgetStateColor.fromMap({
              WidgetState.focused: CustomColors.matrixGreen.shade400,
              WidgetState.hovered: CustomColors.matrixGreen.shade400,
              WidgetState.pressed: CustomColors.matrixBlack,
              WidgetState.selected: CustomColors.matrixBlack,
              WidgetState.any: CustomColors.matrixBlack,
            }),
            textStyle: WidgetStateProperty.fromMap({
              WidgetState.any: GoogleFonts.courierPrime(
                color: CustomColors.matrixGreen,
                fontSize: 28,
              ),
            }),
            shape: WidgetStateProperty.fromMap({
              WidgetState.any: ContinuousRectangleBorder(),
            }),
            padding: WidgetStateProperty.fromMap({
              WidgetState.any: const EdgeInsets.symmetric(
                horizontal: 3,
                vertical: 10.5,
              ),
            }),
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
          ),
          bodyMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
          ),
        ),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Patrick Billingsley',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                    const SizedBox(width: 14),
                    MenuButton(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
