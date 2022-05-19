import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue,
            Colors.red,
          ],
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
