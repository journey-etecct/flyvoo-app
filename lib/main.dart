import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flyvoo/login.dart';
import 'package:video_player/video_player.dart';

Map<String, List> paletas = {
  "paletaVerde": [
    // Cores para Biologia, Química, Saúde
    const Color(0xff00bf63),
    const Color(0xff7ed957),
    const Color(0xffc1ff72),
    const Color(0xffedff59),
  ],
  "paletaLaranja": [
    // Cores para História, Geografia, Filosofia, Sociologia
    const Color(0xffaf5f15),
    const Color(0xffed974e),
    const Color(0xfff4c755),
    const Color(0xfffff24a),
  ],
  "paletaAzul": [
    // Cores para Mat., Pesquisas, Física, Marketing, RH, ADM
    const Color(0xff4974af),
    const Color(0xff49a3cf),
    const Color(0xff6fb1d1),
    const Color(0xff93d6e1),
  ],
  "paletaVermelho": [
    // Cores para Arte, literatura, expressão, teatro, dança, coach
    const Color(0xffd12525),
    const Color(0xfffa5656),
    const Color(0xffff5b5b),
    const Color(0xfff46a7f),
  ],
  "paletaRoxo": [
    // Cores para Abstratas: mente, programação, design
    const Color(0xffb243b0),
    const Color(0xffe855e6),
    const Color(0xffdb64f4),
    const Color(0xffff87ec),
  ]
};

Map<String, dynamic> temaLight = {
  "primaria": const Color(0xffFB5607),
  "fundo": Colors.white,
  "noFundo": Colors.black,
};

Map<String, dynamic> temaDark = {
  "primaria": const Color(0xff00FFD8),
  "fundo": const Color(0xff252525),
  "noFundo": Colors.white,
};

bool dark = false;
final List<String> listModo = <String>[
  "Modo escuro",
  "Modo claro",
  "Seguir o sistema"
];
String? valorDropdown = "Seguir o sistema";

void main() => runApp(const Flyvoo());

class Flyvoo extends StatefulWidget {
  const Flyvoo({
    super.key,
  });

  @override
  State<Flyvoo> createState() => _FlyvooState();
}

class _FlyvooState extends State<Flyvoo> {
  late VideoPlayerController _controller;

  _mudarTema() {
    setState(() {
      dark = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
      if (dark) {
        _controller = VideoPlayerController.asset("assets/dark.webm")
          ..initialize().then(
            (_) {
              _controller.play();
              _controller.setLooping(true);
              setState(() {});
            },
          );
      } else {
        _controller = VideoPlayerController.asset("assets/light.webm")
          ..initialize().then(
            (_) {
              _controller.play();
              _controller.setLooping(true);
              setState(() {});
            },
          );
      }
    });
  }

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/light.webm")
      ..initialize().then(
        (_) {
          _controller.play();
          _controller.setLooping(true);
          setState(() {});
        },
      );
    _mudarTema();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: dark ? temaDark["primaria"] : temaLight["primaria"],
          brightness: dark ? Brightness.dark : Brightness.light),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: dark ? temaDark["fundo"] : temaLight["fundo"],
          body: Stack(
            children: [
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controller.value.size.width,
                    height: _controller.value.size.height,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Teste de tema',
                      style: TextStyle(
                        color:
                            dark ? temaDark["primaria"] : temaLight["primaria"],
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Hello World!',
                      style: TextStyle(
                        color:
                            dark ? temaDark["noFundo"] : temaLight["noFundo"],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          borderRadius: BorderRadius.circular(25),
                          value: valorDropdown,
                          items: listModo.map<DropdownMenuItem<String>>(
                            (valor) {
                              return DropdownMenuItem<String>(
                                value: valor,
                                child: Text(valor),
                              );
                            },
                          ).toList(),
                          onChanged: (selecionado) {
                            setState(() {
                              valorDropdown = selecionado;
                            });
                            switch (selecionado) {
                              case "Modo escuro":
                                setState(() {
                                  dark = true;
                                  _controller = VideoPlayerController.asset(
                                      "assets/dark.webm")
                                    ..initialize().then(
                                      (_) {
                                        _controller.play();
                                        _controller.setLooping(true);
                                        setState(() {});
                                      },
                                    );
                                });
                                break;
                              case "Modo claro":
                                setState(() {
                                  dark = false;
                                  _controller = VideoPlayerController.asset(
                                      "assets/light.webm")
                                    ..initialize().then(
                                      (_) {
                                        _controller.play();
                                        _controller.setLooping(true);
                                        setState(() {});
                                      },
                                    );
                                });
                                break;
                              default:
                                setState(() {
                                  dark = SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.dark;
                                  if (dark) {
                                    _controller = VideoPlayerController.asset(
                                        "assets/dark.webm")
                                      ..initialize().then(
                                        (_) {
                                          _controller.play();
                                          _controller.setLooping(true);
                                          setState(() {});
                                        },
                                      );
                                  } else {
                                    _controller = VideoPlayerController.asset(
                                        "assets/light.webm")
                                      ..initialize().then(
                                        (_) {
                                          _controller.play();
                                          _controller.setLooping(true);
                                          setState(() {});
                                        },
                                      );
                                  }
                                });
                            }
                          },
                        )
                        /* Switch(
                          value: dark,
                          onChanged: (value) {
                            setState(
                              () {
                                dark = !dark;
                                if (!dark) {
                                  _controller = VideoPlayerController.asset(
                                      "assets/light.webm")
                                    ..initialize().then(
                                      (_) {
                                        _controller.play();
                                        _controller.setLooping(true);
                                        setState(() {});
                                      },
                                    );
                                } else {
                                  _controller = VideoPlayerController.asset(
                                      "assets/dark.webm")
                                    ..initialize().then(
                                      (_) {
                                        _controller.play();
                                        _controller.setLooping(true);
                                        setState(() {});
                                      },
                                    );
                                }
                              },
                            );
                          },
                        ), */
                      ],
                    ),
                    const LoginBotao()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginBotao extends StatelessWidget {
  const LoginBotao({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
      },
      child: const Text("login teste"),
    );
  }
}
