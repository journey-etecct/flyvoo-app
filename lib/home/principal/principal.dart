import 'package:animations/animations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/home/principal/info.dart';
import 'package:flyvoo/home/principal/teste/resultados.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

int areaAtual = 0;

class Principal extends StatefulWidget {
  final Function(int areaAtual) notificarFundo;
  const Principal(this.notificarFundo, {super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.notificarFundo(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 9,
      itemBuilder: (context, indexTeorico, indexReal) {
        return Especialidade(
          index: indexTeorico,
        );
      },
      options: CarouselOptions(
        height: double.infinity,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          widget.notificarFundo(index + 1);
        },
      ),
    );
  }
}

class Especialidade extends StatelessWidget {
  final int index;
  const Especialidade({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Area.values[index].nome,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Image.asset(
          "assets/imagens/areas/${Area.values[index].name}.webp",
          height: 400,
        ),
        RatingBar(
          onRatingUpdate: (value) {},
          glow: false,
          allowHalfRating: false,
          ignoreGestures: true,
          itemCount: 3,
          ratingWidget: RatingWidget(
            full: const Icon(
              Symbols.star_rounded,
              fill: 1,
            ),
            half: const Icon(
              Symbols.star_rounded,
              fill: 1,
            ),
            empty: const Icon(
              Symbols.star_rounded,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "0%",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, 3),
                color: dark
                    ? Area.values[index].primaryDark().withOpacity(
                          0.5,
                        )
                    : Area.values[index].primaryLight().withOpacity(
                          0.5,
                        ),
              ),
            ],
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            color: dark
                ? Area.values[index].primaryDark()
                : Area.values[index].primaryLight(),
            borderRadius: BorderRadius.circular(50),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Resultados(),
                ),
              );
              /* showCupertinoDialog(
                context: contextHome,
                barrierDismissible: true,
                builder: (context) => AlertaVerMais(
                  Area.values[index],
                ),
              ); */
            },
            child: Text(
              'VER MAIS',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Area.values[index] == Area.intrapessoal && dark
                    ? Colors.black
                    : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: 800,
    ),
  });

  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack> {
  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: widget.duration,
      transitionBuilder: (widget, anim1, anim2) {
        return FadeTransition(
          opacity: anim1,
          child: widget,
        );
      },
      child: IndexedStack(
        index: widget.index,
        key: ValueKey<int>(widget.index),
        children: widget.children,
      ),
    );
  }
}
