import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/home/principal/teste/pergunta.dart';
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
            title: const Text("Tem certeza que deseja sair?"),
            content: const Text("Você perderá todo o seu progresso até aqui"),
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
        onFinish: () {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => Pergunta(0, listaPerguntas),
            ),
          );
        },
        onSkip: () {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => Pergunta(0, listaPerguntas),
            ),
          );
        },
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
                    const SizedBox(
                      height: 125,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: SpotlightAnt(
                          index: 1,
                          spotlight: const SpotlightConfig(
                            builder: SpotlightRectBuilder(borderRadius: 25),
                          ),
                          content: Center(
                            child: Text(
                              "São 5 opções de respostas\nResponda com responsabilidade",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 25,
                              ),
                            ),
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
                                fillColor: const MaterialStatePropertyAll(
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
                                fillColor: const MaterialStatePropertyAll(
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
                                fillColor: const MaterialStatePropertyAll(
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
                                fillColor: const MaterialStatePropertyAll(
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
                                fillColor: const MaterialStatePropertyAll(
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
                    ),
                    SpotlightAnt(
                      index: 2,
                      spotlight: const SpotlightConfig(
                        builder: SpotlightRectBuilder(borderRadius: 8),
                      ),
                      content: Center(
                        child: Text(
                          "Clique aqui para avançar no teste",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 25,
                          ),
                        ),
                      ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 30),
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
                    ),
                    const SizedBox(
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
          decoration: const BoxDecoration(
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
            index: 0,
            spotlight: const SpotlightConfig(
              builder: SpotlightRectBuilder(borderRadius: 25),
            ),
            content: Center(
              child: Text(
                "A pergunta aparece aqui",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 25,
                ),
              ),
            ),
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
          child: SpotlightAnt(
            index: 3,
            spotlight: const SpotlightConfig(
              builder: SpotlightCircularBuilder(),
            ),
            content: Center(
              child: Text(
                "Você pode sair do quiz a qualquer momento",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 25,
                ),
              ),
            ),
            child: IconButton(
              onPressed: () async {
                bool resposta = await showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Tem certeza que deseja sair?"),
                    content: const Text(
                        "Você perderá todo o seu progresso até aqui"),
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
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.edgeToEdge,
                  );
                  if (!mounted) return;
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Symbols.close,
                size: 30,
              ),
              color: Tema.noFundo.cor(),
            ),
          ),
        ),
      ],
    );
  }
}
