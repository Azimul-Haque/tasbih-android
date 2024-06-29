import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Color? color;

  const MyDrawer({
    super.key,
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
      padding: const EdgeInsets.all(50),
      child: child,
    );
  }
}
