// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
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
  final List<(Area, num)> _listaArray = [];

  _init() {
    for (Area area in resultados.keys) {
      _listaArray.add((area, resultados[area]!));
    }
    _listaArray.sort((a, b) => (a.$2 - b.$2).toInt());
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
    return Scaffold(
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
              padding: EdgeInsets.all(MediaQuery.of(context).padding.top + 20),
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
                    itemCount: 3,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _listaArray[index].$1.nome,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          FAProgressBar(
                            currentValue: _listaArray[index].$2.toDouble(),
                            displayTextStyle: GoogleFonts.inter(
                              color: Tema.noFundo.cor(),
                              fontWeight: FontWeight.w600,
                            ),
                            backgroundColor: Colors.grey.withOpacity(0.2),
                            size: 20,
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
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            construirLista(_listaArray[index].$1).first.$1.nome,
                          ),
                          Text(
                            construirLista(_listaArray[index].$1)[1].$1.nome,
                          ),
                        ],
                      );
                    },
                  ),
                ],
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
    );
  }
}
