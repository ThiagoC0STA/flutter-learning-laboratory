// custom_widget.dart
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String text;

  Login({this.text = "Texto padrão"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.blue,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
