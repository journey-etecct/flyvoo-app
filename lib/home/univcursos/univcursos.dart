import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UnivCursos extends StatefulWidget {
  const UnivCursos({super.key});

  @override
  State<UnivCursos> createState() => _UnivCursosState();
}

class _UnivCursosState extends State<UnivCursos> {
  late Future<DataSnapshot> _getCursos;

  @override
  void initState() {
    super.initState();
    _getCursos = FirebaseDatabase.instance.ref("/cursos/").get();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Cursos",
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
          child: FutureBuilder(
            future: _getCursos,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                final snapshotData = snapshot.data!;

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardCursos(
                      snapshotData.children.toList()[index].key == "Zootecnia",
                      snapshotData.children.toList()[index],
                    );
                  },
                  shrinkWrap: true,
                  itemCount: snapshotData.children.length,
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Tema.texto.cor(),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

class CardCursos extends StatefulWidget {
  final bool isLast;
  final DataSnapshot data;

  const CardCursos(
    this.isLast,
    this.data, {
    super.key,
  });

  @override
  State<CardCursos> createState() => _CardCursosState();
}

String _faculdadesToString(Map faculdades) {
  String stringFinal = "";

  if (faculdades["IFSP"] != null) {
    if (stringFinal == "") {
      stringFinal += "IFSP";
    } else {
      stringFinal += ", IFSP";
    }
  }
  if (faculdades['SPTech'] != null) {
    if (stringFinal == "") {
      stringFinal += "SPTech";
    } else {
      stringFinal += ", SPTech";
    }
  }
  if (faculdades['UNESP'] != null) {
    if (stringFinal == "") {
      stringFinal += "UNESP";
    } else {
      stringFinal += ", UNESP";
    }
  }
  if (faculdades['UNIFESP'] != null) {
    if (stringFinal == "") {
      stringFinal += "UNIFESP";
    } else {
      stringFinal += ", UNIFESP";
    }
  }
  if (faculdades['USP'] != null) {
    if (stringFinal == "") {
      stringFinal += "USP";
    } else {
      stringFinal += ", USP";
    }
  }
  if (faculdades["Universidade Cruzeiro do Sul"] != null) {
    if (stringFinal == "") {
      stringFinal += "Universidade Cruzeiro do Sul";
    } else {
      stringFinal += ", Universidade Cruzeiro do Sul";
    }
  }

  return stringFinal;
}

String _pegarImagemFaculdade(Map faculdades) {
  if (faculdades["USP"] != null) {
    return "assets/imagens/faculdades/usp.webp";
  } else if (faculdades["Universidade Cruzeiro do Sul"] != null) {
    return "assets/imagens/faculdades/ucs.webp";
  } else if (faculdades["UNIFESP"] != null) {
    return "assets/imagens/faculdades/unifesp.webp";
  } else if (faculdades["IFSP"] != null) {
    return "assets/imagens/faculdades/ifsp.webp";
  } else if (faculdades["UNESP"] != null) {
    return "assets/imagens/faculdades/unesp.webp";
  } else {
    return "assets/imagens/faculdades/sptech.webp";
  }
}

class _CardCursosState extends State<CardCursos> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(17.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  _pegarImagemFaculdade(
                    widget.data.child("faculdade(s)").value as Map,
                  ),
                  width: 90,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data.key!,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Tema.texto.cor(),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      _faculdadesToString(
                        widget.data.child("faculdade(s)").value as Map,
                      ),
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inter(
                        color: Tema.texto.cor(),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
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
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => PopupCursos(
                                widget.data.key!,
                                widget.data.child("faculdade(s)").value as Map,
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

class PopupCursos extends StatefulWidget {
  final String nome;
  final Map faculdades;

  const PopupCursos(this.nome, this.faculdades, {super.key});

  @override
  State<PopupCursos> createState() => _PopupCursosState();
}

class _PopupCursosState extends State<PopupCursos> {
  List<Widget> listaFaculdades = [];

  @override
  void initState() {
    super.initState();
    if (widget.faculdades["USP"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(Uri.parse(widget.faculdades["USP"]));
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/usp.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "USP",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.faculdades["UNIFESP"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(Uri.parse(widget.faculdades["UNIFESP"]));
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/unifesp.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "UNIFESP",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.faculdades["SPTech"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(Uri.parse(widget.faculdades["SPTech"]));
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/sptech.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "SPTech",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.faculdades["IFSP"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(Uri.parse(widget.faculdades["IFSP"]));
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/ifsp.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "IFSP",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.faculdades["UNESP"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(Uri.parse(widget.faculdades["UNESP"]));
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/unesp.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "UNESP",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    if (widget.faculdades["Universidade Cruzeiro do Sul"] != null) {
      listaFaculdades.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            splashColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              _launchUrl(
                Uri.parse(widget.faculdades["Universidade Cruzeiro do Sul"]),
              );
            },
            child: SizedBox(
              width:
                  PlatformDispatcher.instance.displays.first.size.width - 400,
              child: Card(
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/imagens/faculdades/ucs.webp",
                        width: 75,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Cruzeiro do Sul",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: dark ? Brightness.dark : Brightness.light,
          ),
        ),
        child: AlertDialog(
          title: Text(
            widget.nome,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Selecione um"),
              ...listaFaculdades,
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
