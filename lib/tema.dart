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

  Color cor() {
    switch (this) {
      case Tema.primaria:
        return tema["primaria"]!;
      case Tema.secundaria:
        return tema["secundaria"]!;
      case Tema.terciaria:
        return tema["terciaria"]!;
      case Tema.fundo:
        return tema["fundo"]!;
      case Tema.noFundo:
        return tema["noFundo"]!;
      case Tema.texto:
        return tema["texto"]!;
      case Tema.botao:
        return tema["botao"]!;
      case Tema.textoSecundario:
        return tema["textoSecundario"]!;
      case Tema.botaoIndex:
        return tema["botaoIndex"]!;
      case Tema.textoBotaoIndex:
        return tema["textoBotaoIndex"]!;
      default:
        return Colors.white;
    }
  }
}

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

enum Area {
  naturalista("Naturalista", []),
  logicoMat("Logico-Matemática", []),
  existencial("Existencial", []),
  intrapessoal("Intrapessoal", []),
  linguistica("Linguística", []),
  corporalCin("Corporal-cinestética", []),
  interpessoal("Interpessoal", []),
  musical("Musical", []),
  espacial("Espacial", []);

  const Area(this.nome, this.carreiras);
  final String nome;
  final List<Carreira> carreiras;

  Color navbar() {
    return switch (this) {
      Area.corporalCin => const Color(0xffFF7D7D),
      Area.espacial => const Color(0xff4A8AEC),
      Area.existencial => const Color(0xffAD44ED),
      Area.interpessoal => const Color(0xffFF6CBC),
      Area.intrapessoal => const Color(0xffFFD600),
      Area.linguistica => const Color(0xffF5C13B),
      Area.logicoMat => const Color(0xff685BFF),
      Area.musical => const Color(0xff24D6C1),
      Area.naturalista => const Color(0xff39C023),
    };
  }

  Color primaryLight() {
    return switch (this) {
      Area.corporalCin => const Color(0xffFF7D7D),
      Area.espacial => const Color(0xff367EED),
      Area.existencial => const Color(0xff942DD3),
      Area.interpessoal => const Color(0xffFF6CBC),
      Area.intrapessoal => const Color(0xffefc900),
      Area.linguistica => const Color(0xffFFA800),
      Area.logicoMat => const Color(0xff3C30CA),
      Area.musical => const Color(0xff27BA8E),
      Area.naturalista => const Color(0xff31B31C),
    };
  }

  Color primaryDark() {
    return switch (this) {
      Area.corporalCin => const Color(0xffFF1879),
      Area.espacial => const Color(0xff1866DE),
      Area.existencial => const Color(0xff8F3BC2),
      Area.interpessoal => const Color(0xffDE328F),
      Area.intrapessoal => const Color(0xffFFE500),
      Area.linguistica => const Color(0xffFFA800),
      Area.logicoMat => const Color(0xff5526B7),
      Area.musical => const Color(0xff0CCFB7),
      Area.naturalista => const Color(0xff39C023),
    };
  }
}

enum Carreira {
  medicina("Medicina"),
  pedagogia("Pedagogia"),
  financas("Finanças"),
  marketing("Marketing"),
  psicologia("Psicologia"),
  direito("Direito"),
  cienciaCom("Ciência da Computação"),
  engenhariaCiv("Engenharia Civil"),
  nutricao("Nutrição"),
  turismo("Turismo"),
  odontologia("Odontologia"),
  cinema("Cinema"),
  letras("Letras"),
  relacoesPub("Relações Públicas"),
  designGra("Design gráfico");

  const Carreira(this.nome);
  final String nome;
}
