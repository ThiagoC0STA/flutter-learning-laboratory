import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final String label;
  final bool? isPassword;
  final EdgeInsets? margin;

  const TextFieldCustom(
      {super.key, required this.label, this.isPassword, this.margin});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color textColor = Theme.of(context).primaryTextTheme.bodyLarge!.color!;
    Color borderColor = Theme.of(context).colorScheme.outline;

    return Container(
      height: 50,
      margin: margin,
      child: TextField(
        obscureText: isPassword ?? false,
        style: TextStyle(color: textColor),
        cursorColor: textColor,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: borderColor,
                width:
                    1.0), // Borda vermelha quando habilitado, mas não em foco
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: primaryColor,
                width: 2.0), // Borda primária quando em foco
          ),
          labelText: label,
          labelStyle: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
