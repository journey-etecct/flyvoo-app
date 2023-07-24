import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/index.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class Recuperacao extends StatefulWidget {
  const Recuperacao({super.key});

  @override
  State<Recuperacao> createState() => _RecuperacaoState();
}

class _RecuperacaoState extends State<Recuperacao> {
  final _txtEmail = TextEditingController();
  final _keyEmail = GlobalKey<FormFieldState>();
  bool _btnAtivado = true;

  _mandarEmailRecuperacao(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if (!mounted) return;
      Navigator.pushNamed(context, "/login/recuperacao/emailEnviado");
    } on FirebaseAuthException catch (e) {
      setState(() {
        _btnAtivado = true;
      });
      debugPrint(e.code);
      if (e.code == "user-not-found") {
        Flushbar(
          duration: const Duration(seconds: 5),
          margin: const EdgeInsets.all(20),
          borderRadius: BorderRadius.circular(50),
          backgroundColor: Theme.of(context).colorScheme.primary,
          messageText: Row(
            children: [
              Icon(
                Symbols.error_rounded,
                fill: 1,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Usuário não existe",
                style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ).show(context);
      }
    }
  }

  _init() async {
    if (!iniciado) {
      controllerBG = VideoPlayerController.asset(
        dark ? "assets/background/dark.webm" : "assets/background/light.webm",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await controllerBG.initialize();
      await controllerBG.setLooping(true);
      setState(() {});
      final inst = await SharedPreferences.getInstance();
      if (inst.getBool("animacoes") ?? true) {
        await controllerBG.play();
      }
      setState(() {
        iniciado = true;
      });
    }
  }

  @override
  void initState() {
    _init();
    _btnAtivado = true;
    super.initState();
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
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      "RECUPERAÇÃO",
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
                      "Para recuperar sua conta, precisaremos do seu email para enviarmos um link para mudar sua senha:",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      key: _keyEmail,
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
                            color: tema["primaria"]!,
                          ),
                        ),
                      ),
                      cursorColor: tema["primaria"],
                    ),
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: tema["fundo"],
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
                                if (_keyEmail.currentState!.validate()) {
                                  Flushbar(
                                    message: "Conectando...",
                                    duration: const Duration(seconds: 5),
                                    margin: const EdgeInsets.all(20),
                                    borderRadius: BorderRadius.circular(50),
                                  ).show(context);
                                  setState(() {
                                    _btnAtivado = false;
                                  });
                                  await _mandarEmailRecuperacao(_txtEmail.text);
                                }
                              }
                            : null,
                        color: tema["botaoIndex"],
                        disabledColor: dark
                            ? const Color(0xff007AFF).withOpacity(0.15)
                            : const Color(0xffFB5607).withOpacity(0.30),
                        borderRadius: BorderRadius.circular(10),
                        padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                        child: Text(
                          "Enviar",
                          style: GoogleFonts.inter(
                            color: _btnAtivado
                                ? tema["textoBotaoIndex"]
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
          ),
        ],
      ),
    );
  }
}
