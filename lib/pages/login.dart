import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lab/providers/theme_provider.dart';
import 'package:lab/widgets/button_custom.dart';
import 'package:lab/widgets/text_field_custom.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  dynamic data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      var url =
          Uri.parse('https://api-dev.360erp.com.br/settings-of-system/v1');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          data = jsonDecode(response.body)['data'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Trate exceções de rede aqui
      print('Exception occurred: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    Color greyColor = Theme.of(context).colorScheme.primaryContainer;
    Color primaryColor = Theme.of(context).primaryColor;

    print(url);

    return Expanded(
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: greyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(icon, color: primaryColor, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkTheme = themeProvider.isDarkMode;
    Color textColor = Theme.of(context).primaryTextTheme.bodyLarge!.color!;
    Color dividerColor = Theme.of(context).dividerTheme.color!;
    Color backgroundColor = Theme.of(context).colorScheme.secondaryContainer;

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
        color: backgroundColor,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 30, left: 30, bottom: 60),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  isDarkTheme
                      ? "assets/images/logos/Logo360Dark.png"
                      : "assets/images/logos/Logo360.png",
                  height: 80,
                  width: 160,
                ),
                const TextFieldCustom(
                  label: 'Login',
                  margin: EdgeInsets.only(top: 50),
                ),
                const TextFieldCustom(
                  label: 'Senha',
                  margin: EdgeInsets.only(top: 15, bottom: 8),
                  isPassword: true,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      print("Esqueceu a senha clicado");
                    },
                    child: const Text(
                      "Esqueceu a senha?",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                ButtonCustom(
                  text: 'Entrar',
                  onPressed: widget.onLogin,
                  margin: const EdgeInsets.only(top: 40),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: dividerColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'ou',
                          style: TextStyle(color: dividerColor),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ButtonCustom(
                  text: 'Cadastre-se e teste grátis',
                  onPressed: widget.onLogin,
                  backgroundColor: const Color.fromRGBO(17, 18, 19, 1),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 12, color: textColor),
                    children: const <TextSpan>[
                      TextSpan(text: 'Ficou com dúvidas? \n Acesse nosso '),
                      TextSpan(
                        text: 'site',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: ' ou nossas '),
                      TextSpan(
                        text: 'redes sociais',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 30), // Adiciona uma margem superior
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSocialIcon(FontAwesomeIcons.whatsapp,
                          data['linkWhatsApp'] ?? ''),
                      const SizedBox(width: 10),
                      _buildSocialIcon(
                          FontAwesomeIcons.facebook, data['linkFace'] ?? ''),
                      const SizedBox(width: 10),
                      _buildSocialIcon(
                          FontAwesomeIcons.youtube, data['linkYoutube'] ?? ''),
                      const SizedBox(width: 10),
                      _buildSocialIcon(
                          FontAwesomeIcons.instagram, data['linkInsta'] ?? ''),
                      const SizedBox(width: 10),
                      _buildSocialIcon(FontAwesomeIcons.earthAmericas,
                          data['linkSite'] ?? ''),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Ajusta a altura ao conteúdo
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Alinha os textos à esquerda
                    children: <Widget>[
                      Text(
                        "${data['contactPhone']} | ${data['contactEmail']}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${data['contactName']} ${data['versionPortal']}",
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 50),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Termos e condições de uso",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Termos e condições de uso clicado");
                                },
                            ),
                            const TextSpan(
                              text: " | ",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                              ),
                            ),
                            TextSpan(
                              text: "Central de ajuda",
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print("Central de ajuda clicado");
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
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
