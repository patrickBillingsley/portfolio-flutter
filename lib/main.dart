import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:patrick_billingsley_portfolio/bloc/fixture_bloc.dart';
import 'package:patrick_billingsley_portfolio/mixins/navigation.dart';
import 'package:patrick_billingsley_portfolio/models/fixture.dart';
import 'package:patrick_billingsley_portfolio/screens/home_screen.dart';
import 'package:patrick_billingsley_portfolio/services/scroll_service.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

void main() {
  FixtureBloc().scenes.addAll(scenes);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget with Navigation {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: CustomColors.matrixBlack,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateColor.fromMap({
              WidgetState.focused: CustomColors.matrixGreen.shade600,
              WidgetState.hovered: CustomColors.matrixBlack,
              WidgetState.pressed: CustomColors.matrixGreen.shade400,
              WidgetState.selected: CustomColors.matrixGreen.shade400,
              WidgetState.disabled: CustomColors.matrixGreen.shade600,
              WidgetState.any: CustomColors.matrixGreen,
            }),
            foregroundColor: WidgetStateColor.fromMap({
              WidgetState.focused: CustomColors.matrixGreen.shade400,
              WidgetState.hovered: CustomColors.matrixGreen.shade400,
              WidgetState.pressed: CustomColors.matrixBlack,
              WidgetState.selected: CustomColors.matrixBlack,
              WidgetState.disabled: CustomColors.matrixBlack,
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
          headlineLarge: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
            fontSize: 48,
          ),
          headlineMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
            fontSize: 36,
          ),
          headlineSmall: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
            fontSize: 28,
          ),
          bodyMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixGreen,
          ),
        ),
        primaryTextTheme: TextTheme(
          headlineLarge: GoogleFonts.courierPrime(
            color: CustomColors.matrixBlack,
            backgroundColor: CustomColors.matrixGreen,
            fontSize: 48,
          ),
          headlineMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixBlack,
            backgroundColor: CustomColors.matrixGreen,
            fontSize: 36,
          ),
          headlineSmall: GoogleFonts.courierPrime(
            color: CustomColors.matrixBlack,
            backgroundColor: CustomColors.matrixGreen,
            fontSize: 28,
          ),
          bodyMedium: GoogleFonts.courierPrime(
            color: CustomColors.matrixBlack,
            backgroundColor: CustomColors.matrixGreen,
          ),
        ),
      ),
      home: Listener(
        onPointerSignal: ScrollService().updateScrollOffset,
        child: HomeScreen(),
      ),
    );
  }
}

final scenes = [
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: Colors.blueGrey,
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: index % 3 == 0 ? Colors.green : Colors.red,
      position: Vector3(
        index % 3 == 0 ? 100 : 0,
        index % 3 == 0 ? 10 : 0,
        index % 3 == 0 ? 30 : -60,
      ),
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: Color.lerp(Colors.green, Colors.red, index / 100),
    );
  }),
  List.generate(100, (index) {
    return Fixture(
      id: index,
      color: index.isEven ? Colors.blue : Colors.blueGrey,
      position: Vector3(
        index.isEven ? -20 : 20,
        index.isEven ? 25 : -25,
        index.isEven ? 25 : -25,
      ),
    );
  }),
];

class CustomColors {
  static const MaterialColor matrixGreen = MaterialColor(_matrixGreenPrimaryValue, {
    400: Color(0xFF00FF41),
    500: Color(_matrixGreenPrimaryValue),
    600: Color(0xFF003B00),
  });
  static const int _matrixGreenPrimaryValue = 0xFF008F11;

  static const Color matrixBlack = Color(0xFF0D0208);
}
