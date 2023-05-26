// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/login/cadastro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import 'login/login.dart';

// tema do aplicativo
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
Map<String, Color> tema = {
  "primaria": dark ? const Color(0xff00FFD8) : const Color(0xffFB5607),
  "fundo": dark ? const Color(0xff252525) : Colors.white,
  "noFundo": dark ? Colors.white : Colors.black,
};
// fim do tema do aplicativo

// variaveis iniciais
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
  late VideoPlayerController _controllerLight;
  late VideoPlayerController _controllerDark;

  void startBothPlayers() async {
    await _controllerLight.play();
    await _controllerDark.play();
  }

  @override
  void initState() {
    dark = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
        Brightness.dark;
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(),
      home: Scaffold(
        backgroundColor: tema["fundo"],
        body: Stack(
          children: [
            AnimatedOpacity(
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
            ),
            AnimatedOpacity(
              opacity: dark ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _controllerLight.value.size.width,
                    height: _controllerLight.value.size.height,
                    child: VideoPlayer(_controllerLight),
                  ),
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
                      color: tema["primaria"],
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'Hello World!',
                    style: TextStyle(
                      color: tema["noFundo"],
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
                          if (valorDropdown != selecionado) {
                            setState(() {
                              valorDropdown = selecionado;
                            });
                            switch (selecionado) {
                              case "Modo escuro":
                                setState(() {
                                  dark = true;
                                  tema = {
                                    "primaria": dark
                                        ? const Color(0xff00FFD8)
                                        : const Color(0xffFB5607),
                                    "fundo": dark
                                        ? const Color(0xff252525)
                                        : Colors.white,
                                    "noFundo":
                                        dark ? Colors.white : Colors.black,
                                  };
                                });
                                break;
                              case "Modo claro":
                                setState(() {
                                  dark = false;
                                  tema = {
                                    "primaria": dark
                                        ? const Color(0xff00FFD8)
                                        : const Color(0xffFB5607),
                                    "fundo": dark
                                        ? const Color(0xff252525)
                                        : Colors.white,
                                    "noFundo":
                                        dark ? Colors.white : Colors.black,
                                  };
                                });
                                break;
                              default:
                                setState(() {
                                  dark = SchedulerBinding
                                          .instance
                                          .platformDispatcher
                                          .platformBrightness ==
                                      Brightness.dark;
                                  tema = {
                                    "primaria": dark
                                        ? const Color(0xff00FFD8)
                                        : const Color(0xffFB5607),
                                    "fundo": dark
                                        ? const Color(0xff252525)
                                        : Colors.white,
                                    "noFundo":
                                        dark ? Colors.white : Colors.black,
                                  };
                                });
                            }
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
                  const Botoes()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Botoes extends StatefulWidget {
  const Botoes({
    super.key,
  });

  @override
  State<Botoes> createState() => _BotoesState();
}

class _BotoesState extends State<Botoes> {
  late GestureDetector botaoLogin;
  late GestureDetector botaoCadastro;

  @override
  void initState() {
    botaoLogin = GestureDetector(
      onTap: () async {
        final retorno = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Login(),
          ),
        );
        if (!mounted) return;
        if (retorno != null) {
          botaoCadastro.onTap!();
        }
      },
      child: FilledButton(
        onPressed: () async {
          final retorno = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Login(),
            ),
          );
          if (!mounted) return;
          if (retorno != null) {
            botaoCadastro.onTap!();
          }
        },
        child: const Text("login teste"),
      ),
    );
    botaoCadastro = GestureDetector(
      onTap: () async {
        final retorno = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Cadastro(),
          ),
        );
        if (!mounted) return;
        if (retorno != null) {
          botaoLogin.onTap!();
        }
      },
      child: FilledButton(
        onPressed: () async {
          final retorno = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Cadastro(),
            ),
          );
          if (!mounted) return;
          if (retorno != null) {
            botaoLogin.onTap!();
          }
        },
        child: const Text("cadastro teste"),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        botaoLogin,
        botaoCadastro,
        FilledButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
          child: const Text("home teste"),
        )
      ],
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

ThemeData _buildTheme() {
  var baseTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: tema["primaria"],
    brightness: dark ? Brightness.dark : Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: tema["primaria"],
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: tema["primaria"]!,
        ),
      ),
    ),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
