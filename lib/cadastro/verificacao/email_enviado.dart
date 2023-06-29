// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailEnviado extends StatelessWidget {
  const EmailEnviado({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Email de verificação enviado",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Queensides Light",
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      Icons.mark_email_read_outlined,
                      color: !dark ? Color(0xff34C759) : Color(0xff32D74B),
                      size: 200,
                    ),
                    SizedBox(
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
                margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
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
                      ModalRoute.withName("/index"),
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
      ),
    );
  }
}
