// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

Areas areaAtual = Areas.logicoMat;

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Future _init() async {
    OneSignal.initialize("8ae86c8a-3e2e-4ca6-b474-ef5c641a0e22");
    if (!OneSignal.Notifications.permission) {
      await OneSignal.Notifications.requestPermission(true);
    }
    debugPrint(
      "permissão de notificação: ${OneSignal.Notifications.permission}",
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
    Areas.corporalCin;
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
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            areaAtual = Areas.values[index];
          });
          debugPrint(Areas.values[index].toString());
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
          Areas.values[index].nome,
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        SvgPicture.asset(
          "assets/imagens/areas/${Areas.values[index].name}.svg",
          height: 400,
        ),
        RatingBar(
          onRatingUpdate: (value) {},
          glow: false,
          allowHalfRating: false,
          ignoreGestures: true,
          itemCount: 3,
          ratingWidget: RatingWidget(
            full: Icon(
              Symbols.star_rounded,
              fill: 1,
            ),
            half: Icon(
              Symbols.star_rounded,
              fill: 1,
            ),
            empty: Icon(
              Symbols.star_rounded,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "0%",
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
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
                    ? Areas.values[index].primaryDark().withOpacity(
                          0.5,
                        )
                    : Areas.values[index].primaryLight().withOpacity(
                          0.5,
                        ),
              ),
            ],
          ),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            color: dark
                ? Areas.values[index].primaryDark()
                : Areas.values[index].primaryLight(),
            borderRadius: BorderRadius.circular(50),
            onPressed: () {},
            child: Text(
              'VER MAIS',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            /* Text(
                "INICIAR",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ), */
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
    Key? key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: 800,
    ),
  }) : super(key: key);

  @override
  State<FadeIndexedStack> createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}
