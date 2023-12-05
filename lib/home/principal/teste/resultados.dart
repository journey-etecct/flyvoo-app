// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    for (Area area in resultados.keys) {
      _listaArray.add((area, resultados[area]!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.cor(),
      body: Stack(
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
                ),
              ),
            ),
          ),
          Positioned(
            left: 75 / 2,
            top: 150,
            child: Container(
              width: MediaQuery.of(context).size.width - 75,
              height: MediaQuery.of(context).size.height - 175,
              decoration: BoxDecoration(
                color: Tema.noFundo.cor(),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Text(
                    "Principais inteligências:",
                    style: GoogleFonts.inter(),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: IconButton(
              onPressed: () async {},
              icon: const Icon(
                Symbols.close,
                size: 30,
              ),
              color: Tema.noFundo.cor(),
            ),
          ),
        ],
      ),
    );
  }
}
