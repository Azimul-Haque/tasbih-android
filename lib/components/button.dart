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
    return InkWell(
      onTap: () {
        onTap;
      },
      child: Card(
        elevation: 2, // Adds shadow for a raised effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Container(
          width: 120, // Square size
          height: 120,
          alignment: Alignment.center,
          child: Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // InkWell(
    //   onTap: onTap,
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius: BorderRadius.circular(8),
    //     ), // BoxDecoration
    //     padding: const EdgeInsets.all(5),
    //     child: Center(child: Text(title!)),
    //   ), // Container
    // ); // GestureDetector
  }
}
