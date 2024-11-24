import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(child: Text(title!)),
        ), // Container
      ),
    );
  }
}
