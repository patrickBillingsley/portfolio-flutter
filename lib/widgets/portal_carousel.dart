import 'package:flutter/material.dart';
import 'package:patrick_billingsley_portfolio/widgets/portal.dart';

class PortalCarousel extends StatefulWidget {
  const PortalCarousel({super.key});

  @override
  State<PortalCarousel> createState() => _PortalCarouselState();
}

class _PortalCarouselState extends State<PortalCarousel> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    lowerBound: -60,
    upperBound: 60,
  );

  int selectedIndex = 0;

  double get degrees => _rotationController.value;

  @override
  void initState() {
    super.initState();
    _rotationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void _selectIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ...List.generate(5, (index) {
          final normalizedIndex = index - 2;

          return GestureDetector(
            child: Portal(
              key: ValueKey(normalizedIndex),
              onTap: () => _selectIndex(-normalizedIndex),
              index: normalizedIndex + selectedIndex,
              color: normalizedIndex.isOdd ? Colors.blueGrey : Colors.grey,
            ),
          );
        }),
        Portal(
          index: 0,
          color: Colors.blue,
        ),
      ],
    );
  }
}
