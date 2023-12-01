// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lab/pages/home.dart';
import 'package:lab/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuthenticated = false;

  void login() {
    setState(() {
      isAuthenticated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isAuthenticated ? const MainPage() : LoginPage(onLogin: login),
    );
  }
}
