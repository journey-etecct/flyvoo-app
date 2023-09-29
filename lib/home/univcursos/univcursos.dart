import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class UnivCursos extends StatefulWidget {
  const UnivCursos({super.key});

  @override
  State<UnivCursos> createState() => _UnivCursosState();
}

class _UnivCursosState extends State<UnivCursos> {
  var list = <Widget>[];

  @override
  void initState() {
    super.initState();
    list = <Widget>[];
    for (var i = 0; i < 20; i++) {
      list.add(
        const Padding(
          padding: EdgeInsets.all(17.0),
          child: CardCursos(),
        ),
      );
      i != 19
          ? list.add(
              Divider(
                color: Tema.texto.toColor(),
              ),
            )
          : list.add(
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 50,
                  top: 30,
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Tema.texto.toColor(),
                  ),
                ),
              ),
            );
    }
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
            color: Tema.texto.toColor(),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  list[index],
                ],
              );
            },
            shrinkWrap: true,
            itemCount: list.length,
          ),
        ),
      ],
    );
  }
}

class CardCursos extends StatelessWidget {
  const CardCursos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(
            "assets/background/loading.gif",
            width: 50,
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
                "Informática Para Internet | Novotec Integrado (Mtec)",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: Tema.texto.toColor(),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "ETEC Cidade Tiradentes",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: Tema.texto.toColor(),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "São Paulo, São Paulo, Brasil(Presencial)",
                textAlign: TextAlign.left,
                style: GoogleFonts.inter(
                  color: Tema.texto.toColor(),
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(
                    Symbols.star_rounded,
                    size: 30,
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Text("Vagas remanescentes"),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
