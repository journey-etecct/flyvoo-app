// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/home/mais/minha_conta/minha_conta.dart';
import 'package:flyvoo/main.dart';

class Mais extends StatefulWidget {
  const Mais({super.key});

  @override
  State<Mais> createState() => _MaisState();
}

class _MaisState extends State<Mais> {
  List<String> botoes = ["Minha Conta", "Central de Ajuda", "Sobre o Flyvoo"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: dark
                ? const Color.fromRGBO(43, 74, 128, 0.5)
                : const Color.fromRGBO(184, 204, 255, 50),
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          height: 150,
          child: Row(
            children: [
              Image.asset(
                "assets/imagens/user.png",
                color: tema["texto"],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  dark ? "Jongkook Casabranca" : "Mamila Castanha",
                  style: TextStyle(
                    color: tema["texto"],
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        /* SizedBox(
          height: 80,
          child: InkWell(
            onTap: () {
              setState(() {
                dark = !dark;
                tema = {
                  "primaria":
                      dark ? const Color(0xff00FFD8) : const Color(0xffFB5607),
                  "secundaria": dark ? const Color(0xff31b6b0) : Colors.black,
                  "terciaria": dark
                      ? const Color(0xff096073)
                      : const Color(0xff054BFD).withOpacity(
                          0.4,
                        ),
                  "fundo": dark ? const Color(0xff252525) : Colors.white,
                  "noFundo": dark ? Colors.white : Colors.black,
                  "texto": dark ? Colors.white : const Color(0xff1E3C87),
                  "botao":
                      dark ? const Color(0xffB8CCFF) : const Color(0xffF0F4FF),
                };
                notifier.value = dark ? Brightness.dark : Brightness.light;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icons/lua.png",
                    color: tema["texto"],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Modo escuro",
                        style: TextStyle(
                          color: tema["texto"],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoSwitch(
                      value: dark,
                      onChanged: (value) {
                        setState(() {
                          dark = value;
                          tema = {
                            "primaria": dark
                                ? const Color(0xff00FFD8)
                                : const Color(0xffFB5607),
                            "secundaria":
                                dark ? const Color(0xff31b6b0) : Colors.black,
                            "terciaria": dark
                                ? const Color(0xff096073)
                                : const Color(0xff054BFD).withOpacity(
                                    0.4,
                                  ),
                            "fundo":
                                dark ? const Color(0xff252525) : Colors.white,
                            "noFundo": dark ? Colors.white : Colors.black,
                            "texto":
                                dark ? Colors.white : const Color(0xff1E3C87),
                            "botao": dark
                                ? const Color(0xffB8CCFF)
                                : const Color(0xffF0F4FF),
                          };
                          notifier.value =
                              dark ? Brightness.dark : Brightness.light;
                        });
                      },
                      activeColor: const Color(0xff1E3C87),
                    ),
                  )
                ],
              ),
            ),
          ),
        ), */
        Flexible(
          flex: 12,
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                      child: OpenContainer(
                        openBuilder: (context, action) {
                          switch (index) {
                            case 0:
                              return MinhaConta(botoes[index]);

                            case 1:
                              return MinhaConta(botoes[index]);
                            default:
                              return MinhaConta(botoes[index]);
                          }
                        },
                        closedColor: tema["botao"]!,
                        closedShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        openColor: tema["fundo"]!,
                        transitionDuration: Duration(milliseconds: 500),
                        closedBuilder: (context, action) => CupertinoButton(
                          onPressed: () {
                            action.call();
                          },
                          borderRadius: BorderRadius.circular(15),
                          color: tema["botao"],
                          child: Text(
                            botoes[index],
                            style: TextStyle(
                              color: const Color(0xff1E3C87),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    itemCount: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(15),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                            content: Text(
                              "Tem certeza que deseja sair?",
                              style: TextStyle(
                                color: tema["texto"],
                                fontSize: 18,
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Cancelar",
                                  style: TextStyle(
                                    color: CupertinoColors.systemBlue,
                                  ),
                                ),
                              ),
                              CupertinoButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  SystemNavigator.pop();
                                },
                                child: const Text(
                                  "Sair",
                                  style: TextStyle(
                                    color: CupertinoColors.systemPink,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      color: const Color(0xffFF545E),
                      child: const Text(
                        "Sair",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
