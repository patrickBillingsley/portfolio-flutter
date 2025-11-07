// import 'dart:math';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:patrick_billingsley_portfolio/screen_sections/home_section.dart';

// class NavBar extends StatefulWidget {
//   final ScrollController controller;

//   const NavBar({
//     super.key,
//     required this.controller,
//   });

//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   static const double _interleave = 80;
//   static const double _initialOffset = 200;
//   double _scrollOffset = 0;

//   @override
//   void initState() {
//     super.initState();
//     widget.controller.addListener(_updateOffset);
//   }

//   @override
//   void dispose() {
//     widget.controller.removeListener(_updateOffset);
//     super.dispose();
//   }

//   void _updateOffset() {
//     setState(() {
//       _scrollOffset = widget.controller.offset;
//     });
//   }

//   double _calculateVerticalOffset(int index) {
//     final interleave = _interleave * index;
//     final topPadding = max(_initialOffset + interleave - _scrollOffset, 0.0);
//     final homeSectionEndOffset = HomeSection.height - _scrollOffset;

//     return min(homeSectionEndOffset, topPadding);

//     // final initialOffset = max(_initialOffset - _scrollOffset, _scrollOffset);
//     // // final double offset;
//     // try {
//     //   return clampDouble(
//     //     initialOffset + interleave,
//     //     0,
//     //     HomeSection.height - HomeSection.radius,
//     //   );
//     // } catch (er) {
//     //   return _scrollOffset;
//     // }

//     // final interleave = _interleave * index;

//     // final topPadding = max(_initialOffset + interleave - _scrollOffset, 0);

//     // if (topPadding > HomeSection.height) {
//     //   return _scrollOffset;
//     // }

//     // return _scrollOffset + topPadding + interleave;
//   }

//   double _calculateHorizontalOffset(int index) {
//     return 0;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: AlignmentGeometry.topLeft,
//       children: [
//         NavButton(
//           text: 'Home',
//         ),
//       ],
//       // List.generate(4, (index) {
//       //   var text = '';
//       //   var onPressed = () {};
//       //   switch (index) {
//       //     case 0:
//       //       text = 'Home';
//       //     case 1:
//       //       text = 'Projects';
//       //     case 2:
//       //       text = 'About';
//       //     case 3:
//       //       text = 'Contact';
//       //   }

//       //   return Positioned(
//       //     top: _calculateVerticalOffset(index),
//       //     left: _calculateHorizontalOffset(index),
//       //     child: TextButton(
//       //       onPressed: onPressed,
//       //       child: Text(
//       //         text,
//       //         style: Theme.of(context).textTheme.displayLarge,
//       //       ),
//       //     ),
//       //   );
//       // }),
//     );
//   }
// }

// class NavButton extends StatelessWidget {
//   final VoidCallback? onPressed;
//   final String text;

//   const NavButton({
//     super.key,
//     this.onPressed,
//     required this.text,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       child: TextButton(
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ),
//     );
//   }
// }
