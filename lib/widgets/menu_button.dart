import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({super.key});

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> with SingleTickerProviderStateMixin {
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
    return SizedBox(
      height: 36,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -80 * _controller.value,
            left: -60,
            child: Opacity(
              opacity: _controller.value,
              child: FilledButton(
                onPressed: () {},
                child: Text('Case Studies'),
              ),
            ),
          ),
          Positioned(
            bottom: -80 * _controller.value,
            left: -30,
            child: Opacity(
              opacity: _controller.value,
              child: FilledButton(
                onPressed: () {},
                child: Text('Contact'),
              ),
            ),
          ),
          FilledButton(
            onPressed: _toggleMenu,
            child: Text('Menu'),
          ),
        ],
      ),
    );
  }
}
