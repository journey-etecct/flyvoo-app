// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/blablabla/token.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future getTermos() async {
  String conteudoCripto = await http.get(
    Uri.parse(
      "https://api.github.com/repos/oculosdanilo/flyvoo/contents/TERMOS.md",
    ),
    headers: {"Authorization": "token $token"},
  ).then((value) {
    debugPrint(value.headers["x-ratelimit-remaining"]);
    return jsonDecode(value.body)["content"];
  });
  Uint8List conteudo = base64Decode(
    conteudoCripto.replaceAll(RegExp(r'\s+'), ''),
  );
  return utf8.decode(conteudo);
}

Future getPolitica() async {
  String conteudoCripto = await http.get(
    Uri.parse(
      "https://api.github.com/repos/oculosdanilo/flyvoo/contents/POLITICA.md",
    ),
    headers: {"Authorization": "token $token"},
  ).then((value) {
    debugPrint(value.headers["x-ratelimit-remaining"]);
    return jsonDecode(value.body)["content"];
  });
  Uint8List conteudo = base64Decode(
    conteudoCripto.replaceAll(RegExp(r'\s+'), ''),
  );
  return utf8.decode(conteudo);
}

class Termos extends StatelessWidget {
  const Termos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(
              dark
                  ? "assets/background/esfumadodarktermos.png"
                  : "assets/background/esfumadolighttermos.png",
            ),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Image(
            image: AssetImage(
              dark
                  ? "assets/background/esfumadodarktermos2.png"
                  : "assets/background/esfumadolighttermos.png",
            ),
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 35,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image(
                    image: AssetImage(
                      dark
                          ? "assets/logo/logogradientedark.png"
                          : "assets/logo/logogradientelight.png",
                    ),
                    width: 100,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Bem-vindo! Ao utilizar o aplicativo, você concorda em cumprir estes Termos de Uso:",
                    style: GoogleFonts.inter(
                      color: dark ? Color(0xffD271F4) : Color(0xffFF577F),
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: FutureBuilder(
                    future: getTermos(),
                    builder: (context, value) {
                      return Text(value.requireData);
                    },
                    initialData: "Carregando...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Política de Privacidade",
                    style: GoogleFonts.inter(
                      color: dark ? Color(0xffD271F4) : Color(0xffFF577F),
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: FutureBuilder(
                    future: getPolitica(),
                    builder: (context, value) {
                      return Text(value.requireData);
                    },
                    initialData: "Carregando...",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  width: double.infinity,
                  child: CupertinoButton(
                    color: dark ? Color(0xff7736AA) : Color(0xffFF6CA1),
                    onPressed: () {},
                    borderRadius: BorderRadius.circular(12),
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "Concordar",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
