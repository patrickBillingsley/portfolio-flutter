import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/portal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int maxIndex = 2;
  static const int minIndex = -2;

  int selectedIndex = 0;

  void _turnRight() {
    if (selectedIndex >= maxIndex) return;

    setState(() {
      selectedIndex++;
    });
  }

  void _turnLeft() {
    if (selectedIndex <= minIndex) return;

    setState(() {
      selectedIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final space = MediaQuery.sizeOf(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ...List.generate(5, (index) {
          return Portal(
            key: ValueKey(index - 2),
            index: index + selectedIndex - 2,
            color: index.isOdd ? Colors.blueGrey : Colors.grey,
          );
        }),

        Portal(
          index: 0,
          color: Colors.blue,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipPath(
                clipper: LeftClipper(),
                child: GestureDetector(
                  onTap: _turnLeft,
                  child: Container(
                    width: space.width * 0.05,
                    height: space.width * 0.1,
                    color: Colors.amber,
                  ),
                ),
              ),
              ClipPath(
                clipper: RightClipper(),
                child: GestureDetector(
                  onTap: _turnRight,
                  child: Container(
                    width: space.width * 0.05,
                    height: space.width * 0.1,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..arcToPoint(
        Offset(0, size.height),
        radius: Radius.circular(size.width),
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class RightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width, size.height)
      ..arcToPoint(
        Offset(size.width, 0),
        radius: Radius.circular(size.width),
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
