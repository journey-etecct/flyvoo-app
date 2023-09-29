// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 3,
      itemBuilder: (context, indexTeorico, indexReal) => Especialidade(
        index: indexReal,
      ),
      options: CarouselOptions(
        height: double.infinity,
        enlargeCenterPage: true,
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
          "Lógica",
          style: GoogleFonts.inter(
            fontSize: 28,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
          ),
        ),
        Text(
          "Nível 1",
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.41,
          ),
        ),
        SvgPicture.asset("assets/imagens/logica.svg"),
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
                color: const Color(0xffF81B50).withOpacity(
                  0.5,
                ),
              ),
            ],
          ),
          child: CupertinoButton(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
              color: const Color(0xffF81B50),
              borderRadius: BorderRadius.circular(50),
              onPressed: () {},
              child: Text(
                "INICIAR",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.white,
                ),
              )),
        ),
      ],
    );
  }
}
