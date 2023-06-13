// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/blablabla/termos.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/login/cadastro.dart';
import 'package:flyvoo/login/login.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

Shader linearGradient = LinearGradient(
  colors: <Color>[
    tema["primaria"]!,
    tema["noFundo"]!,
  ],
).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 200.0));

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  void initState() {
    linearGradient = LinearGradient(
      colors: <Color>[
        tema["primaria"]!,
        tema["noFundo"]!,
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 300.0, 200.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image(
                          image: AssetImage(
                            dark
                                ? "assets/logo/logogradientedark.png"
                                : "assets/logo/logogradientelight.png",
                          ),
                          width: 266,
                          height: 266,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Bem-vindo(a) ao ",
                          style: GoogleFonts.inter(
                            fontSize: 32,
                            color: tema["noFundo"],
                          ),
                          children: [
                            TextSpan(
                              text: "Flyvoo!",
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                foreground: Paint()..shader = linearGradient,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        "Sua jornada começa aqui!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      BotoesEntrada(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: tema["noFundo"],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Ao usar o aplicativo, você concorda com nossos ",
                style: GoogleFonts.inter(
                  color: tema["textoSecundario"],
                  fontSize: 15,
                  height: 1.3,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: "Termos de Uso & Política de Privacidade",
                    style: TextStyle(
                      color: tema["textoSecundario"],
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => Termos(),
                          ),
                        );
                      },
                  ),
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: tema["textoSecundario"],
                    ),
                  ),
                ],
              ),
            ),
          ), // Ao se _*cadastrar*_, você concorda com os nossos _Termos de Uso_ & _Política de Privacidade_
        ],
      ),
    );
  }
}

List<BotaoIndex> botoes = [
  BotaoIndex(AssetImage("assets/icons/seta_dupla.png"), "Continuar sem conta"),
  BotaoIndex(AssetImage("assets/icons/email.png"), "Continuar como usuário"),
  BotaoIndex(AssetImage("assets/icons/user.png"), "Criar uma conta"),
];

class BotaoIndex {
  final String text;
  final AssetImage icon;
  BotaoIndex(this.icon, this.text);
}

List<String> botoesAlerta = [];

class BotoesEntrada extends StatelessWidget {
  const BotoesEntrada({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: double.infinity,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(100),
                color: dark
                    ? Color(0xff00FFD8).withOpacity(0.37)
                    : Color(0xffFFD3BD),
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image(
                      image: botoes[index].icon,
                      width: 30,
                      color: dark ? Colors.white : Color(0xffA93535),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      botoes[index].text,
                      style: GoogleFonts.inter(
                        color: dark ? Colors.white : Color(0xffA93535),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  switch (index) {
                    case 0:
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: CupertinoAlertDialog(
                            content: Text(
                              "Caso queira mais funcionalidade no app, sinta-se livre para se cadastrar quando quiser!",
                              style: GoogleFonts.inter(),
                            ),
                            /* actions: [CupertinoDialogAction(child: child)], */
                          ),
                        ),
                      );
                      /* Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Home(),
                        ),
                      ); */
                      break;
                    case 1:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Login(),
                        ),
                      );
                      break;
                    default:
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Cadastro(),
                        ),
                      );
                  }
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        );
      },
      itemCount: botoes.length,
    );
  }
}
