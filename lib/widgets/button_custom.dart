import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final EdgeInsets? margin;

  const ButtonCustom({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.width,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColorTheme = Theme.of(context).primaryColor;
    Color textColorTheme = Theme.of(context).primaryTextTheme.bodyLarge!.color!;

    return Container(
      width: width ?? double.infinity,
      margin: margin, // Aplicando a margem
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? primaryColorTheme,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? textColorTheme,
          ),
        ),
      ),
    );
  }
}
