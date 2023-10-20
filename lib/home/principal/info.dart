// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

Carreira _carreiraSelecionada = Carreira.administracao;
bool _reverse = false;
int _tela = 0;
late void Function(void Function()) setStateLista;

class AlertaVerMais extends StatefulWidget {
  final Area area;
  const AlertaVerMais(this.area, {super.key});

  @override
  State<AlertaVerMais> createState() => _AlertaVerMaisState();
}

class _AlertaVerMaisState extends State<AlertaVerMais> {
  late final List<Widget> _telas = [
    Lista(widget.area),
    Info(_carreiraSelecionada),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_tela == 0) {
          return true;
        } else {
          setState(() {
            _reverse = true;
            _tela = 0;
          });
          return false;
        }
      },
      child: BackdropFilter(
        filter: ColorFilter.mode(
          Colors.black.withOpacity(0.4),
          BlendMode.darken,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                child: Text(
                  "Informações da Inteligência",
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.41,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: dark
                      ? Colors.black.withOpacity(0.7)
                      : Colors.white.withOpacity(0.7),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                child: StatefulBuilder(
                  builder: (context, setStateL) {
                    setStateLista = setStateL;
                    return PageTransitionSwitcher(
                      reverse: _reverse,
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
                      child: _telas[_tela],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Lista extends StatefulWidget {
  final Area area;
  const Lista(this.area, {super.key});

  @override
  State<Lista> createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<(Carreira, int)> carreirasDessaArea = <(Carreira, int)>[];
  List<(Carreira, int)> construirLista() {
    carreirasDessaArea = [];
    for (Carreira carreira in Carreira.values) {
      for (int i = 0; i < carreira.inteligencias.length; i++) {
        if (carreira.inteligencias[i].$1 == widget.area) {
          carreirasDessaArea.add((carreira, i));
          break;
        }
      }
    }

    carreirasDessaArea.sort((a, b) {
      return b.$1.inteligencias[b.$2].$2.compareTo(a.$1.inteligencias[a.$2].$2);
    });

    return carreirasDessaArea;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const BouncingScrollPhysics(),
      children: construirLista().map<Widget>(
        (e) {
          return Material(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setStateLista(() {
                      _reverse = false;
                      _carreiraSelecionada = e.$1;
                      _tela = 1;
                    });
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                e.$1.nome,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Nessa área:',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                ),
                              ),
                              FAProgressBar(
                                currentValue: e.$1.inteligencias[e.$2].$2,
                                displayText: "%",
                                displayTextStyle: GoogleFonts.inter(
                                  color: Tema.noFundo.cor(),
                                ),
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                size: 20,
                                progressColor: dark
                                    ? widget.area.primaryLight()
                                    : widget.area.primaryDark(),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ],
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: Icon(Symbols.arrow_back),
                            iconSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                e != carreirasDessaArea.last
                    ? Divider(
                        color: Tema.noFundo.cor(),
                        height: 30,
                      )
                    : SizedBox(),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}

class Info extends StatefulWidget {
  final Carreira carreira;
  const Info(this.carreira, {super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Text("${widget.carreira}");
  }
}
