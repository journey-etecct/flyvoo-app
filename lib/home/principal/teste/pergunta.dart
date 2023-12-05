import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyvoo/home/principal/teste/intro.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class Pergunta extends StatefulWidget {
  final Map<String, List<Area>> listaDePerguntas;
  final int pergIndex;
  const Pergunta(this.pergIndex, this.listaDePerguntas, {super.key});

  @override
  State<Pergunta> createState() => _PerguntaState();
}

class _PerguntaState extends State<Pergunta> {
  bool _congratuleixos = false;

  @override
  void initState() {
    super.initState();
    opcaoEscolhida = null;
  }

  @override
  Widget build(BuildContext context) {
    final areasPergunta =
        widget.listaDePerguntas.values.toList()[widget.pergIndex];

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
                    child: PageTransitionSwitcher(
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
                      child: [escolha(), pulando()][_congratuleixos ? 1 : 0],
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 30,
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      if (widget.pergIndex == 29) {
                      } else {
                        if (_congratuleixos) {
                          setState(() {
                            _congratuleixos = false;
                          });
                        } else {
                          setState(() {
                            _congratuleixos =
                                widget.pergIndex == 9 || widget.pergIndex == 19;
                          });
                        }

                        if (opcaoEscolhida != null && !_congratuleixos) {
                          switch (opcaoEscolhida) {
                            case OpcoesTeste.concordoMuito:
                              for (Area area in areasPergunta) {
                                resultados[area] = resultados[area]! + 100;
                              }
                              break;
                            case OpcoesTeste.concordoPouco:
                              for (Area area in areasPergunta) {
                                resultados[area] = resultados[area]! + 50;
                              }
                              break;
                            case OpcoesTeste.discordoMuito:
                              for (Area area in areasPergunta) {
                                resultados[area] = resultados[area]! - 100;
                              }
                              break;
                            case OpcoesTeste.discordoPouco:
                              for (Area area in areasPergunta) {
                                resultados[area] = resultados[area]! - 50;
                              }
                              break;
                            default:
                          }
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => Pergunta(
                                widget.pergIndex + 1,
                                listaPerguntas,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Próximo",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
    );
  }

  Widget pulando() {
    return Column(
      children: [
        SvgPicture.asset("assets/imagens/pulando.svg"),
        Text(
          "Você está indo bem!",
          style: GoogleFonts.inter(
            fontSize: 24,
          ),
        ),
      ],
    );
  }

  Padding escolha() {
    return Padding(
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
    );
  }

  Stack header(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
          height: _congratuleixos ? 80 : 225,
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
          top: 150,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            opacity: _congratuleixos ? 0 : 1,
            child: Container(
              width: MediaQuery.of(context).size.width - 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.listaDePerguntas.keys.toList()[widget.pergIndex],
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
                  title: const Text("Tem certeza que deseja sair?"),
                  content:
                      const Text("Você perderá todo o seu progresso até aqui"),
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
      ],
    );
  }
}

Map<Area, num> resultados = {
  Area.corporalCin: 0,
  Area.espacial: 0,
  Area.existencial: 0,
  Area.interpessoal: 0,
  Area.intrapessoal: 0,
  Area.linguistica: 0,
  Area.logicoMat: 0,
  Area.musical: 0,
  Area.naturalista: 0,
};

Map<String, List<Area>> listaPerguntas = {
  "Me identifico melhor na área de humanas": [
    Area.linguistica,
    Area.interpessoal,
    Area.intrapessoal,
    Area.existencial,
    Area.naturalista,
    Area.musical,
  ],
  "Me identifico melhor na área de exatas": [
    Area.logicoMat,
    Area.espacial,
    Area.naturalista,
  ],
  "Gosto de passar o tempo ao ar livre": [
    Area.naturalista,
    Area.existencial,
  ],
  "Gosto de falar em público e/ou explicar determinado assunto a pessoas": [
    Area.linguistica,
    Area.intrapessoal,
  ],
  "Eu sou bom em identificar expressões e emoções de outras pessoas": [
    Area.interpessoal,
    Area.intrapessoal,
  ],
  "Procuro ajudar os outros a resolverem os seus problemas no geral": [
    Area.interpessoal,
    Area.existencial,
  ],
  "Consigo visualizar projetos claramente, antes mesmo de fazer os primeiros rascunhos":
      [
    Area.espacial,
  ],
  "Gosto de tocar instrumentos musicais": [
    Area.musical,
  ],
  "Possuo habilidades para reconhecer notas musicais": [
    Area.musical,
  ],
  "Aprendo com facilidade e procuro utilizar novas ferramentas para qualquer atividade":
      [
    Area.linguistica,
    Area.interpessoal,
  ],
  "Tenho facilidade em correlacionar minhas emoções à imagens, cenários e cores":
      [
    Area.espacial,
    Area.intrapessoal,
    Area.existencial,
  ],
  "Prefiro liderar do que ser comandado": [
    Area.linguistica,
    Area.interpessoal,
  ],
  "Gosto de solucionar quebra-cabeças": [
    Area.logicoMat,
    Area.espacial,
  ],
  "Não me perco facilmente e posso me orientar com mapas": [
    Area.espacial,
  ],
  "Me sinto bem me comunicando e sendo o centro das atenções": [
    Area.linguistica,
    Area.interpessoal,
  ],
  "Gosto de cuidar de plantas": [
    Area.naturalista,
  ],
  "Eu tenho um bom equilíbrio e coordenação olho-mão e me sinto confortável em esportes que usam uma bola":
      [
    Area.corporalCin,
  ],
  "As pessoas me acham um bom ouvinte": [
    Area.interpessoal,
    Area.intrapessoal,
  ],
  "Gosto de relacionar as causas das coisas com os seus efeitos": [
    Area.logicoMat,
    Area.existencial,
  ],
  "Eu me sinto mais confortável em atividades que eu possa fazer com as minhas próprias mãos":
      [
    Area.corporalCin,
  ],
  "Sou bom em influenciar pessoas": [
    Area.interpessoal,
    Area.linguistica,
  ],
  "Gosto de agir, transportar, embalar, desmontar, construir, agilizar": [
    Area.corporalCin,
    Area.espacial,
  ],
  "Me interesso por curiosidades sobre o mundo": [
    Area.existencial,
    Area.naturalista,
  ],
  "Acho interessante compreender a natureza e seus eventos": [
    Area.existencial,
    Area.naturalista,
  ],
  "Nas horas livres leio bastante": [
    Area.linguistica,
    Area.intrapessoal,
  ],
  "Tenho predisposição em aprender novas línguas": [
    Area.linguistica,
  ],
  "Não me sinto confortável em locais cheios": [
    Area.intrapessoal,
  ],
  "Me interesso em criar e/ou ouvir letras de música profundas": [
    Area.existencial,
    Area.intrapessoal,
    Area.linguistica,
    Area.musical,
  ],
  "Sou bom em administrar contas e meu próprio dinheiro": [
    Area.logicoMat,
  ],
  "Me dou bem trabalhando com pessoas de todas as idades": [
    Area.interpessoal,
  ],
};

Map<String, List<Area>> listaPerguntasTesteLongo = {
  "Eu me interesso por planilhas e gráficos": [
    Area.logicoMat,
    Area.espacial,
  ],
  "Valorizo áreas do conhecimento que envolvam biologia": [
    Area.naturalista,
    Area.logicoMat,
    Area.espacial,
  ],
  "Possuo habilidade e capacidade de entender, criar e sistematizar padrões": [
    Area.intrapessoal,
    Area.logicoMat,
  ],
  "Gosto de adrenalina": [
    Area.corporalCin,
    Area.naturalista,
  ],
  "Posso facilmente reproduzir cor, forma, sombreamento e textura em desenhos":
      [
    Area.espacial,
  ],
  "Eu me interesso em trabalhar com computador": [
    Area.logicoMat,
  ],
  "Eu me interesso pelo bem-estar de pessoas e animais": [
    Area.interpessoal,
    Area.naturalista,
  ],
  "Gosto de trabalhar com ideias, teorias e informações": [
    Area.logicoMat,
    Area.intrapessoal,
    Area.existencial,
  ],
  "Diariamente faço a comida em casa": [
    Area.logicoMat,
    Area.corporalCin,
  ],
  "Gostaria de ajudar mais no desenvolvimento sustentável": [
    Area.naturalista,
  ],
  "Compreendo estudos sobre gramática e literatura": [
    Area.linguistica,
  ],
  "Tenho interesse em trabalhar em laboratórios": [
    Area.logicoMat,
    Area.naturalista,
  ],
  "Desenvolvo aplicativos e/ou programas (ou pretendo)": [
    Area.logicoMat,
    Area.espacial,
  ],
  "Visitar, fotografar e ler sobre locais históricos": [
    Area.linguistica,
    Area.espacial,
    Area.existencial,
  ],
};
