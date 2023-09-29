import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class Update extends StatefulWidget {
  const Update({super.key});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.toColor(),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image(
              image: AssetImage(
                dark
                    ? "assets/background/esfumadodark.png"
                    : "assets/background/esfumadolight.png",
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Bootstrap.cloud_arrow_down,
                      size: 44,
                      color: Tema.texto.toColor(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      "Atualização Disponível",
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        letterSpacing: -0.41,
                        fontWeight: FontWeight.w700,
                        color: Tema.texto.toColor(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                SvgPicture.asset("assets/imagens/update.svg"),
                Text(
                  "Baixe a versão mais recente do Flyvoo para ficar atualizado nas novidades e na sua segurança",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Tema.texto.toColor(),
                    fontSize: 25,
                    letterSpacing: -0.41,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const Expanded(child: SizedBox()),
                SizedBox(
                  width: 238,
                  height: 55,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: dark
                        ? const Color(0x5E00FFD8)
                        : const Color(0xFF90CAF9),
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Bootstrap.cloud_arrow_down,
                          size: 44,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Atualizar",
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.41,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
