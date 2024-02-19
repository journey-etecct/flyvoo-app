import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/principal/principal.dart';
import 'package:flyvoo/home/principal/teste/intro.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    const Info(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (poppou) {
        if (poppou) return;

        if (_tela == 0) {
          Navigator.pop(context);
        } else {
          setState(() {
            _reverse = true;
            _tela = 0;
          });
        }
      },
      child: BackdropFilter(
        filter: ColorFilter.mode(
          Colors.black.withOpacity(0.4),
          BlendMode.darken,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
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

List<(Carreira, int)> carreirasDessaArea = <(Carreira, int)>[];

class _ListaState extends State<Lista> {
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
                              const SizedBox(
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
                                  fontWeight: FontWeight.w600,
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
                            icon: const Icon(Symbols.expand_more_rounded),
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
                    : const SizedBox(),
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
  late DataSnapshot _infoCarreira;

  @override
  void initState() {
    super.initState();

    _fezTeste =
        // TODO: programar se o usuário fez ou não o teste
        Future.delayed(const Duration(seconds: 2), () => false);

    _infoCarreira = carreirasDB
        .child(_carreiraSelecionada.toString().replaceAll("Carreira.", ""));
  }

  double _ratingCarga(String cargaHoraria) {
    if (cargaHoraria.contains(RegExp(r'[0-9]'))) {
      int cargaInt = 0;
      cargaInt = int.tryParse(cargaHoraria.replaceRange(3, null, "")) ?? 0;

      switch (cargaInt) {
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
    } else {
      return 999;
    }
  }

  double _ratingSalario(List<String> salarios) {
    final salarioMinInt = int.tryParse(
          salarios[0].replaceAll("R\$", "").replaceAll(",00", ""),
        ) ??
        0;
    final salarioMaxInt = int.tryParse(
          salarios[1].replaceAll("R\$", "").replaceAll(",00", ""),
        ) ??
        0;

    final media = (salarioMaxInt + salarioMinInt) / 2;
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
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          informacoes(_infoCarreira),
        ],
      ),
    );
  }

  Column informacoes(DataSnapshot infoCarreira) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            switch (Area.values[areaAtual - 1]) {
              Area.existencial ||
              Area.linguistica ||
              Area.corporalCin ||
              Area.espacial =>
                Icon(
                  Area.values[areaAtual - 1].icone,
                  size: 80,
                  color: dark
                      ? Area.values[areaAtual - 1].primaryDark()
                      : Area.values[areaAtual - 1].primaryLight(),
                ),
              _ => FaIcon(
                  Area.values[areaAtual - 1].icone,
                  size: 80,
                  color: dark
                      ? Area.values[areaAtual - 1].primaryDark()
                      : Area.values[areaAtual - 1].primaryLight(),
                ),
            },
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                _carreiraSelecionada.nome,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                  color: dark
                      ? Area.values[areaAtual - 1].primaryDark()
                      : Area.values[areaAtual - 1].primaryLight(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          infoCarreira.child("desc/").value as String,
          textAlign: TextAlign.justify,
          style: GoogleFonts.inter(
            color: Tema.texto.cor(),
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Salário",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${infoCarreira.child("salario/min").value} - ${infoCarreira.child("salario/max").value}",
          style: GoogleFonts.inter(
            color: const Color(0xFF00BF63),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        RatingBar(
          wrapAlignment: WrapAlignment.start,
          itemPadding: const EdgeInsets.symmetric(horizontal: 8.5),
          initialRating: _ratingSalario(
            [
              infoCarreira.child("salario/min").value as String,
              infoCarreira.child("salario/max").value as String,
            ],
          ),
          ignoreGestures: true,
          glow: false,
          allowHalfRating: false,
          ratingWidget: RatingWidget(
            full: const Icon(
              FontAwesomeIcons.moneyBillWave,
              fill: 1,
              color: Color(0xff00BF63),
              size: 45,
            ),
            half: const Icon(
              Symbols.star_rounded,
              fill: 1,
            ),
            empty: const Icon(
              FontAwesomeIcons.moneyBillWave,
              color: Color(0xffAEAEB2),
              size: 45,
            ),
          ),
          onRatingUpdate: (value) {},
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Carga Horária",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "${infoCarreira.child("cargaHoraria").value}",
          style: GoogleFonts.inter(
            color: const Color(0xffEB4549),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        _ratingCarga(
                  infoCarreira.child("cargaHoraria").value as String,
                ) <
                10
            ? RatingBar(
                itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                itemSize: 50,
                initialRating: _ratingCarga(
                  infoCarreira.child("cargaHoraria").value as String,
                ),
                ignoreGestures: true,
                glow: false,
                allowHalfRating: false,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Symbols.alarm,
                    color: Color(0xffEB4549),
                    weight: 700,
                  ),
                  half: const Icon(
                    Symbols.star_rounded,
                    fill: 1,
                  ),
                  empty: const Icon(
                    Symbols.alarm,
                    color: Color(0xffAEAEB2),
                    weight: 700,
                  ),
                ),
                onRatingUpdate: (value) {},
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Observações",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          infoCarreira.child("obs/").value as String,
          style: GoogleFonts.inter(
            fontSize: 22,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Inteligência(s)",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        painelIntel(),
        const SizedBox(
          height: 30,
        ),
        Text(
          "Sua compatibilidade",
          style: GoogleFonts.inter(
            fontSize: 24,
            color: Tema.texto.cor(),
            fontWeight: FontWeight.w700,
          ),
        ),
        fezTesteBotao(),
      ],
    );
  }

  FutureBuilder<bool> fezTesteBotao() {
    return FutureBuilder(
      future: _fezTeste,
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!) {
            return RatingBar(
              ratingWidget: RatingWidget(
                full: const Icon(
                  Symbols.star_rounded,
                  fill: 1,
                ),
                half: const Icon(
                  Symbols.star_rounded,
                  fill: 1,
                ),
                empty: const Icon(
                  Symbols.star_rounded,
                ),
              ),
              onRatingUpdate: (value) {},
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "REQUER TESTE DO USUÁRIO",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: Tema.texto.cor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 3),
                          color: const Color(0xffF81B50).withOpacity(0.5),
                        ),
                      ],
                    ),
                    height: 43,
                    width: 150,
                    child: CupertinoButton(
                      onPressed: () async {
                        if (userFlyvoo == null) {
                          alertaLogin(context);
                        } else {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const Introducao(),
                            ),
                          );
                        }
                      },
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
                ),
              ],
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  SizedBox painelIntel() {
    final intel = _carreiraSelecionada.inteligencias;
    return SizedBox(
      height: intel.length > 2 ? 180 : 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          ..._carreiraSelecionada.inteligencias.map<Widget>(
            (e) {
              switch (intel.length) {
                case 1:
                  return Center(
                    child: Tooltip(
                      message: e.$1.nome,
                      child: switch (e.$1) {
                        Area.existencial ||
                        Area.linguistica ||
                        Area.corporalCin ||
                        Area.espacial =>
                          Icon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: 135,
                          ),
                        _ => FaIcon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: 135,
                          ),
                      },
                    ),
                  );
                case 2:
                  return Positioned(
                    top: intel.first == e ? 0 : 70,
                    left: intel.first == e ? 50 : 150,
                    child: Tooltip(
                      message: e.$1.nome,
                      child: switch (e.$1) {
                        Area.existencial ||
                        Area.linguistica ||
                        Area.corporalCin ||
                        Area.espacial =>
                          Icon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: intel.first == e ? 100 : 80,
                          ),
                        _ => FaIcon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: intel.first == e ? 100 : 80,
                          ),
                      },
                    ),
                  );
                case 3:
                  return Positioned(
                    top: intel.first == e
                        ? 0
                        : intel.last != e
                            ? 50
                            : 100,
                    left: intel.first == e
                        ? 50
                        : intel.last != e
                            ? 160
                            : 90,
                    child: Tooltip(
                      message: e.$1.nome,
                      child: switch (e.$1) {
                        Area.existencial ||
                        Area.linguistica ||
                        Area.corporalCin ||
                        Area.espacial =>
                          Icon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: intel.first == e
                                ? 90
                                : intel.last != e
                                    ? 80
                                    : 60,
                          ),
                        _ => FaIcon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: intel.first == e
                                ? 90
                                : intel.last != e
                                    ? 80
                                    : 60,
                          ),
                      },
                    ),
                  );
                default:
                  return Positioned(
                    top: switch (intel.indexOf(e)) {
                      0 => 0,
                      1 => 30,
                      2 => 90,
                      _ => 110,
                    },
                    left: switch (intel.indexOf(e)) {
                      0 => 50,
                      1 => 150,
                      2 => 60,
                      _ => 140,
                    },
                    child: Tooltip(
                      message: e.$1.nome,
                      child: switch (e.$1) {
                        Area.existencial ||
                        Area.linguistica ||
                        Area.corporalCin ||
                        Area.espacial =>
                          Icon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: switch (intel.indexOf(e)) {
                              0 => 70,
                              1 => 65,
                              2 => 60,
                              _ => 55,
                            },
                          ),
                        _ => FaIcon(
                            e.$1.icone,
                            color:
                                dark ? e.$1.primaryDark() : e.$1.primaryDark(),
                            size: switch (intel.indexOf(e)) {
                              0 => 70,
                              1 => 65,
                              2 => 60,
                              _ => 55,
                            },
                          ),
                      },
                    ),
                  );
              }
            },
          ).toList(),
        ],
      ),
    );
  }
}
