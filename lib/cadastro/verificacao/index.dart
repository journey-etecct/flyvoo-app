// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/verificacao/email_enviado.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

final _txtEmail = TextEditingController();

class VerificacaoEmail extends StatefulWidget {
  const VerificacaoEmail({super.key});

  @override
  State<VerificacaoEmail> createState() => _VerificacaoEmailState();
}

List<String> botaoTxt = <String>[
  "Próximo",
  "Próximo",
  "Finalizar",
];

class _VerificacaoEmailState extends State<VerificacaoEmail> {
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {});
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Text(
                    "CADASTRO",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: tema["noFundo"],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(""),
                  ),
                  Text(
                    "Primeiro, insira seu email:",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: _emailKey,
                    controller: _txtEmail,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Obrigatório";
                      } else if (!value.contains(
                        RegExp(
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                        ),
                      )) {
                        return "Email inválido";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 20,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: tema["primaria"]!,
                        ),
                      ),
                    ),
                    cursorColor: tema["primaria"],
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(""),
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
                        if (_emailKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => EmailEnviado(),
                            ),
                          );
                        }
                      },
                      color: tema["botaoIndex"],
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "Próximo",
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
        ),
      ),
    );
  }
}
