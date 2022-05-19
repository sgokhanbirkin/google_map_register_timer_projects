import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    this.buttonColor = Colors.white,
    this.textColor = Colors.black,
  }) : super(key: key);
  final String text;
  final VoidCallback onClicked;
  final Color? textColor;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: onClicked,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline5?.copyWith(
                color: textColor,
              ),
        ),
      );
}
