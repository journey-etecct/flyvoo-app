import 'package:boxicons/boxicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';

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

typedef Porcentagem = double;

enum Area {
  naturalista("Naturalista", FontAwesomeIcons.tree),
  logicoMat("Logico-Matemática", FontAwesomeIcons.squareRootVariable),
  existencial("Existencial", Boxicons.bxs_brain),
  intrapessoal("Intrapessoal", FontAwesomeIcons.person),
  linguistica("Linguística", Symbols.translate),
  corporalCin("Corporal-cinestética", Symbols.sports_tennis),
  interpessoal("Interpessoal", FontAwesomeIcons.peopleCarryBox),
  musical("Musical", FontAwesomeIcons.headphonesSimple),
  espacial("Espacial", Symbols.globe);

  const Area(this.nome, this.icone);
  final String nome;
  final IconData icone;

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
  medicina("Medicina", [
    (Area.interpessoal, 40),
    (Area.naturalista, 40),
    (Area.logicoMat, 20),
  ]),
  pedagogia("Pedagogia", [
    (Area.interpessoal, 60),
    (Area.linguistica, 30),
    (Area.existencial, 10),
  ]),
  financas("Finanças", [
    (Area.logicoMat, 85),
    (Area.interpessoal, 15),
  ]),
  marketing("Marketing", [
    (Area.interpessoal, 40),
    (Area.linguistica, 30),
    (Area.espacial, 30),
  ]),
  psicologia("Psicologia", [
    (Area.interpessoal, 40),
    (Area.existencial, 35),
    (Area.intrapessoal, 25),
  ]),
  direito("Direito", [
    (Area.linguistica, 60),
    (Area.interpessoal, 20),
    (Area.logicoMat, 20),
  ]),
  cienciaCom("Ciência da Computação", [
    (Area.logicoMat, 70),
    (Area.espacial, 30),
  ]),
  engenhariaCiv("Engenharia Civil", [
    (Area.logicoMat, 50),
    (Area.espacial, 50),
  ]),
  nutricao("Nutrição", [
    (Area.naturalista, 40),
    (Area.interpessoal, 35),
    (Area.corporalCin, 25),
  ]),
  turismo("Turismo", [
    (Area.espacial, 30),
    (Area.naturalista, 30),
    (Area.linguistica, 20),
    (Area.interpessoal, 20),
  ]),
  odontologia("Odontologia", [
    (Area.naturalista, 40),
    (Area.interpessoal, 35),
    (Area.corporalCin, 25),
  ]),
  cinema("Cinema", [
    (Area.existencial, 35),
    (Area.interpessoal, 30),
    (Area.intrapessoal, 25),
    (Area.musical, 10),
  ]),
  letras("Letras", [
    (Area.linguistica, 70),
    (Area.intrapessoal, 30),
  ]),
  relacoesPub("Relações Públicas", [
    (Area.interpessoal, 70),
    (Area.linguistica, 30),
  ]),
  designGra("Design gráfico", [
    (Area.espacial, 60),
    (Area.interpessoal, 20),
    (Area.musical, 20),
  ]),
  jornalismo("Jornalismo", [
    (Area.linguistica, 50),
    (Area.interpessoal, 50),
  ]),
  medicinaVet("Medicina Veterinária", [
    (Area.naturalista, 60),
    (Area.interpessoal, 40),
  ]),
  bioquimica("Bioquimica", [
    (Area.naturalista, 80),
    (Area.logicoMat, 20),
  ]),
  biofisica("Biofisica", [
    (Area.naturalista, 40),
    (Area.logicoMat, 30),
    (Area.existencial, 20),
    (Area.espacial, 10),
  ]),
  meteorologia("Meteorologia", [
    (Area.naturalista, 60),
    (Area.espacial, 30),
    (Area.linguistica, 10),
  ]),
  biomedicina("Biomedicina", [
    (Area.naturalista, 40),
    (Area.logicoMat, 35),
    (Area.interpessoal, 25),
  ]),
  cienciasBio("Ciências Biológicas", [
    (Area.naturalista, 50),
    (Area.logicoMat, 30),
    (Area.existencial, 20),
  ]),
  enfermagem("Enfermagem", [
    (Area.interpessoal, 60),
    (Area.naturalista, 30),
    (Area.linguistica, 10),
  ]),
  estetica("Estetica", [
    (Area.interpessoal, 50),
    (Area.naturalista, 30),
    (Area.espacial, 20),
  ]),
  educacaoFis("Educação Física", [
    (Area.corporalCin, 80),
    (Area.naturalista, 10),
    (Area.interpessoal, 10),
  ]),
  farmacia("Farmácia", [
    (Area.naturalista, 60),
    (Area.logicoMat, 20),
    (Area.interpessoal, 20),
  ]),
  fisioterapia("Fisioterapia", [
    (Area.corporalCin, 60),
    (Area.interpessoal, 28),
    (Area.naturalista, 12),
  ]),
  quiropraxia("Quiropraxia", [
    (Area.corporalCin, 50),
    (Area.interpessoal, 30),
    (Area.naturalista, 20),
  ]),
  biotecnologia("Biotecnologia", [
    (Area.naturalista, 70),
    (Area.logicoMat, 30),
  ]),
  arquitetura("Arquitetura e Urbanismo", [
    (Area.espacial, 70),
    (Area.logicoMat, 30),
  ]),
  ecologia("Ecologia", [
    (Area.naturalista, 100),
  ]),
  agronomia("Agronomia", [
    (Area.naturalista, 50),
    (Area.espacial, 30),
    (Area.corporalCin, 20),
  ]),
  geologia("Geologia", [
    (Area.naturalista, 70),
    (Area.espacial, 30),
  ]),
  oceanografia("Oceanografia", [
    (Area.naturalista, 80),
    (Area.existencial, 20),
  ]),
  fonoaudiologia("Fonoaudiologia", [
    (Area.linguistica, 50),
    (Area.musical, 20),
    (Area.interpessoal, 15),
    (Area.corporalCin, 15),
  ]),
  engenhariaAer("Engenharia Aeronáutica", [
    (Area.logicoMat, 40),
    (Area.espacial, 40),
    (Area.naturalista, 20),
  ]),
  engenhariaEle("Engenharia Elétrica", [
    (Area.logicoMat, 60),
    (Area.naturalista, 30),
    (Area.espacial, 10),
  ]),
  astronomia("Astrologia", [
    (Area.naturalista, 50),
    (Area.existencial, 40),
    (Area.espacial, 10),
  ]),
  musicoterapia("Musicoterapia", [
    (Area.musical, 40),
    (Area.interpessoal, 30),
    (Area.linguistica, 20),
    (Area.intrapessoal, 10),
  ]),
  engenhariaMec("Engenharia Mecânica", [
    (Area.logicoMat, 40),
    (Area.espacial, 40),
    (Area.corporalCin, 20),
  ]),
  estatistica("Estatística", [
    (Area.logicoMat, 80),
    (Area.intrapessoal, 20),
  ]),
  geofisica("Geofisica", [
    (Area.naturalista, 50),
    (Area.espacial, 30),
    (Area.existencial, 20),
  ]),
  logistica("Logística", [
    (Area.logicoMat, 80),
    (Area.espacial, 20),
  ]),
  tecnologiaInf("Tecnologia da Informação", [
    (Area.logicoMat, 100),
  ]),
  filosofia("Filosofia", [
    (Area.existencial, 60),
    (Area.intrapessoal, 20),
    (Area.interpessoal, 15),
    (Area.linguistica, 5),
  ]),
  historia("História", [
    (Area.existencial, 40),
    (Area.intrapessoal, 20),
    (Area.interpessoal, 20),
    (Area.linguistica, 20),
  ]),
  sociologia("Sociologia", [
    (Area.interpessoal, 40),
    (Area.existencial, 40),
    (Area.intrapessoal, 10),
    (Area.linguistica, 10),
  ]),
  teologia("Teologia", [
    (Area.existencial, 50),
    (Area.intrapessoal, 35),
    (Area.linguistica, 15),
  ]),
  cienciaPol("Ciência Política", [
    (Area.interpessoal, 40),
    (Area.existencial, 35),
    (Area.linguistica, 15),
  ]),
  administracao("Administração", [
    (Area.logicoMat, 80),
    (Area.interpessoal, 20),
  ]),
  biblioteconomia("Biblioteconomia", [
    (Area.linguistica, 80),
    (Area.intrapessoal, 10),
    (Area.espacial, 10),
  ]),
  contabilidade("Contabilidade", [
    (Area.logicoMat, 100),
  ]),
  eventos("Eventos", [
    (Area.interpessoal, 80),
    (Area.espacial, 20),
  ]),
  publicidade("Publicidade e Propaganda", [
    (Area.interpessoal, 50),
    (Area.espacial, 35),
    (Area.musical, 15),
  ]),
  recursosHum("Recursos Humanos", [
    (Area.interpessoal, 70),
    (Area.logicoMat, 30),
  ]),
  segurancaTra("Segurança no Trabalho", [
    (Area.interpessoal, 50),
    (Area.espacial, 30),
    (Area.corporalCin, 20),
  ]),
  artesCen("Artes Cênicas", [
    (Area.intrapessoal, 30),
    (Area.corporalCin, 30),
    (Area.espacial, 20),
    (Area.interpessoal, 20),
  ]),
  artesPla("Artes Plásticas", [
    (Area.intrapessoal, 30),
    (Area.espacial, 30),
    (Area.existencial, 25),
    (Area.musical, 15),
  ]),
  danca("Dança", [
    (Area.corporalCin, 50),
    (Area.interpessoal, 20),
    (Area.intrapessoal, 20),
    (Area.corporalCin, 10),
  ]),
  designJog("Design de Jogos", [
    (Area.intrapessoal, 35),
    (Area.logicoMat, 30),
    (Area.espacial, 25),
    (Area.musical, 10),
  ]),
  designMod("Design de Moda", [
    (Area.interpessoal, 35),
    (Area.intrapessoal, 30),
    (Area.musical, 20),
    (Area.espacial, 15),
  ]),
  designInt("Design de Interiores", [
    (Area.espacial, 80),
    (Area.intrapessoal, 20),
  ]),
  zootecnia("Zootecnia", [
    (Area.naturalista, 80),
    (Area.intrapessoal, 20),
  ]),
  analistaDad("Analista de Dados", [
    (Area.logicoMat, 100),
  ]),
  secretariado("Secretariado", [
    (Area.logicoMat, 70),
    (Area.interpessoal, 30),
  ]),
  biologo("Biólogo", [
    (Area.naturalista, 100),
  ]),
  fisico("Físico", [
    (Area.logicoMat, 50),
    (Area.naturalista, 35),
    (Area.existencial, 15),
  ]),
  quimico("Químico", [
    (Area.naturalista, 50),
    (Area.logicoMat, 50),
  ]),
  matematica("Matemática", [
    (Area.logicoMat, 100),
  ]),
  escritor("Escritor", [
    (Area.linguistica, 50),
    (Area.intrapessoal, 50),
  ]),
  dublagem("Dublagem", [
    (Area.corporalCin, 40),
    (Area.musical, 40),
    (Area.interpessoal, 20),
  ]);

  const Carreira(this.nome, this.inteligencias);
  final String nome;
  final List<(Area, Porcentagem)> inteligencias;
}
