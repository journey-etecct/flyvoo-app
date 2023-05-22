// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 90),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              height: 90,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Material(
                        color: Colors.black,
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
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Material(
                        color: Colors.black,
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
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Material(
                        color: Colors.black,
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
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Material(
                        color: Colors.black,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
