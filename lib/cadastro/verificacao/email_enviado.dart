import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailEnviado extends StatelessWidget {
  const EmailEnviado({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (poppou) {
        Navigator.popUntil(
          context,
          (route) => route.isFirst,
        );
      },
      child: Scaffold(
        backgroundColor: Tema.fundo.cor(),
        body: Stack(
          children: [
            const Background(),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Email de verificação enviado",
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
                            "Um email com um link de confirmação foi enviado. Cheque sua caixa de entrada e a caixa de spam para continuar seu cadastro.",
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
                      color: Tema.fundo.cor(),
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
                      color: Tema.botaoIndex.cor(),
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "Fechar",
                        style: GoogleFonts.inter(
                          color: Tema.textoBotaoIndex.cor(),
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
