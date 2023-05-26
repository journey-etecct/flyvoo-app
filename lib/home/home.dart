// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

int indexHome = 0;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tema["fundo"],
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: tema["fundo"],
          body: Stack(
            children: [
              PreferredSize(
                preferredSize: Size(double.infinity, 91),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: dark
                            ? Color.fromARGB(255, 18, 18, 18)
                            : Colors.transparent,
                        blurRadius: 100,
                        spreadRadius: 100,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: InkWell(
                            onTap: () {
                              debugPrint("aa");
                            },
                            child: Image.asset(
                              "assets/icons/inicial.png",
                              scale: 1.2,
                              color: tema["noFundo"],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: InkWell(
                            onTap: () {
                              debugPrint("aa");
                            },
                            child: Image.asset(
                              "assets/icons/empresas.png",
                              scale: 1,
                              color: tema["noFundo"],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: InkWell(
                            onTap: () {
                              debugPrint("aa");
                            },
                            child: Image.asset(
                              "assets/icons/univcursos.png",
                              scale: 1.2,
                              color: tema["noFundo"],
                            ),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: InkWell(
                            onTap: () {
                              debugPrint("aa");
                            },
                            child: Image.asset(
                              "assets/icons/mais.png",
                              scale: 1.2,
                              color: tema["noFundo"],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: dark ? 91 : 0,
                  ),
                  Expanded(
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
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 91,
                  ),
                  Expanded(child: Placeholder()) // TODO: conteúdo
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
