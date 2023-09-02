import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

List<BotaoIndex> _botoes = [
  BotaoIndex(
    (null, Symbols.mail_outline_rounded),
    "Continuar com email",
  ),
  BotaoIndex(
    (const AssetImage("assets/icons/google.png"), null),
    "Continuar com Google",
  ),
  BotaoIndex(
    (const AssetImage("assets/icons/microsoft.png"), null),
    "Continuar com Microsoft",
  ),
];

class BotaoIndex {
  final String text;
  final (AssetImage?, IconData?) icon;
  BotaoIndex(this.icon, this.text);
}

class OpcoesDeCadastro extends StatefulWidget {
  const OpcoesDeCadastro({Key? key}) : super(key: key);

  @override
  State<OpcoesDeCadastro> createState() => _OpcoesDeCadastroState();
}

class _OpcoesDeCadastroState extends State<OpcoesDeCadastro> {
  bool _btnGoogle = true;
  bool _btnMicrosoft = true;

  Future<UserCredential?> signInWithGoogle() async {
    setState(() {
      _btnGoogle = false;
    });
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return null;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final emails = await FirebaseAuth.instance.fetchSignInMethodsForEmail(
      googleUser.email,
    ); // [] ou [google.com] ou [microsoft.com]
    if (emails.isNotEmpty) {
      if (!mounted) return null;
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
      return null;
    }

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    try {
      final cr = await FirebaseAuth.instance.signInWithCredential(credential);
      return cr;
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
        if (!mounted) return null;
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
      }
      return null;
    }
  }

  Future<UserCredential?> signInWithMicrosoft() async {
    setState(() {
      _btnMicrosoft = false;
    });
    final microsoftProvider = MicrosoftAuthProvider();
    try {
      final cr =
          await FirebaseAuth.instance.signInWithProvider(microsoftProvider);
      final info = await FirebaseDatabase.instance.ref("users/").get();
      if (info.child("${cr.user?.uid}").exists) {
        if (!mounted) return null;
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
        return null;
      } else {
        return cr;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "account-exists-with-different-credential") {
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
      }
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _btnGoogle = true;
    _btnMicrosoft = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Center(
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                        fontFamily: "Queensides",
                        fontSize: 60,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: tema["fundo"],
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                          color: const Color(0xff000000).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(100),
                      color: tema["botaoIndex"],
                      padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                      onPressed: switch (index) {
                        0 => () => Navigator.pushNamed(
                              context,
                              "/opcoesCadastro/email",
                            ),
                        1 => _btnGoogle
                            ? () async {
                                UserCredential? cr = await signInWithGoogle();
                                if (cr != null) {
                                  userFlyvoo = cr.user;
                                  if (!mounted) return;
                                  Navigator.pushNamed(
                                    context,
                                    "/cadastro",
                                    arguments: "google",
                                  );
                                } else {
                                  setState(() {
                                    _btnGoogle = true;
                                  });
                                }
                              }
                            : null,
                        _ => _btnMicrosoft
                            ? () async {
                                final cr = await signInWithMicrosoft();
                                if (cr != null) {
                                  userFlyvoo = cr.user;
                                  setState(() {
                                    _btnMicrosoft = true;
                                  });
                                  if (!mounted) return;
                                  Navigator.pushNamed(
                                    context,
                                    "/cadastro",
                                    arguments: "microsoft",
                                  );
                                } else {
                                  setState(() {
                                    _btnMicrosoft = true;
                                  });
                                }
                              }
                            : null,
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          _botoes[index].icon.$1 != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    image: _botoes[index].icon.$1!,
                                    height: 29,
                                    color: tema["textoBotaoIndex"],
                                  ),
                                )
                              : Icon(
                                  _botoes[index].icon.$2,
                                  size: 30,
                                  color: tema["textoBotaoIndex"],
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            _botoes[index].text,
                            style: GoogleFonts.inter(
                              color: tema["textoBotaoIndex"],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: _botoes.length,
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: 70,
                ),
                Text.rich(
                  style: GoogleFonts.inter(
                    color: tema["noFundo"],
                  ),
                  TextSpan(
                    text: "Já possui cadastro? ",
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Clique aqui",
                        style: GoogleFonts.inter(
                          color:
                              dark ? tema["primaria"] : tema["textoBotaoIndex"],
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? tema["primaria"] : tema["textoBotaoIndex"],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, "/login");
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
