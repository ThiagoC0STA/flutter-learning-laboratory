import 'package:flutter/material.dart';
import 'package:lab/providers/theme_provider.dart';
import 'package:lab/widgets/text_field_custom.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.isDarkMode;
    Color textColor = Theme.of(context).textTheme.bodyLarge!.color!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100, right: 30, left: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                  isDarkTheme
                      ? "assets/images/logos/Logo360Dark.png"
                      : "assets/images/logos/Logo360.png",
                  height: 80,
                  width: 160),
              const TextFieldCustom(label: 'Login', marginTop: 50),
              const TextFieldCustom(
                  label: 'Senha', marginTop: 20, isPassword: true),
              ElevatedButton(
                onPressed: onLogin,
                child: const Text('Entrar'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: themeProvider.toggleTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        hoverElevation: 0,
        splashColor: Colors.transparent,
        highlightElevation: 0,
        child: Icon(
          isDarkTheme ? Icons.wb_sunny : Icons.nightlight_round,
          color: textColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
