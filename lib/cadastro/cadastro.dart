// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/verificacao/index.dart';
import 'package:flyvoo/login/login.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
/* import 'package:video_player/video_player.dart'; */ // TODO: video 1

final txtSenha = TextEditingController();
final txtSenhaConf = TextEditingController();

List<BotaoIndex> _botoes = [
  BotaoIndex(
    (null, Symbols.mail_outline_rounded),
    "Continuar com email",
  ),
  BotaoIndex(
    (AssetImage("assets/icons/email.png"), null),
    "Continuar com Google",
  ),
  BotaoIndex(
    (AssetImage("assets/icons/user.png"), null),
    "Continuar com Microsoft",
  ),
];

class BotaoIndex {
  final String text;
  final (AssetImage?, IconData?) icon;
  BotaoIndex(this.icon, this.text);
}

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  /* late VideoPlayerController _controllerLight;
  late VideoPlayerController _controllerDark;

  void startBothPlayers() async {
    await _controllerLight.play();
    await _controllerDark.play();
  }

  @override
  void initState() {
    _controllerLight = VideoPlayerController.asset(
      "assets/background/light.webm",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then(
        (_) {
          _controllerLight.setLooping(true);
          setState(() {});
        },
      );
    _controllerDark = VideoPlayerController.asset(
      "assets/background/dark.webm",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then(
        (_) {
          _controllerDark.setLooping(true);
          setState(() {});
        },
      );
    startBothPlayers();
    super.initState();
  }

  @override
  void dispose() {
    _controllerDark.dispose();
    _controllerLight.dispose();
    super.dispose();
  } */ // TODO: video 2

  @override
  Widget build(BuildContext context) {
    setState(() {
      _botoes = [
        BotaoIndex(
          (null, Symbols.mail_outline_rounded),
          "Continuar com email",
        ),
        BotaoIndex(
          (AssetImage("assets/icons/google.png"), null),
          "Continuar com Google",
        ),
        BotaoIndex(
          (AssetImage("assets/icons/microsoft.png"), null),
          "Continuar com Microsoft",
        ),
      ];
    });
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Stack(
        children: [
          /* AnimatedOpacity(
            opacity: dark ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controllerDark.value.size.width,
                  height: _controllerDark.value.size.height,
                  child: VideoPlayer(_controllerDark),
                ),
              ),
            ),
          ), */ // TODO: video 3
          Center(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                        fontFamily: "Queensides Light",
                        fontSize: 60,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
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
                          SizedBox(
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
                      onPressed: () {
                        switch (index) {
                          case 0:
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => VerificacaoEmail(),
                              ),
                            );
                            break;
                          default:
                        }
                      },
                    ),
                  ),
                  itemCount: _botoes.length,
                  shrinkWrap: true,
                ),
                SizedBox(
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
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => Login(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
