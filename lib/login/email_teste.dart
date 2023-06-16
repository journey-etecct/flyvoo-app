// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

bool codEnviado = false;
String codigo = '';

final _txtEmail = TextEditingController();
final _txtCod = TextEditingController();

class EmailTeste extends StatefulWidget {
  const EmailTeste({super.key});

  @override
  State<EmailTeste> createState() => _EmailTesteState();
}

class _EmailTesteState extends State<EmailTeste> {
  final _formkey = GlobalKey<FormFieldState>();
  String generateVeryUniqueID() {
    var rng = Random();

    String numbers = "";
    numbers = "";
    for (var i = 0; i < 6; i++) {
      numbers += rng.nextInt(9).toString();
    }

    return numbers;
  }

  @override
  void initState() {
    codEnviado = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              key: _formkey,
              enabled: !codEnviado,
              controller: _txtEmail,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "*Obrigatório";
                } else if (!value.contains(
                  RegExp(
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                  ),
                ) /* !value.contains("@gmail.com") &&
                  !value.contains("@etec.sp.gov.br") &&
                  !value.contains("@outlook.com") &&
                  !value.contains("@hotmail.com") &&
                  !value.contains("@yahoo.com") &&
                  !value.contains("@terra.com.br") */
                    ) {
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
            FilledButton(
              onPressed: codEnviado
                  ? null
                  : () {
                      if (_formkey.currentState!.isValid) {
                        /* Flushbar(
                          message: generateVeryUniqueID(),
                          duration: Duration(seconds: 5),
                        ).show(context); */
                        codigo = generateVeryUniqueID();
                        Map<String, String> body = {
                          "email": _txtEmail.text,
                          "codigo": codigo,
                        };
                        http
                            .post(
                          Uri.parse(
                            "https://etec199-danilolima.xp3.biz/2023/testeemail/index.php",
                          ),
                          body: body,
                        )
                            .then((value) {
                          Flushbar(
                            message: value.body,
                            duration: const Duration(seconds: 3),
                            flushbarStyle: FlushbarStyle.FLOATING,
                          ).show(context);
                          setState(() {
                            codEnviado = true;
                          });
                        });
                      }
                    },
              child: const Text("enviar código"),
            ),
            TextField(
              controller: _txtCod,
              enabled: codEnviado,
              decoration: InputDecoration(
                hintText: "Insira aqui o código",
              ),
            ),
            FilledButton(
              onPressed: !codEnviado
                  ? null
                  : () {
                      if (_txtCod.text == codigo) {
                        Flushbar(
                          message: "codigo certo!",
                          duration: const Duration(seconds: 3),
                          flushbarStyle: FlushbarStyle.FLOATING,
                        ).show(context);
                      } else {
                        Flushbar(
                          message: "codigo errado :(",
                          duration: const Duration(seconds: 3),
                          flushbarStyle: FlushbarStyle.FLOATING,
                        ).show(context);
                      }
                    },
              child: const Text("validar"),
            ),
          ],
        ),
      ),
    );
  }
}
