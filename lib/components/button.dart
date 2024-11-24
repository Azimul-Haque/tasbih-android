import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? title;
  final double? titlesize;
  final Color? color;
  final void Function()? onTap;
  const MyButton({
    super.key,
    required this.title,
    required this.titlesize,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: color,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
              child: Text(
            title!,
            style: TextStyle(fontSize: titlesize),
          )),
        ), // Container
      ),
    );
  }
}
