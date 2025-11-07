import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/screen_sections/home_section.dart';
import 'package:patrick_billingsley_portfolio/widgets/nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_setScrollOffset);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_setScrollOffset);
    super.dispose();
  }

  void _setScrollOffset() {
    setState(() {
      _scrollOffset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final navPath = Path()
      ..moveTo(0, 0)
      ..lineTo(0, HomeSection.height - (HomeSection.radius * 2))
      ..arcToPoint(
        Offset(HomeSection.radius, HomeSection.height - HomeSection.radius),
        radius: Radius.circular(HomeSection.radius),
        clockwise: false,
      )
      ..lineTo(
        screenSize.width - HomeSection.radius - 300,
        HomeSection.height - HomeSection.radius,
      );

    final metrics = navPath.computeMetrics().first;
    final homePosition = metrics.getTangentForOffset(max(_scrollOffset * 2, 200))?.position;
    final projectsPosition = metrics.getTangentForOffset(max(_scrollOffset * 2 + 100, 300))?.position;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: Colors.cyan,
        height: 2400,
        child: Stack(
          children: [
            Positioned(
              left: 250,
              right: 0,
              child: HomeSection(),
            ),
            Positioned(
              top: homePosition?.dy,
              left: homePosition?.dx,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Home',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            Positioned(
              top: projectsPosition?.dy,
              left: projectsPosition?.dx,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Projects',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ],
        ),

        // Scaffold(
        //   backgroundColor: Colors.transparent,
        //   body: Column(
        //     children: [
        //       Flexible(
        //         flex: 0,
        //         child: Row(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             ConstrainedBox(
        //               constraints: BoxConstraints.expand(
        //                 width: navBarWidth,
        //                 height: 2400,
        //               ),
        //               child: NavBar(
        //                 controller: _scrollController,
        //               ),
        //             ),
        //             Expanded(
        //               child: HomeSection(),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class HomePageClipper extends CustomClipper<Path> {
  static const double radius = 60;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..arcToPoint(Offset(size.width - radius, size.height - radius), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(radius, size.height - radius)
      ..arcToPoint(Offset(0, size.height - (radius * 2)), radius: Radius.circular(radius))
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(_) => false;
}
