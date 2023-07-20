import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class EmailEnviadoSenha extends StatelessWidget {
  const EmailEnviadoSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controllerBG.value.size.width,
                  height: controllerBG.value.size.height,
                  child: VideoPlayer(controllerBG),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Email de recuperção enviado",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Queensides",
                            fontSize: 32,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Icon(
                          Icons.mark_email_read_outlined,
                          color: !dark
                              ? const Color(0xff34C759)
                              : const Color(0xff32D74B),
                          size: 200,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                            "Um email com um link de recuperação de senha foi enviado. Cheque sua caixa de entrada e a caixa de spam para mudar sua senha.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 17,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: tema["fundo"],
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 5),
                          color: const Color(0xff000000).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        );
                      },
                      color: tema["botaoIndex"],
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "Fechar",
                        style: GoogleFonts.inter(
                          color: tema["textoBotaoIndex"],
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}