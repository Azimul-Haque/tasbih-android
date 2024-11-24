import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final int width;
  final int ;
  final Widget? child;
  final Color? color;

  const MyBox({
    super.key,
    required this.,
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ), // BoxDecoration
      width: 200,
      height: 200,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}
