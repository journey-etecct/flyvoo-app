// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class Introducao extends StatefulWidget {
  const Introducao({super.key});

  @override
  State<Introducao> createState() => _IntroducaoState();
}

class _IntroducaoState extends State<Introducao> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popou) async {
        bool resposta = await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text("Tem certeza que deseja sair do teste?"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.inter(
                    color: CupertinoColors.systemBlue,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  "Sair",
                  style: GoogleFonts.inter(
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
            ],
          ),
        );
        if (resposta) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Tema.fundo.cor(),
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image(
                image: AssetImage(
                  dark
                      ? "assets/background/teste fundo dark.png"
                      : "assets/background/teste fundo light.png",
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              top: 0,
              left: 0,
              right: 0,
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
