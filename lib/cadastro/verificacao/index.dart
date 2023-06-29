import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/verificacao/email_enviado.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

final _txtEmail = TextEditingController();
bool _btnAtivado = true;

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

  _cadastroFirebaseEmail(String email) async {
    final inst = FirebaseAuth.instance;
    try {
      final UserCredential credenciais =
          await inst.createUserWithEmailAndPassword(
        email: email,
        password: "123456",
      );
      setState(() {
        userFlyvoo = credenciais.user;
      });
      await userFlyvoo?.sendEmailVerification(
        ActionCodeSettings(
          url:
              "https://flyvoo.page.link/verifyEmail?email=${userFlyvoo?.email}",
          androidPackageName: "io.journey.flyvoo",
        ),
      );
      if (!mounted) return;
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => const EmailEnviado(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Flushbar(
        message: "Erro desconhecido. Código: ${e.code}",
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(20),
        borderRadius: BorderRadius.circular(50),
      ).show(context);
    }
  }

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
                  const Expanded(
                    flex: 4,
                    child: Text(""),
                  ),
                  Text(
                    "Primeiro, insira seu email:",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
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
                  const Expanded(
                    flex: 3,
                    child: Text(""),
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
                      onPressed: _btnAtivado
                          ? () async {
                              if (_emailKey.currentState!.validate()) {
                                Flushbar(
                                  message: "Conectando...",
                                  duration: const Duration(seconds: 5),
                                  margin: const EdgeInsets.all(20),
                                  borderRadius: BorderRadius.circular(50),
                                ).show(context);
                                setState(() {
                                  _btnAtivado = false;
                                });
                                await _cadastroFirebaseEmail(_txtEmail.text);
                              }
                            }
                          : null,
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
