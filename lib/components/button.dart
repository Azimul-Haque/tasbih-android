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
    return GestureDetector(
      onTap: () {
        // Define the action here
        print('Card clicked!');
      },
      child: Card(
        elevation: 5, // Adds shadow for a raised effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Container(
          width: 120, // Square size
          height: 120,
          alignment: Alignment.center,
          child: Text(
            'Click Me',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
