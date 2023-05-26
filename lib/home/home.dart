// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/empresas/empresas.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/principal/principal.dart';
import 'package:flyvoo/home/univcursos/univcursos.dart';
import 'package:flyvoo/main.dart';

List<Widget> telasHome = [Principal(), UnivCursos(), Empresas(), Mais()];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late int indexHome;
  late AnimationController _index0;
  late Animation<double> _anim0;
  late AnimationController _index1;
  late Animation<double> _anim1;
  late AnimationController _index2;
  late Animation<double> _anim2;
  late AnimationController _index3;
  late Animation<double> _anim3;
  bool _reverse = false;

  @override
  void initState() {
    indexHome = 0;

    _index0 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    _anim0 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(CurvedAnimation(parent: _index0, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    _index0.value = 60;
    _index1 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    _anim1 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(CurvedAnimation(parent: _index1, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    _index2 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    _anim2 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(CurvedAnimation(parent: _index2, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    _index3 = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 100,
      ),
    );
    _anim3 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(CurvedAnimation(parent: _index3, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _index0.dispose();
    _index1.dispose();
    _index2.dispose();
    _index3.dispose();
    super.dispose();
  }

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
              Container(
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
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
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
                            splashColor: Colors.transparent,
                            onTap: () {
                              _index0.forward();
                              _index1.reset();
                              _index2.reset();
                              _index3.reset();
                              setState(() {
                                indexHome = 0;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: indexHome == 0
                                        ? tema["terciaria"]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: _anim0.value,
                                  height: _anim0.value,
                                ),
                                Image.asset(
                                  "assets/icons/inicial.png",
                                  scale: 1.2,
                                  color: indexHome == 0
                                      ? tema["secundaria"]
                                      : tema["noFundo"],
                                ),
                              ],
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
                              _index0.reset();
                              _index1.forward();
                              _index2.reset();
                              _index3.reset();
                              setState(() {
                                indexHome = 1;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: indexHome == 1
                                        ? tema["terciaria"]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: _anim1.value,
                                  height: _anim1.value,
                                ),
                                Image.asset(
                                  "assets/icons/univcursos.png",
                                  scale: 1.2,
                                  color: indexHome == 1
                                      ? tema["secundaria"]
                                      : tema["noFundo"],
                                ),
                              ],
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
                              _index0.reset();
                              _index1.reset();
                              _index2.forward();
                              _index3.reset();
                              setState(() {
                                indexHome = 2;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: indexHome == 2
                                        ? tema["terciaria"]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: _anim2.value,
                                  height: _anim2.value,
                                ),
                                Image.asset(
                                  "assets/icons/empresas.png",
                                  scale: 1.2,
                                  color: indexHome == 2
                                      ? tema["secundaria"]
                                      : tema["noFundo"],
                                ),
                              ],
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
                              _index0.reset();
                              _index1.reset();
                              _index2.reset();
                              _index3.forward();
                              setState(() {
                                indexHome = 3;
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: indexHome == 3
                                        ? tema["terciaria"]
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: _anim3.value,
                                  height: _anim3.value,
                                ),
                                Image.asset(
                                  "assets/icons/mais.png",
                                  scale: 1.2,
                                  color: indexHome == 3
                                      ? tema["secundaria"]
                                      : tema["noFundo"],
                                ),
                              ],
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
                    height: 91,
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
                  Expanded(
                    child: PageTransitionSwitcher(
                      reverse: _reverse,
                      transitionBuilder: (
                        Widget child,
                        Animation<double> primaryAnimation,
                        Animation<double> secondaryAnimation,
                      ) {
                        return SharedAxisTransition(
                          fillColor: Colors.transparent,
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.horizontal,
                          child: child,
                        );
                      },
                      child: telasHome[indexHome],
                    ), // TODO: conteúdo
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
