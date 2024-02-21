// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/home/principal/info.dart';
import 'package:flyvoo/home/principal/teste/pergunta.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class Resultados extends StatefulWidget {
  const Resultados({super.key});

  @override
  State<Resultados> createState() => _ResultadosState();
}

class _ResultadosState extends State<Resultados> {
  List<(Area, num)> _listaArray = [];
  int listCount = 3;

  _init() {
    for (Area area in resultados.keys) {
      _listaArray.add((area, resultados[area]!));
    }

    _listaArray.sort((a, b) => (a.$2 - b.$2).toInt());
    List<(Area, num)> outraListaArray = [];

    for (var inteligencia in _listaArray) {
      outraListaArray.add(
        (
          inteligencia.$1,
          calcularPorcentagem(
            _listaArray.first.$2,
            _listaArray.last.$2,
            inteligencia.$2,
          ),
        ),
      );
    }

    _listaArray = outraListaArray.reversed.toList();
  }

  List<(Carreira, int)> construirLista(Area area) {
    carreirasDessaArea = [];
    for (Carreira carreira in Carreira.values) {
      for (int i = 0; i < carreira.inteligencias.length; i++) {
        if (carreira.inteligencias[i].$1 == area) {
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
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (poppou) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      child: Scaffold(
        backgroundColor: Tema.fundo.cor(),
        body: Stack(
          clipBehavior: Clip.none,
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
            Container(
              height: 225,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Tema.primaria.cor(),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).padding.top + 20),
                child: Text(
                  "Resultados",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 75 / 2,
              top: 120,
              child: Container(
                width: MediaQuery.of(context).size.width - 75,
                height: MediaQuery.of(context).size.height - 175,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Tema.fundo.cor(),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Principais inteligências:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Tema.noFundo.cor(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCount,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _listaArray[index].$1.nome,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              FAProgressBar(
                                currentValue: _listaArray[index].$2.toDouble(),
                                displayTextStyle: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  shadows: outlinedText(strokeWidth: 1.5),
                                ),
                                displayText: "%",
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                size: 30,
                                progressColor: dark
                                    ? _listaArray[index].$1.primaryLight()
                                    : _listaArray[index].$1.primaryDark(),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      ),
                      listCount == 3
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CupertinoButton(
                                    onPressed: () {
                                      setState(() {
                                        listCount = 9;
                                      });
                                    },
                                    color: Tema.noFundo.cor(),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text("Ver mais"),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        indent: 25,
                        endIndent: 25,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Principais carreiras:",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.inter(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Tema.noFundo.cor(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      listaCarreiras(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).padding.top + 10,
                horizontal: 15,
              ),
              child: IconButton(
                onPressed: () async {
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Symbols.close,
                  size: 30,
                ),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static List<Shadow> outlinedText(
      {double strokeWidth = 2,
      Color strokeColor = Colors.black,
      int precision = 5}) {
    Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for (int y = 1; y < strokeWidth + precision; y++) {
        double offsetX = x.toDouble();
        double offsetY = y.toDouble();
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
      }
    }
    return result.toList();
  }

  ListView listaCarreiras() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 3,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  construirLista(_listaArray[index].$1)[0].$1.nome,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  carreirasDB
                      .child(
                        "${construirLista(_listaArray[index].$1)[0].$1.name}/desc",
                      )
                      .value as String,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Tema.noFundo.cor(),
                    ),
                    children: [
                      TextSpan(
                        text: '\nSalário:',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' de ${carreirasDB.child(
                              "${construirLista(_listaArray[index].$1)[0].$1.name}/salario/min",
                            ).value} até ${carreirasDB.child(
                              "${construirLista(_listaArray[index].$1)[0].$1.name}/salario/max",
                            ).value} \n\n',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'Carga Horária: ',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: carreirasDB
                            .child(
                              "${construirLista(_listaArray[index].$1)[0].$1.name}/cargaHoraria",
                            )
                            .value as String,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  construirLista(_listaArray[index].$1)[1].$1.nome,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  carreirasDB
                      .child(
                        "${construirLista(_listaArray[index].$1)[1].$1.name}/desc",
                      )
                      .value as String,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Tema.noFundo.cor(),
                    ),
                    children: [
                      TextSpan(
                        text: '\nSalário:',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: ' de ${carreirasDB.child(
                              "${construirLista(_listaArray[index].$1)[1].$1.name}/salario/min",
                            ).value} até ${carreirasDB.child(
                              "${construirLista(_listaArray[index].$1)[1].$1.name}/salario/max",
                            ).value} \n\n',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                      TextSpan(
                        text: 'Carga Horária: ',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: carreirasDB
                            .child(
                              "${construirLista(_listaArray[index].$1)[1].$1.name}/cargaHoraria",
                            )
                            .value as String,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            /*Text(
               construirLista(_listaArray[index].$1)[0].$1.nome,
             ),
             Text(
               construirLista(_listaArray[index].$1)[1].$1.nome,
             ),*/
          ],
        );
      },
    );
  }
}

double calcularPorcentagem(num min, num max, num current) {
  final num totalRange = max - min;
  final double umPrcnt = totalRange / 100;

  final num currentRange = current - min;
  final double porcentagem = currentRange / umPrcnt;

  return porcentagem;
}
