import 'package:flutter/material.dart';

/// Flutter code sample for [TextField].

class TextFieldCustom extends StatelessWidget {
  final String label;
  final double? marginTop;
  final double? marginRight;
  final double? marginBottom;
  final double? marginLeft;
  final bool? isPassword;

  const TextFieldCustom({
    super.key,
    required this.label,
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginLeft,
    this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Padding(
      padding: EdgeInsets.only(
        top: marginTop ?? 0.0,
        right: marginRight ?? 0.0,
        bottom: marginBottom ?? 0.0,
        left: marginLeft ?? 0.0,
      ),
      child: SizedBox(
        height: 50,
        child: TextField(
          obscureText: isPassword ?? false,
          style: TextStyle(color: textColor),
          cursorColor: textColor,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2.0),
            ),
            labelText: label,
            labelStyle: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
