// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/mais/minha_conta/editar_perfil.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class MinhaConta extends StatefulWidget {
  const MinhaConta({super.key});

  @override
  State<MinhaConta> createState() => _MinhaContaState();
}

class _MinhaContaState extends State<MinhaConta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tema["fundo"],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image(
                  image: AssetImage(
                    dark
                        ? "assets/background/esfumadodark.png"
                        : "assets/background/esfumadolight.png",
                  ),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: dark
                          ? Color.fromRGBO(43, 74, 128, 0.5)
                          : Color.fromRGBO(184, 204, 255, 50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(20),
                    height: 180,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipOval(
                            child: Image(
                              width: 100,
                              image: CachedNetworkImageProvider(
                                userFlyvoo!.photoURL!,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                userFlyvoo!.displayName!,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  userFlyvoo!.email!,
                                  style: GoogleFonts.inter(
                                    color: tema["texto"],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  34,
                                  0,
                                  34,
                                  0,
                                ),
                                child: OpenContainer(
                                  transitionDuration: Duration(
                                    milliseconds: 500,
                                  ),
                                  closedColor: CupertinoColors.systemPink,
                                  closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  tappable: false,
                                  closedBuilder: (context, action) => Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CupertinoButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        action.call();
                                      },
                                      padding: EdgeInsets.fromLTRB(
                                        23,
                                        5,
                                        23,
                                        5,
                                      ),
                                      child: Text(
                                        "Editar perfil",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  openColor: tema["fundo"]!,
                                  openBuilder: (context, retorno) =>
                                      EditarPerfil(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        children: [
                          Text(
                            "Configurações Gerais",
                            style: GoogleFonts.inter(
                              color: tema["texto"],
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            "assets/icons/seta2.png",
                            color: tema["texto"],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
