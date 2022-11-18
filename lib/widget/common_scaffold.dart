import 'package:flutter/material.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    Key? key,
    required this.child,
    this.displayBackgroundImage = true,
    this.opacity = 0.25,
  }) : super(key: key);
  final Widget child;
  final bool displayBackgroundImage;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/college_logo.png",
                color: Color.fromRGBO(255, 255, 255, opacity),
                colorBlendMode: BlendMode.modulate),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
