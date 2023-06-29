// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';

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
              Column(
                children: [
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
                    height: 165,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Image.asset(
                            "assets/imagens/user.png", // TODO: imagem do usuário
                            color: tema["texto"],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                dark
                                    ? "Jongkook Casabranca"
                                    : "Mamila Castanha", // TODO: nome
                                style: TextStyle(
                                  color: tema["texto"],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "MamilaCastanha@gmail.com", // TODO: email
                                  style: TextStyle(
                                    color: tema["texto"],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CupertinoButton(
                                color: CupertinoColors.systemPink,
                                onPressed: () {
                                  // TODO: editar perfil
                                },
                                padding: EdgeInsets.fromLTRB(23, 5, 23, 5),
                                child: Text(
                                  "Editar perfil",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
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
                            style: TextStyle(
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
