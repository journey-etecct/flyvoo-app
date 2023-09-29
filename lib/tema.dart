import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

bool dark = SchedulerBinding.instance.platformDispatcher.platformBrightness ==
    Brightness.dark;

enum Tema {
  primaria,
  secundaria,
  terciaria,
  fundo,
  noFundo,
  texto,
  botao,
  textoSecundario,
  botaoIndex,
  textoBotaoIndex;

  Color toColor() {
    switch (this) {
      case Tema.primaria:
        return tema["primaria"]!;
      case Tema.secundaria:
        return tema["primaria"]!;
      case Tema.terciaria:
        return tema["primaria"]!;
      case Tema.fundo:
        return dark ? const Color(0xff252525) : Colors.white;
      case Tema.noFundo:
        return dark ? Colors.white : Colors.black;
      case Tema.texto:
        return dark ? Colors.white : const Color(0xff1E3C87);
      case Tema.botao:
        return dark ? const Color(0xffB8CCFF) : const Color(0xffF0F4FF);
      case Tema.textoSecundario:
        return dark
            ? const Color(0xffd8d8d8)
            : const Color(0xff404040).withOpacity(0.77);
      case Tema.botaoIndex:
        return dark
            ? const Color(0xff00FFD8).withOpacity(0.37)
            : const Color(0xffFFD3BD).withOpacity(0.60);
      case Tema.textoBotaoIndex:
        return dark ? Colors.white : const Color(0xffA93535);
      default:
        return Colors.white;
    }
  }
}

Map<String, List> paletas = {};
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
