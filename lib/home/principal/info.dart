// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

BackdropFilter alertaVerMais(BuildContext context, Area area) {
  List<Carreira> carreirasDessaArea = <Carreira>[];
  construirLista() {
    carreirasDessaArea = [];
    for (Carreira carreira in Carreira.values) {
      for ((Area, Porcentagem) inteligencia in carreira.inteligencias) {
        if (inteligencia.$1 == area) {
          carreirasDessaArea.add(carreira);
          break;
        }
      }
    }

    return carreirasDessaArea;
  }

  return BackdropFilter(
    filter: ColorFilter.mode(
      Colors.black.withOpacity(0.2),
      BlendMode.darken,
    ),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Text(
              "Informações da Inteligência",
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: GoogleFonts.inter(
                color: Tema.texto.cor(),
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const BouncingScrollPhysics(),
              children: construirLista().map<Widget>((e) {
                return Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e.nome,
                                    ),
                                    Text('Nessa área:'),
                                    FAProgressBar(),
                                  ],
                                ),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 2,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: Icon(Symbols.arrow_back_ios),
                                iconSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      e != carreirasDessaArea.last
                          ? Divider(
                              color: Tema.noFundo.cor(),
                            )
                          : SizedBox(),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ),
  );
}
