import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<BotaoIndex> _botoes = [
  BotaoIndex(
    const AssetImage("assets/icons/google.png"),
    "Continuar com Google",
  ),
  BotaoIndex(
    const AssetImage("assets/icons/microsoft.png"),
    "Continuar com Microsoft",
  ),
];

class BotaoIndex {
  final String text;
  final AssetImage icon;
  BotaoIndex(this.icon, this.text);
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  IconData _iconeOlho = Icons.visibility_rounded;
  bool _txtEscondido = true;
  final _loginKey = GlobalKey<FormFieldState>();
  final _senhaKey = GlobalKey<FormFieldState>();
  final _formKey = GlobalKey<FormState>();
  final _txtEmail = TextEditingController();
  final _txtSenha = TextEditingController();
  bool _btnAtivado = true;
  bool _btnGoogle = true;
  bool _btnMicrosoft = true;

  @override
  void initState() {
    super.initState();
    _btnAtivado = true;
    _btnGoogle = true;
  }

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
    if (emails.isEmpty) {
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
                  "Essa conta não existe",
                  style: GoogleFonts.inter(),
                ),
              ],
            ),
            content: Text(
              "Deseja se cadastrar?",
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
                  Navigator.pushNamed(context, "/opcoesCadastro");
                },
                isDefaultAction: true,
                child: Text(
                  "Criar uma conta",
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
    } else if (emails.contains("microsoft.com")) {
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
                  "Essa conta existe com outro tipo de credencial",
                  style: GoogleFonts.inter(),
                ),
              ],
            ),
            content: Text(
              "Tente novamente com a opção Microsoft ou com Email",
              style: GoogleFonts.inter(),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context),
                isDefaultAction: true,
                child: Text(
                  "OK",
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
      if (!info.child("${cr.user?.uid}").exists) {
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
                    "Essa conta não existe",
                    style: GoogleFonts.inter(),
                  ),
                ],
              ),
              content: Text(
                "Deseja se cadastrar?",
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
                    Navigator.pushNamed(context, "/opcoesCadastro");
                  },
                  isDefaultAction: true,
                  child: Text(
                    "Criar uma conta",
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
                    "Essa conta existe com outro tipo de credencial",
                    style: GoogleFonts.inter(),
                  ),
                ],
              ),
              content: Text(
                "Tente novamente com a opção Google ou com Email",
                style: GoogleFonts.inter(),
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  isDefaultAction: true,
                  child: Text(
                    "OK",
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.cor(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Background(),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: conteudo(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget conteudo(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 100),
          child: Center(
            child: Text(
              "Entrar",
              style: TextStyle(
                fontFamily: "Queensides",
                fontSize: 60,
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: formLogin(context),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Divider(
                    color: Tema.noFundo.cor(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "ou",
                  style: GoogleFonts.inter(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Divider(
                    color: Tema.noFundo.cor(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.fromLTRB(55, 0, 55, 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Tema.fundo.cor(),
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
                  color: Tema.botaoIndex.cor(),
                  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                  onPressed: switch (index) {
                    0 => _btnGoogle
                        ? () async {
                            UserCredential? cr = await signInWithGoogle();
                            if (cr != null) {
                              setState(() {
                                userFlyvoo = cr.user;
                              });
                              if (!mounted) return;
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                "/home",
                              );
                              final inst =
                                  await SharedPreferences.getInstance();
                              inst.setBool(
                                "cadastroTerminado",
                                true,
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
                            UserCredential? cr = await signInWithMicrosoft();
                            if (cr != null) {
                              setState(() {
                                userFlyvoo = cr.user;
                              });
                              if (!mounted) return;
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                              Navigator.pushReplacementNamed(
                                context,
                                "/home",
                              );
                              final inst =
                                  await SharedPreferences.getInstance();
                              inst.setBool(
                                "cadastroTerminado",
                                true,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: _botoes[index].icon,
                          height: 29,
                          color: Tema.textoBotaoIndex.cor(),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        _botoes[index].text,
                        style: GoogleFonts.inter(
                          color: Tema.textoBotaoIndex.cor(),
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
              height: 15,
            ),
            Text.rich(
              style: GoogleFonts.inter(
                color: Tema.noFundo.cor(),
                letterSpacing: -0.41,
                fontWeight: FontWeight.w400,
              ),
              TextSpan(
                text: "Não possui cadastro? ",
                children: <InlineSpan>[
                  TextSpan(
                    text: "Clique aqui",
                    style: GoogleFonts.inter(
                      color: dark
                          ? Tema.primaria.cor()
                          : Tema.textoBotaoIndex.cor(),
                      decoration: TextDecoration.underline,
                      decorationColor: dark
                          ? Tema.primaria.cor()
                          : Tema.textoBotaoIndex.cor(),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushReplacementNamed(
                          context,
                          "/opcoesCadastro",
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Form formLogin(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TextFormField(
            key: _loginKey,
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
            controller: _txtEmail,
            cursorColor: Tema.primaria.cor(),
            autofillHints: const [
              AutofillHints.email,
            ],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: GoogleFonts.inter(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Tema.primaria.cor(),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            key: _senhaKey,
            controller: _txtSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 8) {
                return "A senha tem mais de 8 caracteres.";
              }
              return null;
            },
            onChanged: (value) {
              _senhaKey.currentState!.validate();
            },
            cursorColor: Tema.primaria.cor(),
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: GoogleFonts.inter(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Tema.primaria.cor(),
                ),
              ),
              suffix: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Icon(
                      _iconeOlho,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        if (_txtEscondido) {
                          _iconeOlho = Icons.visibility_off_rounded;
                          _txtEscondido = false;
                        } else {
                          _iconeOlho = Icons.visibility_rounded;
                          _txtEscondido = true;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: RichText(
              text: TextSpan(
                text: "Esqueceu a senha?",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color:
                      dark ? Tema.primaria.cor() : Tema.textoBotaoIndex.cor(),
                  decoration: TextDecoration.underline,
                  decorationColor:
                      dark ? Tema.primaria.cor() : Tema.textoBotaoIndex.cor(),
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(
                      context,
                      "/login/recuperacao",
                    );
                  },
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Tema.fundo.cor(),
              boxShadow: _btnAtivado
                  ? <BoxShadow>[
                      BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                        color: const Color(
                          0xff000000,
                        ).withOpacity(0.25),
                      ),
                    ]
                  : [],
            ),
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(10),
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
              color: Tema.botaoIndex.cor(),
              disabledColor: dark
                  ? const Color(0xff007AFF).withOpacity(0.15)
                  : const Color(0xffFB5607).withOpacity(0.30),
              onPressed: _btnAtivado
                  ? () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _btnAtivado = false;
                        });
                        try {
                          final cr = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: _txtEmail.text,
                            password: _txtSenha.text,
                          );
                          setState(() {
                            userFlyvoo = cr.user;
                          });
                          if (!mounted) return;
                          Navigator.popUntil(
                            context,
                            (route) => route.isFirst,
                          );
                          Navigator.pushReplacementNamed(
                            context,
                            "/home",
                          );
                          TextInput.finishAutofillContext(
                            shouldSave: true,
                          );
                          final inst = await SharedPreferences.getInstance();
                          inst.setBool(
                            "cadastroTerminado",
                            true,
                          );
                        } on FirebaseException catch (e) {
                          setState(() {
                            _btnAtivado = true;
                          });
                          if (e.code == "user-not-found") {
                            if (!mounted) return;
                            Flushbar(
                              duration: const Duration(seconds: 5),
                              margin: const EdgeInsets.all(20),
                              borderRadius: BorderRadius.circular(50),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              messageText: Row(
                                children: [
                                  Icon(
                                    Symbols.error_rounded,
                                    fill: 1,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Usuário não existe",
                                    style: GoogleFonts.inter(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ).show(context);
                          } else if (e.code == "wrong-password") {
                            if (!mounted) return;
                            Flushbar(
                              duration: const Duration(seconds: 5),
                              margin: const EdgeInsets.all(20),
                              borderRadius: BorderRadius.circular(50),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              messageText: Row(
                                children: [
                                  Icon(
                                    Symbols.error_rounded,
                                    fill: 1,
                                    color:
                                        Theme.of(context).colorScheme.onError,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Senha incorreta",
                                    style: GoogleFonts.inter(
                                      color:
                                          Theme.of(context).colorScheme.onError,
                                    ),
                                  ),
                                ],
                              ),
                            ).show(context);
                          } else if (e.code == "too-many-requests") {
                            if (!mounted) return;
                            Flushbar(
                              duration: const Duration(seconds: 5),
                              margin: const EdgeInsets.all(20),
                              borderRadius: BorderRadius.circular(50),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              messageText: Row(
                                children: [
                                  Icon(
                                    Symbols.error_rounded,
                                    fill: 1,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "Muitas tentativas, tente novamente mais tarde.",
                                      style: GoogleFonts.inter(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ).show(context);
                          }
                        }
                      }
                    }
                  : null,
              child: Text(
                "Entrar",
                style: GoogleFonts.inter(
                  fontSize: 25,
                  color: Tema.textoBotaoIndex.cor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
