// tema do aplicativo
import 'package:flutter/material.dart';

bool dark = false;

Map<String, List> paletas = {
  "paletaVerde": [
    // Cores para Biologia, Química, Saúde
    const Color(0xff00bf63),
    const Color(0xff7ed957),
    const Color(0xffc1ff72),
    const Color(0xffedff59),
  ],
  "paletaLaranja": [
    // Cores para História, Geografia, Filosofia, Sociologia
    const Color(0xffaf5f15),
    const Color(0xffed974e),
    const Color(0xfff4c755),
    const Color(0xfffff24a),
  ],
  "paletaAzul": [
    // Cores para Mat., Pesquisas, Física, Marketing, RH, ADM
    const Color(0xff4974af),
    const Color(0xff49a3cf),
    const Color(0xff6fb1d1),
    const Color(0xff93d6e1),
  ],
  "paletaVermelho": [
    // Cores para Arte, literatura, expressão, teatro, dança, coach
    const Color(0xffd12525),
    const Color(0xfffa5656),
    const Color(0xffff5b5b),
    const Color(0xfff46a7f),
  ],
  "paletaRoxo": [
    // Cores para Abstratas: mente, programação, design
    const Color(0xffb243b0),
    const Color(0xffe855e6),
    const Color(0xffdb64f4),
    const Color(0xffff87ec),
  ]
};
Map<String, Color> tema = {
  "primaria": dark ? const Color(0xff00FFD8) : const Color(0xffFB5607),
  "secundaria": dark ? const Color(0xff31b6b0) : Colors.black,
  "terciaria": dark
      ? const Color(0xff096073)
      : const Color(0xff054BFD).withOpacity(
          0.4,
        ),
  "fundo": dark ? const Color(0xff252525) : Colors.white,
  "noFundo": dark ? Colors.white : Colors.black,
  "texto": dark ? Colors.white : const Color(0xff1E3C87),
  "botao": dark ? const Color(0xffB8CCFF) : const Color(0xffF0F4FF),
  "textoSecundario": dark
      ? const Color(0xffd8d8d8)
      : const Color(0xff404040).withOpacity(0.77),
  "botaoIndex": dark
      ? const Color(0xff00FFD8).withOpacity(0.37)
      : const Color(0xffFFD3BD).withOpacity(0.60),
  "textoBotaoIndex": dark ? Colors.white : const Color(0xffA93535),
};
// fim do tema do aplicativo
