import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String title;
  final double titlesize;
  final Color color;
  final void Function() ontapfunction;
  final String fontfamily;
  const MyButton({
    super.key,
    required this.title,
    required this.titlesize,
    required this.color,
    required this.ontapfunction,
    required this.fontfamily,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: color,
      borderRadius: BorderRadius.circular(100),
      child: InkWell(
        onTap: ontapfunction,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontSize: titlesize, fontFamily: fontfamily),
          )),
        ), // Container
      ),
    );
  }
}
