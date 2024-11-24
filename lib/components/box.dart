import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  final int height;
  final int widht;
  final Widget? child;
  final Color? color;

  const MyBox({
    super.key,
    required this.height,
    required this.widht,
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
      width: widht,
      height: height,
      padding: const EdgeInsets.all(30),
      child: child,
    );
  }
}
