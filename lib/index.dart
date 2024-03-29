import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

bool iniciado = false;
Shader linearGradient = LinearGradient(
  colors: <Color>[
    Tema.primaria.cor(),
    Tema.noFundo.cor(),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 200.0));

class Index extends StatefulWidget {
  final bool cadastroTerminado;

  const Index(this.cadastroTerminado, {super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  init() async {
    controllerBG = VideoPlayerController.asset(
      dark ? "assets/background/dark.webm" : "assets/background/light.webm",
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    await controllerBG.initialize();
    await controllerBG.setLooping(true);
    await controllerBG.setVolume(0);
    setState(() {});
    final inst = await SharedPreferences.getInstance();
    if (inst.getBool("animacoes") ?? true) {
      await controllerBG.play();
    }
    iniciado = true;
    if (!kIsWeb) FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    super.initState();
    linearGradient = LinearGradient(
      colors: <Color>[
        Tema.primaria.cor(),
        Tema.noFundo.cor(),
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 200.0));
    init();
    if (!internetIniciado && !kIsWeb) {
      connecteo.connectionStream.listen((conectado) {
        if (!conectado) {
          Navigator.pushNamed(context, "/semInternet");
        }
      });
      internetIniciado = true;
    }
    if (!widget.cadastroTerminado && !kIsWeb) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => showCupertinoDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: CupertinoAlertDialog(
              title: Text(
                "Cadastro não finalizado",
                style: GoogleFonts.inter(),
              ),
              content: Text(
                "Deseja continuar o seu cadastro?",
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
                  isDefaultAction: true,
                  onPressed: () => Navigator.popAndPushNamed(
                    context,
                    "/cadastro",
                    arguments: "email",
                  ),
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
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.cor(),
      body: Stack(
        children: [
          const Background(),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image(
                              image: AssetImage(
                                dark
                                    ? "assets/logo/logogradientedark.png"
                                    : "assets/logo/logogradientelight.png",
                              ),
                              width: 266,
                              height: 266,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Bem-vindo(a) ao ",
                              style: GoogleFonts.inter(
                                fontSize: 32,
                                color: Tema.noFundo.cor(),
                              ),
                              children: [
                                TextSpan(
                                  text: "Flyvoo!",
                                  style: kIsWeb
                                      ? GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          color: Tema.primaria.cor(),
                                        )
                                      : GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = linearGradient,
                                        ),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "Sua jornada começa aqui",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const BotoesEntrada(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Tema.textoSecundario.cor(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  5,
                  20,
                  MediaQuery.of(context).padding.bottom + 20,
                ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "Ao usar o aplicativo, você concorda com nossos ",
                    style: GoogleFonts.inter(
                      color: Tema.textoSecundario.cor(),
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: "Termos de Uso & Política de Privacidade",
                        style: GoogleFonts.inter(
                          color: Tema.textoSecundario.cor(),
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/termos");
                          },
                      ),
                      TextSpan(
                        text: ".",
                        style: GoogleFonts.inter(
                          color: Tema.textoSecundario.cor(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<BotaoIndex> botoes = [
  BotaoIndex(Symbols.keyboard_double_arrow_right, "Continuar sem conta"),
  BotaoIndex(Symbols.mail_outline, "Continuar como usuário"),
  BotaoIndex(Symbols.account_circle, "Criar uma conta"),
];

class BotaoIndex {
  final String text;
  final IconData icon;

  BotaoIndex(this.icon, this.text);
}

List<String> botoesAlerta = ["Cancelar", "Me lembre depois", "Criar uma conta"];

class BotoesEntrada extends StatefulWidget {
  const BotoesEntrada({super.key});

  @override
  State<BotoesEntrada> createState() => _BotoesEntradaState();
}

class _BotoesEntradaState extends State<BotoesEntrada> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
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
          child: botaoEntrada(index, context),
        );
      },
      itemCount: botoes.length,
    );
  }

  CupertinoButton botaoEntrada(int index, BuildContext context) {
    return CupertinoButton(
      color: Tema.botaoIndex.cor(),
      borderRadius: BorderRadius.circular(50),
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Icon(
            botoes[index].icon,
            color: Tema.textoBotaoIndex.cor(),
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            botoes[index].text,
            style: GoogleFonts.inter(
              color: Tema.textoBotaoIndex.cor(),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      onPressed: () {
        switch (index) {
          case 0:
            showCupertinoDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CupertinoAlertDialog(
                  content: Padding(
                    padding: const EdgeInsets.fromLTRB(1.1, 0, 1.1, 0),
                    child: Text(
                      "Caso queira mais funcionalidade no app, sinta-se livre para se cadastrar quando quiser!",
                      style: GoogleFonts.inter(
                        fontSize: 17,
                      ),
                    ),
                  ),
                  actions: botoesAlerta
                      .map<CupertinoDialogAction>(
                        (value) => CupertinoDialogAction(
                          onPressed: () async {
                            switch (value) {
                              case "Cancelar":
                                Navigator.pop(context);
                                break;
                              case "Me lembre depois":
                                var inst =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  if (userFlyvoo != null) {
                                    inst.setString(
                                      "email",
                                      userFlyvoo!.providerData.first.email!,
                                    );
                                  }
                                  userFlyvoo = null;
                                });
                                if (!mounted) return;
                                Navigator.pop(context);
                                Navigator.pushReplacementNamed(
                                  context,
                                  "/home",
                                );
                                break;
                              default:
                                Navigator.popAndPushNamed(
                                  context,
                                  "/opcoesCadastro",
                                );
                            }
                          },
                          isDefaultAction: value == botoesAlerta.last,
                          child: Text(
                            value,
                            style: GoogleFonts.inter(
                              color: CupertinoColors.systemBlue,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            );
            break;
          case 1:
            Navigator.pushNamed(
              context,
              "/login",
            );
            break;
          default:
            Navigator.pushNamed(
              context,
              "/opcoesCadastro",
            );
        }
      },
    );
  }
}
