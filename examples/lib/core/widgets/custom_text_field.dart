import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.icon,
    this.inputType,
    this.focusNode,
    this.enabledBorderColor = Colors.grey,
    this.enabledBorderRadius = 20,
    this.enabledBorderWidth = 1,
    this.focusedBorderColor = Colors.blue,
    this.focusedBorderRadius = 10,
    this.focusedBorderWidth = 2,
    this.padding = 12,
    this.nextFocusNode,
    this.validator,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final TextInputType? inputType;
  final IconData? icon;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final Color enabledBorderColor;
  final double enabledBorderRadius;
  final double enabledBorderWidth;
  final Color focusedBorderColor;
  final double focusedBorderRadius;
  final double focusedBorderWidth;
  final double padding;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
      child: TextFormField(
        validator: validator,
        focusNode: focusNode,
        controller: controller,
        keyboardType: inputType,
        onEditingComplete: nextFocusNode != null ? () => nextFocusNode!.requestFocus() : null,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: enabledBorderColor,
              width: enabledBorderWidth,
            ),
            borderRadius: BorderRadius.circular(enabledBorderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: focusedBorderColor,
              width: focusedBorderWidth,
            ),
            borderRadius: BorderRadius.circular(focusedBorderRadius),
          ),
        ),
      ),
    );
  }
}
