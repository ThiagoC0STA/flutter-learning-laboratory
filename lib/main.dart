// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:lab/pages/home.dart';
import 'package:lab/pages/login.dart';
import 'package:lab/providers/app_colors.dart';
import 'package:lab/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
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
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: AppColors.primaryColor,
          colorScheme: const ColorScheme.light(
            primaryContainer: AppColors.greyColor,
            secondaryContainer: AppColors.whiteColor,
            outline: AppColors.greyBorderLight,
          ),
          primaryTextTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.textColor),
          ),
          dividerTheme: const DividerThemeData(color: AppColors.greyTextColor)),

      // ----------------------------------------------------------------
      // --------------------DARK MODE BELOW-----------------------------
      // ----------------------------------------------------------------

      darkTheme: ThemeData(
          fontFamily: "Montserrat",
          primaryColor: AppColors.primaryColorDark,
          colorScheme: const ColorScheme.dark(
            primaryContainer: AppColors.greyColorDark,
            secondaryContainer: AppColors.whiteColorDark,
            outline: AppColors.greyBorderLight,
          ),
          primaryTextTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.textColorDark),
          ),
          dividerTheme: const DividerThemeData(color: AppColors.greyTextColor)),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: isAuthenticated ? const MainPage() : LoginPage(onLogin: login),
    );
  }
}
