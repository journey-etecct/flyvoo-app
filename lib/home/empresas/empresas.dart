// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class Empresas extends StatefulWidget {
  const Empresas({super.key});

  @override
  State<Empresas> createState() => _EmpresasState();
}

class _EmpresasState extends State<Empresas> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Empresas",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
            color: tema["texto"],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: tema["botaoIndex"],
                      child: Icon(PixelArtIcons.bullseye_arrow),
                    ),
                  ),
                ],
              ),
            ),
            shrinkWrap: true,
            itemCount: 50,
          ),
        ),
      ],
    );
  }
}
