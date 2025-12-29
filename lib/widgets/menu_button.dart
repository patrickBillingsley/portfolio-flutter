import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/models/case_study.dart';
import 'package:patrick_billingsley_portfolio/screens/case_study_screen.dart';
import 'package:patrick_billingsley_portfolio/screens/contact_screen.dart';
import 'package:patrick_billingsley_portfolio/screens/menu_screen.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with SingleTickerProviderStateMixin {
  static const double _buttonOffset = 60;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    _isOpen = !_isOpen;

    if (_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _buttonOffset,
      children: [
        Transform.translate(
          offset: Offset(0, _buttonOffset * (1 - _controller.value)),
          child: Opacity(
            opacity: _controller.value,
            child: FilledButton(
              onPressed: _controller.value == 1.0
                  ? MenuScreen(
                      title: 'Case Studies',
                      options: [
                        FilledButton(
                          onPressed: CaseStudyScreen(CaseStudy(fileName: 'messaging_migration')).show,
                          child: Text('Messaging'),
                        ),
                      ],
                    ).show
                  : null,
              child: Text('Case Studies'),
            ),
          ),
        ),
        FilledButton(
          onPressed: _toggleMenu,
          child: Text('Menu'),
        ),
        Transform.translate(
          offset: Offset(0, -_buttonOffset * (1 - _controller.value)),
          transformHitTests: false,
          child: Opacity(
            opacity: _controller.value,
            child: FilledButton(
              onPressed: _controller.value == 1.0 ? ContactScreen().show : null,
              child: Text('Contact'),
            ),
          ),
        ),
      ],
    );
  }
}
