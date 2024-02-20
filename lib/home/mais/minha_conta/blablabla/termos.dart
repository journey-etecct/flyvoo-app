import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/secure/token.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

Future<String> getTermos() async {
  String conteudoCripto = await http.get(
    Uri.parse(
      "https://api.github.com/repos/journey-etecct/flyvoo-app/contents/TERMOS.md",
    ),
    headers: {"Authorization": "token $token"},
  ).then((value) {
    return jsonDecode(value.body)["content"];
  });
  Uint8List conteudo = base64Decode(
    conteudoCripto.replaceAll(RegExp(r'\s+'), ''),
  );
  return utf8.decode(conteudo);
}

class TermosDeUso extends StatelessWidget {
  const TermosDeUso({super.key});

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
            physics: const BouncingScrollPhysics(
              decelerationRate: ScrollDecelerationRate.fast,
            ),
            child: Column(
              children: [
                const SizedBox(
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
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    "Termos de Uso",
                    style: GoogleFonts.inter(
                      color: dark
                          ? const Color(0xffD271F4)
                          : const Color(0xffFF577F),
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
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
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  width: double.infinity,
                  child: CupertinoButton(
                    color: dark
                        ? const Color(0xff7736AA)
                        : const Color(0xffFF6CA1),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(12),
                    padding: const EdgeInsets.only(
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
