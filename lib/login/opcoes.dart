import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
    _btnAtivado = true;
    _btnGoogle = true;
    super.initState();
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
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
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
                Navigator.pushNamed(context, "/cadastro");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                            onChanged: (value) {
                              _loginKey.currentState!.validate();
                            },
                            controller: _txtEmail,
                            cursorColor: tema["primaria"],
                            autofillHints: const [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "Email",
                              labelStyle: GoogleFonts.inter(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: tema["primaria"]!,
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
                            cursorColor: tema["primaria"],
                            autofillHints: const [AutofillHints.password],
                            obscureText: _txtEscondido,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: GoogleFonts.inter(),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: tema["primaria"]!,
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
                                          _iconeOlho =
                                              Icons.visibility_off_rounded;
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
                                    color: tema["primaria"],
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                        context,
                                        "/login/recuperacao",
                                      );
                                    }),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: tema["fundo"],
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
                              padding:
                                  const EdgeInsets.fromLTRB(25, 10, 25, 10),
                              color: tema["botaoIndex"],
                              disabledColor: dark
                                  ? const Color(0xff007AFF).withOpacity(0.15)
                                  : const Color(0xffFB5607).withOpacity(0.30),
                              onPressed: _btnAtivado
                                  ? () async {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _btnAtivado = false;
                                        });
                                        TextInput.finishAutofillContext();
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
                                        } on FirebaseException catch (e) {
                                          setState(() {
                                            _btnAtivado = true;
                                          });
                                          if (e.code == "user-not-found") {
                                            Flushbar(
                                              duration:
                                                  const Duration(seconds: 5),
                                              margin: const EdgeInsets.all(20),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              messageText: Row(
                                                children: [
                                                  Icon(
                                                    Symbols.error_rounded,
                                                    fill: 1,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
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
                                          } else if (e.code ==
                                              "wrong-password") {
                                            Flushbar(
                                              duration:
                                                  const Duration(seconds: 5),
                                              margin: const EdgeInsets.all(20),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              messageText: Row(
                                                children: [
                                                  Icon(
                                                    Symbols.error_rounded,
                                                    fill: 1,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onError,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    "Senha incorreta",
                                                    style: GoogleFonts.inter(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onError,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).show(context);
                                          } else if (e.code ==
                                              "too-many-requests") {
                                            Flushbar(
                                              duration:
                                                  const Duration(seconds: 5),
                                              margin: const EdgeInsets.all(20),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              messageText: Row(
                                                children: [
                                                  Icon(
                                                    Symbols.error_rounded,
                                                    fill: 1,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
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
                                  color: tema["textoBotaoIndex"],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          color: tema["noFundo"],
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
                          color: tema["noFundo"],
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
                          0 => _btnGoogle
                              ? () async {
                                  UserCredential? cr = await signInWithGoogle();
                                  if (cr != null) {
                                    userFlyvoo = cr.user;
                                    if (!mounted) return;
                                    Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    );
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/home",
                                    );
                                  } else {
                                    setState(() {
                                      _btnGoogle = true;
                                    });
                                  }
                                }
                              : null,
                          _ => () async {
                              Navigator.pushNamed(
                                context,
                                "/home",
                              );
                            },
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
                                color: tema["textoBotaoIndex"],
                              ),
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
                        /* switch (index) {
                            case 0:
                              final cr = await signInWithGoogle();
                              if (cr != null) {
                                if (!mounted) return;
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/home",
                                );
                              }

                              break;
                            default:
                              Navigator.pushReplacementNamed(
                                context,
                                "/home",
                              );
                          } */
                      ),
                    ),
                    itemCount: _botoes.length,
                    shrinkWrap: true,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text.rich(
                    style: GoogleFonts.inter(
                      color: tema["noFundo"],
                    ),
                    TextSpan(
                      text: "Não possui cadastro? ",
                      children: <InlineSpan>[
                        TextSpan(
                          text: "Clique aqui",
                          style: GoogleFonts.inter(
                            color: dark
                                ? tema["primaria"]
                                : tema["textoBotaoIndex"],
                            decoration: TextDecoration.underline,
                            decorationColor: dark
                                ? tema["primaria"]
                                : tema["textoBotaoIndex"],
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
                  const SizedBox(
                    height: 40,
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
/* TextFormField(
                    key: _loginKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Obrigatório";
                      } else if (!value.contains("@gmail.com") &&
                          !value.contains("@etec.sp.gov.br") &&
                          !value.contains("@outlook.com") &&
                          !value.contains("@hotmail.com")) {
                        return "Email inválido";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _loginKey.currentState!.validate();
                    },
                    cursorColor: tema["primaria"],
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: GoogleFonts.inter(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: tema["primaria"]!,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: _senhaKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "*Obrigatório";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _senhaKey.currentState!.validate();
                    },
                    cursorColor: tema["primaria"],
                    autofillHints: const [AutofillHints.password],
                    obscureText: _txtEscondido,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: GoogleFonts.inter(),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: tema["primaria"]!,
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
                                  _iconeOlho =
                                      Icons.visibility_off_rounded;
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
                            color: tema["primaria"],
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: mudar senha
                            }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Não possui cadastro? ",
                      style: GoogleFonts.inter(
                        color: tema["noFundo"],
                      ),
                      children: [
                        TextSpan(
                          text: "Clique aqui",
                          style: GoogleFonts.inter(
                            color: tema["primaria"],
                            decoration: TextDecoration.underline,
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
                  const SizedBox(
                    height: 20,
                  ),
                  CupertinoButton(
                    borderRadius: BorderRadius.circular(10),
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    color: tema["primaria"]?.withOpacity(0.65),
                    onPressed: () {
                      TextInput.finishAutofillContext();
                      // TODO: entrar
                      if (_formKey.currentState!.validate()) {
                        debugPrint("ebaa");
                      }
                    },
                    child: Text(
                      "Entrar",
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ), */