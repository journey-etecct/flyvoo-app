import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

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
          url: "https://flyvoo.page.link/verifyEmail",
          androidPackageName: "io.journey.flyvoo",
        ),
      );
      final SharedPreferences instS = await SharedPreferences.getInstance();
      await instS.setBool("cadastroTerminado", false);
      if (userFlyvoo != null) {
        if (!mounted) return;
        Navigator.pushNamed(
          context,
          "/opcoesCadastro/email/enviado",
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _btnAtivado = true;
      });
      if (e.code == "email-already-in-use") {
        if (!mounted) return;
        showCupertinoDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
              title: Column(
                children: [
                  const Icon(Symbols.error_circle_rounded_error),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Essa conta já existe",
                    style: GoogleFonts.inter(),
                  ),
                ],
              ),
              content: Text(
                "Deseja fazer login?",
                style: GoogleFonts.inter(),
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.inter(
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushNamed(context, "/login");
                  },
                  isDefaultAction: true,
                  child: Text(
                    "Entrar",
                    style: GoogleFonts.inter(
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        if (!mounted) return;
        Flushbar(
          message: "Erro desconhecido. Código: ${e.code}",
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(50),
        ).show(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _txtEmail.text = "";
    _btnAtivado = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.toColor(),
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
          SingleChildScrollView(
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
                      color: Tema.fundo.toColor(),
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(""),
                  ),
                  Text(
                    "Primeiro, insira seu email:\n(Ele é único e precisará ser verificado)",
                    style: GoogleFonts.inter(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: TextFormField(
                      key: _emailKey,
                      controller: _txtEmail,
                      textInputAction: TextInputAction.go,
                      selectionControls: CupertinoTextSelectionControls(),
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {});
                      },
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
                            color: Tema.primaria.toColor(),
                          ),
                        ),
                      ),
                      cursorColor: Tema.primaria.toColor(),
                    ),
                  ),
                  const Expanded(
                    flex: 3,
                    child: Text(""),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Tema.fundo.toColor(),
                      boxShadow: _btnAtivado
                          ? <BoxShadow>[
                              BoxShadow(
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: const Offset(0, 5),
                                color:
                                    const Color(0xff000000).withOpacity(0.25),
                              ),
                            ]
                          : [],
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
                      color: Tema.botaoIndex.toColor(),
                      disabledColor: dark
                          ? const Color(0xff007AFF).withOpacity(0.15)
                          : const Color(0xffFB5607).withOpacity(0.30),
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                      child: Text(
                        "Próximo",
                        style: GoogleFonts.inter(
                          color: _btnAtivado
                              ? Tema.textoBotaoIndex.toColor()
                              : CupertinoColors.systemGrey2,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
