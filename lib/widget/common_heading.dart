import 'package:flutter/material.dart';

class CommonHeading extends StatelessWidget {
  const CommonHeading({
    Key? key,
    required this.title,
    this.fontSize = 20.0,
    this.haveUnderLine = false,
  }) : super(key: key);

  final String title;
  final double fontSize;
  final bool haveUnderLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black,
          fontWeight: FontWeight.w400,
          decoration:
              haveUnderLine ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}
