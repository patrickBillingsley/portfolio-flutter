import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/screen_sections/base_section.dart';

class HomeSection extends StatelessWidget implements BaseSection {
  static const double height = 800;
  static const double radius = 60;

  const HomeSection({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _HomeSectionClipper(),
      child: Container(
        height: height,
        color: Colors.red,
      ),
    );
  }
}

class _HomeSectionClipper extends CustomClipper<Path> {
  double get radius => HomeSection.radius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..arcToPoint(
        Offset(size.width - radius, size.height - radius),
        radius: Radius.circular(radius),
        clockwise: false,
      )
      ..lineTo(radius, size.height - radius)
      ..arcToPoint(
        Offset(0, size.height - (radius * 2)),
        radius: Radius.circular(radius),
      )
      ..lineTo(0, radius)
      ..arcToPoint(
        Offset(radius, 0),
        radius: Radius.circular(radius),
      )
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
