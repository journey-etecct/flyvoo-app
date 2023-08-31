import 'package:animations/animations.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

final _keySenha = GlobalKey<FormFieldState>();
final _keyNovaSenha = GlobalKey<FormFieldState>();
final _keyNovaSenhaConf = GlobalKey<FormFieldState>();
final _txtNovaSenha = TextEditingController();
final _txtNovaSenhaConf = TextEditingController();
final _txtSenha = TextEditingController();
bool _txtEscondido = true;
IconData _iconeOlho = Icons.visibility_rounded;
List<List<String>> _botoes = [
  ["Cancelar", "Voltar"],
  ["Próximo", "Alterar senha"],
];

class AlterarSenha extends StatefulWidget {
  const AlterarSenha({super.key});

  @override
  State<AlterarSenha> createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {
  final List<Widget> _listaTelas = [
    const InserirSenha(),
    const MudarSenha(),
  ];
  bool _reversed = false;
  int _step = 0;
  bool _btnAtivado = true;

  @override
  void initState() {
    super.initState();
    _step = 0;
    _btnAtivado = true;
    _reversed = false;
    _txtNovaSenha.text = "";
    _txtNovaSenhaConf.text = "";
    _txtSenha.text = "";
    _txtEscondido = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: Stack(
          children: [
            SizedBox.expand(
              child: Image(
                image: AssetImage(
                  dark
                      ? "assets/background/esfumadodark.png"
                      : "assets/background/esfumadolight.png",
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PageTransitionSwitcher(
                    reverse: _reversed,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> primaryAnimation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        fillColor: Colors.transparent,
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      );
                    },
                    child: _listaTelas[_step],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(0, 5),
                              color: const Color(
                                0xff000000,
                              ).withOpacity(0.25),
                            ),
                          ],
                        ),
                        height: 43,
                        width: 129,
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(10),
                          onPressed: switch (_step) {
                            0 => () => Navigator.pop(context),
                            _ => () => setState(() {
                                  _reversed = true;
                                  --_step;
                                }),
                          },
                          color: Colors.white,
                          padding: const EdgeInsets.all(0),
                          child: Text(
                            _botoes[0][_step],
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: const Offset(0, 3),
                              color: const Color(0xffF81B50).withOpacity(
                                0.5,
                              ),
                            ),
                          ],
                        ),
                        height: 43,
                        width: 150,
                        child: CupertinoButton(
                          onPressed: _btnAtivado
                              ? () async {
                                  switch (_step) {
                                    case 0:
                                      if (_keySenha.currentState!.validate()) {
                                        setState(() {
                                          _btnAtivado = false;
                                        });
                                        try {
                                          final cr = await userFlyvoo!
                                              .reauthenticateWithCredential(
                                            EmailAuthProvider.credential(
                                              email: userFlyvoo!.email!,
                                              password: _txtSenha.text,
                                            ),
                                          );
                                          setState(() {
                                            userFlyvoo = cr.user;
                                            _btnAtivado = true;
                                            _reversed = false;
                                            _step = 1;
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == "wrong-password") {
                                            if (!mounted) return;
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
                                            if (!mounted) return;
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
                                                  Flexible(
                                                    child: Text(
                                                      "Muitas tentativas, tente novamente mais tarde.",
                                                      style: GoogleFonts.inter(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onError,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).show(context);
                                          } else {
                                            if (!mounted) return;
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
                                                  Flexible(
                                                    child: Text(
                                                      "Erro desconhecido: ${e.code}",
                                                      style: GoogleFonts.inter(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onError,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).show(context);
                                          }
                                          setState(() {
                                            _btnAtivado = true;
                                          });
                                        }
                                      }
                                      break;
                                    default:
                                      if (_keyNovaSenha.currentState!
                                              .validate() &&
                                          _keyNovaSenhaConf.currentState!
                                              .validate()) {
                                        setState(() {
                                          _btnAtivado = false;
                                        });
                                        try {
                                          await userFlyvoo!.updatePassword(
                                            _txtNovaSenha.text,
                                          );
                                          TextInput.finishAutofillContext();
                                          setState(() {
                                            _btnAtivado = true;
                                          });
                                          if (!mounted) return;
                                          Navigator.pop(context, true);
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == "weak-password") {
                                            if (!mounted) return;
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
                                                  Flexible(
                                                    child: Text(
                                                      "Senha fraca, tente novamente com uma senha mais forte",
                                                      style: GoogleFonts.inter(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onError,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).show(context);
                                          }
                                          setState(() {
                                            _btnAtivado = true;
                                          });
                                        }
                                      }
                                  }
                                }
                              : null,
                          padding: const EdgeInsets.all(0),
                          color: const Color(0xffF81B50),
                          borderRadius: BorderRadius.circular(10),
                          child: Text(
                            _botoes[1][_step],
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class InserirSenha extends StatefulWidget {
  const InserirSenha({super.key});

  @override
  State<InserirSenha> createState() => _InserirSenhaState();
}

class _InserirSenhaState extends State<InserirSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 32,
            ),
            ClipOval(
              child: Image(
                width: 100,
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  userFlyvoo!.photoURL!,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userFlyvoo!.displayName!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: tema["texto"],
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    userFlyvoo!.email!,
                    style: GoogleFonts.inter(
                      color: tema["texto"],
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 32,
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Text(
          'Para continuar, insira sua senha atual',
          style: GoogleFonts.inter(
            color: tema["texto"],
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 46,
            right: 46,
          ),
          child: TextFormField(
            key: _keySenha,
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
              _keySenha.currentState!.validate();
            },
            cursorColor: tema["texto"],
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: GoogleFonts.inter(),
              floatingLabelStyle: TextStyle(
                color: tema["texto"],
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["texto"]!,
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
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}

class MudarSenha extends StatefulWidget {
  const MudarSenha({super.key});

  @override
  State<MudarSenha> createState() => _MudarSenhaState();
}

class _MudarSenhaState extends State<MudarSenha> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Nova Senha",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.41,
            color: tema["texto"],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 38,
            right: 30,
            top: 21,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                text: "Nível de segurança da senha:\n",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: tema["texto"],
                  height: 1.4,
                  letterSpacing: -0.41,
                ),
                children: [
                  TextSpan(
                    text:
                        'Use pelo menos 8 caracteres. Não use a senha de outro site ou algo muito óbvio, como a data de seu aniversário.',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 45,
            right: 45,
            top: 20,
          ),
          child: TextFormField(
            key: _keyNovaSenha,
            controller: _txtNovaSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 8) {
                return "A senha deve ter mais de 8 caracteres.";
              }
              return null;
            },
            onChanged: (value) {
              _keyNovaSenha.currentState!.validate();
              _keyNovaSenhaConf.currentState!.validate();
            },
            cursorColor: tema["texto"],
            autofillHints: const [AutofillHints.newPassword],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Nova senha",
              labelStyle: GoogleFonts.inter(),
              floatingLabelStyle: TextStyle(
                color: tema["texto"],
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["texto"]!,
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
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 46,
            right: 46,
          ),
          child: TextFormField(
            key: _keyNovaSenhaConf,
            controller: _txtNovaSenhaConf,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 8) {
                return "A senha tem mais de 8 caracteres";
              } else if (value != _txtNovaSenha.text) {
                return "As senhas não conferem";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: tema["texto"],
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Confirmar a nova senha",
              labelStyle: GoogleFonts.inter(),
              floatingLabelStyle: TextStyle(
                color: tema["texto"],
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["texto"]!,
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
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
