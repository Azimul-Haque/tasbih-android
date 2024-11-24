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
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(100, 100), // Square button with 100x100 dimensions
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0), // Square shape
        ),
      ),
      onPressed: () {
        // Define the action here
        print("Square button pressed!");
      },
      child: Text('Click'),
    )
    
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
