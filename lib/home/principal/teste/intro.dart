// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:spotlight_ant/spotlight_ant.dart';

class Introducao extends StatefulWidget {
  const Introducao({super.key});

  @override
  State<Introducao> createState() => _IntroducaoState();
}

enum OpcoesTeste {
  discordoMuito,
  discordoPouco,
  neutro,
  concordoPouco,
  concordoMuito,
}

OpcoesTeste? opcaoEscolhida;

class _IntroducaoState extends State<Introducao> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (popou) async {
        bool resposta = await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text("Tem certeza que deseja sair?"),
            content: Text("Você perderá todo o seu progresso até aqui"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, false),
                child: Text(
                  "Cancelar",
                  style: GoogleFonts.inter(
                    color: CupertinoColors.systemBlue,
                  ),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  "Sair",
                  style: GoogleFonts.inter(
                    color: CupertinoColors.systemRed,
                  ),
                ),
              ),
            ],
          ),
        );
        if (resposta) {
          if (!mounted) return;
          Navigator.pop(context);
        }
      },
      child: SpotlightShow(
        skipWhenPop: false,
        child: Scaffold(
          backgroundColor: Tema.fundo.cor(),
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image(
                  image: AssetImage(
                    dark
                        ? "assets/background/teste fundo dark.png"
                        : "assets/background/teste fundo light.png",
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    header(context),
                    SizedBox(
                      height: 125,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            RadioListTile(
                              title: Text(
                                "Discordo muito",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                ),
                              ),
                              fillColor: MaterialStatePropertyAll(
                                Color(0xffFF0000),
                              ),
                              value: OpcoesTeste.discordoMuito,
                              groupValue: opcaoEscolhida,
                              onChanged: (selecionado) {
                                setState(() {
                                  opcaoEscolhida = selecionado;
                                });
                              },
                            ),
                            Divider(
                              color: Tema.noFundo.cor(),
                            ),
                            RadioListTile(
                              title: Text(
                                "Discordo pouco",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                ),
                              ),
                              fillColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 255, 120, 120),
                              ),
                              value: OpcoesTeste.discordoPouco,
                              groupValue: opcaoEscolhida,
                              onChanged: (selecionado) {
                                setState(() {
                                  opcaoEscolhida = selecionado;
                                });
                              },
                            ),
                            Divider(
                              color: Tema.noFundo.cor(),
                            ),
                            RadioListTile(
                              title: Text(
                                "Neutro",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                ),
                              ),
                              fillColor: MaterialStatePropertyAll(
                                Colors.grey,
                              ),
                              value: OpcoesTeste.neutro,
                              groupValue: opcaoEscolhida,
                              onChanged: (selecionado) {
                                setState(() {
                                  opcaoEscolhida = selecionado;
                                });
                              },
                            ),
                            Divider(
                              color: Tema.noFundo.cor(),
                            ),
                            RadioListTile(
                              title: Text(
                                "Concordo pouco",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                ),
                              ),
                              fillColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 105, 172, 99),
                              ),
                              value: OpcoesTeste.concordoPouco,
                              groupValue: opcaoEscolhida,
                              onChanged: (selecionado) {
                                setState(() {
                                  opcaoEscolhida = selecionado;
                                });
                              },
                            ),
                            Divider(
                              color: Tema.noFundo.cor(),
                            ),
                            RadioListTile(
                              title: Text(
                                "Concordo muito",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                ),
                              ),
                              fillColor: MaterialStatePropertyAll(
                                Color(0xff1F9E14),
                              ),
                              value: OpcoesTeste.concordoMuito,
                              groupValue: opcaoEscolhida,
                              onChanged: (selecionado) {
                                setState(() {
                                  opcaoEscolhida = selecionado;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    CupertinoButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      color: Colors.blue,
                      onPressed: () {},
                      child: Text(
                        "Próximo",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack header(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 225,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          left: 75 / 2,
          top: 125,
          child: SpotlightAnt(
            spotlight: SpotlightConfig(
              builder: SpotlightRectBuilder(borderRadius: 25),
            ),
            content: Text("data"),
            child: Container(
              width: MediaQuery.of(context).size.width - 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  "Tenho facilidade em executar várias tarefas ao mesmo tempo sem necessariamente ter uma rotina.",
                  style: GoogleFonts.inter(
                    color: Tema.fundo.cor(),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: IconButton(
            onPressed: () async {
              bool resposta = await showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Tem certeza que deseja sair?"),
                  content: Text("Você perderá todo o seu progresso até aqui"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.inter(
                          color: CupertinoColors.systemBlue,
                        ),
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(
                        "Sair",
                        style: GoogleFonts.inter(
                          color: CupertinoColors.systemRed,
                        ),
                      ),
                    ),
                  ],
                ),
              );
              if (resposta) {
                if (!mounted) return;
                Navigator.pop(context);
              }
            },
            icon: Icon(
              Symbols.close,
              size: 30,
            ),
            color: Tema.noFundo.cor(),
          ),
        ),
      ],
    );
  }
}
