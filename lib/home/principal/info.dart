// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flyvoo/home/principal/principal.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
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
    Info(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _tela == 0,
      onPopInvoked: (poppou) {
        if (poppou) return;

        setState(() {
          _reverse = true;
          _tela = 0;
        });
        Navigator.pop(context);
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
                    setState(() {
                      setStateLista(() {
                        _reverse = false;
                        _carreiraSelecionada = e.$1;
                        _tela = 1;
                      });
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
                          quarterTurns: 3,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                setStateLista(() {
                                  _reverse = false;
                                  _carreiraSelecionada = e.$1;
                                  _tela = 1;
                                });
                              });
                            },
                            icon: Icon(Symbols.expand_more_rounded),
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
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  late Future<bool> _fezTeste;
  late Future<DataSnapshot> _infoCarreira;

  @override
  void initState() {
    super.initState();

    _fezTeste =
        // TODO: programar se o usuário fez ou não o teste
        Future.delayed(Duration(seconds: 2), () => false);

    final ref = FirebaseDatabase.instance.ref("/carreiras/nome");
    _infoCarreira = ref.get();
  }

  double _ratingCarga(int cargaHoraria) {
    switch (cargaHoraria) {
      case < 10:
        return 1;
      case < 20:
        return 2;
      case < 30:
        return 3;
      case < 40:
        return 4;
      default:
        return 5;
    }
  }

  double _ratingSalario(List<int> salarios) {
    final media = (salarios.first + salarios.last) / 2;
    switch (media) {
      case < 1000:
        return 1;
      case < 3000:
        return 2;
      case < 6000:
        return 3;
      case < 9000:
        return 4;
      default:
        return 5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: _infoCarreira,
            builder: (context, infoCarreiraS) {
              if (infoCarreiraS.hasData &&
                  infoCarreiraS.connectionState == ConnectionState.done) {
                final infoCarreira = infoCarreiraS.data!;
                return Column(
                  children: [
                    Row(
                      children: [
                        Icon(Area.values[areaAtual - 1].icone),
                        Text(_carreiraSelecionada.nome),
                      ],
                    ),
                    Text("descrição"),
                    Text("Salário"),
                    Text(
                      "R\$${infoCarreira.child("salario/min").value},00 - R\$${infoCarreira.child("salario/max").value},00",
                    ),
                    RatingBar(
                      itemPadding: EdgeInsets.symmetric(horizontal: 10),
                      initialRating: _ratingSalario(
                        [
                          infoCarreira.child("salario/min").value as int,
                          infoCarreira.child("salario/max").value as int,
                        ],
                      ),
                      ignoreGestures: true,
                      glow: false,
                      allowHalfRating: false,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          FontAwesome.money_bill_wave,
                          fill: 1,
                          color: Color(0xff00BF63),
                        ),
                        half: Icon(
                          Symbols.star_rounded,
                          fill: 1,
                        ),
                        empty: Icon(
                          FontAwesome.money_bill_wave,
                          color: Color(0xffAEAEB2),
                        ),
                      ),
                      onRatingUpdate: (value) {},
                    ),
                    Text("Carga Horária"),
                    Text(
                      "${infoCarreira.child("cargaHoraria").value} ${infoCarreira.child("cargaHoraria").value as int < 2 ? "hora semanal" : "horas semanais"}",
                    ),
                    RatingBar(
                      itemPadding: EdgeInsets.symmetric(horizontal: 5),
                      itemSize: 50,
                      initialRating: _ratingCarga(
                        infoCarreira.child("cargaHoraria").value as int,
                      ),
                      ignoreGestures: true,
                      glow: false,
                      allowHalfRating: false,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Symbols.alarm,
                          color: Color(0xffEB4549),
                          grade: 600,
                        ),
                        half: Icon(
                          Symbols.star_rounded,
                          fill: 1,
                        ),
                        empty: Icon(
                          Symbols.alarm,
                          color: Color(0xffAEAEB2),
                          grade: 600,
                        ),
                      ),
                      onRatingUpdate: (value) {},
                    ),
                    Text("Observações"),
                    Text("tem que trabalhar"),
                    Text("Inteligências"),
                    Stack(),
                    Text("Sua compatibilidade"),
                    FutureBuilder(
                      future: _fezTeste,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data!) {
                            return RatingBar(
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Symbols.star_rounded,
                                  fill: 1,
                                ),
                                half: Icon(
                                  Symbols.star_rounded,
                                  fill: 1,
                                ),
                                empty: Icon(
                                  Symbols.star_rounded,
                                ),
                              ),
                              onRatingUpdate: (value) {},
                            );
                          } else {
                            return Column(
                              children: [
                                Text("REQUER TESTE DO USUÁRIO"),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        blurRadius: 20,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 3),
                                        color:
                                            const Color(0xffF81B50).withOpacity(
                                          0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 43,
                                  width: 150,
                                  child: CupertinoButton(
                                    onPressed: () async {},
                                    padding: const EdgeInsets.all(0),
                                    color: const Color(0xffF81B50),
                                    borderRadius: BorderRadius.circular(10),
                                    child: Text(
                                      "Fazer teste",
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          /* Text("nada"),
          RatingBar(
            ratingWidget: RatingWidget(
              full: Icon(
                Symbols.star_rounded,
                fill: 1,
              ),
              half: Icon(
                Symbols.star_rounded,
                fill: 1,
              ),
              empty: Icon(
                Symbols.star_rounded,
              ),
            ),
            onRatingUpdate: (value) {},
          ), */
        ],
      ),
    );
  }

  // ignore: unused_element
  String _pegarNomePadronizado(Carreira carreira) {
    final str = "$_carreiraSelecionada";
    return str.replaceAll("Carreira.", "");
  }
}
