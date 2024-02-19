import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/empresas/info.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/home/principal/principal.dart';
import 'package:flyvoo/tema.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class Empresas extends StatefulWidget {
  const Empresas({super.key});

  @override
  State<Empresas> createState() => _EmpresasState();
}

class _EmpresasState extends State<Empresas> {
  late DataSnapshot _getCarreiras;

  @override
  void initState() {
    super.initState();
    _getCarreiras = carreirasDB;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Carreiras",
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.41,
            color: Tema.texto.cor(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return CardEmpresas(
                _getCarreiras.children
                        .toList()[index]
                        .child("carreira")
                        .value ==
                    "Zootecnia",
                _getCarreiras.children.toList()[index],
              );
            },
            shrinkWrap: true,
            itemCount: _getCarreiras.children.length,
          ),
          /* ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return list[index];
            },
            shrinkWrap: true,
            itemCount: list.length,
          ), */
        ),
      ],
    );
  }
}

typedef ListaInteligencias = Map;

String _inteligenciasToString(ListaInteligencias inteligencias) {
  String stringFinal = "";

  if (inteligencias["corporalCin"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.corporalCin.nome}";
    } else {
      stringFinal += Area.corporalCin.nome;
    }
  }
  if (inteligencias["espacial"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.espacial.nome}";
    } else {
      stringFinal += Area.espacial.nome;
    }
  }
  if (inteligencias["existencial"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.existencial.nome}";
    } else {
      stringFinal += Area.existencial.nome;
    }
  }
  if (inteligencias["interpessoal"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.interpessoal.nome}";
    } else {
      stringFinal += Area.interpessoal.nome;
    }
  }
  if (inteligencias["intrapessoal"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.intrapessoal.nome}";
    } else {
      stringFinal += Area.intrapessoal.nome;
    }
  }
  if (inteligencias["linguistica"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.linguistica.nome}";
    } else {
      stringFinal += Area.linguistica.nome;
    }
  }
  if (inteligencias["logicoMat"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.logicoMat.nome}";
    } else {
      stringFinal += Area.logicoMat.nome;
    }
  }
  if (inteligencias["musical"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.musical.nome}";
    } else {
      stringFinal += Area.musical.nome;
    }
  }
  if (inteligencias["naturalista"] != null) {
    if (stringFinal != "") {
      stringFinal += ", ${Area.naturalista.nome}";
    } else {
      stringFinal += Area.naturalista.nome;
    }
  }

  return stringFinal;
}

class CardEmpresas extends StatefulWidget {
  final DataSnapshot data;
  final bool isLast;

  const CardEmpresas(
    this.isLast,
    this.data, {
    super.key,
  });

  @override
  State<CardEmpresas> createState() => _CardEmpresasState();
}

class _CardEmpresasState extends State<CardEmpresas> {
  Area _pegarMaiorInteligencia(Carreira carreira) {
    return carreira.inteligencias.first.$1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              switch (_pegarMaiorInteligencia(
                Carreira.values.byName(widget.data.key!),
              )) {
                Area.existencial ||
                Area.linguistica ||
                Area.corporalCin ||
                Area.espacial =>
                  Icon(
                    _pegarMaiorInteligencia(
                      Carreira.values.byName(widget.data.key!),
                    ).icone,
                    size: 80,
                    color: Tema.texto.cor(),
                  ),
                _ => FaIcon(
                    _pegarMaiorInteligencia(
                      Carreira.values.byName(widget.data.key!),
                    ).icone,
                    size: 80,
                    color: Tema.texto.cor(),
                  ),
              },
              const SizedBox(
                width: 25,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.child("carreira").value as String,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Tema.texto.cor(),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _inteligenciasToString(
                        widget.data.child("inteligencia").value as Map,
                      ),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Tema.texto.cor(),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                          color: Tema.texto.cor(),
                          borderRadius: BorderRadius.circular(50),
                          onPressed: () {
                            setState(() {
                              carreiraSelecionada = Carreira.values.byName(
                                widget.data.key!,
                              );
                            });
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => AlertaVerMais(
                                _pegarMaiorInteligencia(
                                  Carreira.values.byName(widget.data.key!),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'VER MAIS',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Tema.fundo.cor(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        !widget.isLast
            ? Divider(
                color: Tema.noFundo.cor(),
              )
            : const SizedBox(),
      ],
    );
  }
}
