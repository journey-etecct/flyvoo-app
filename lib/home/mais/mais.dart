// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                ? Color.fromRGBO(43, 74, 128, 0.5)
                : Color.fromRGBO(184, 204, 255, 50),
            borderRadius: BorderRadius.circular(15),
          ),
          width: double.infinity,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          height: 150,
          child: Row(
            children: [
              Image.asset(
                "assets/imagens/user.png",
                color: tema["texto"],
              ),
              SizedBox(
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
        SizedBox(
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
                  SizedBox(
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
                      activeColor: Color(0xff1E3C87),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: tema["texto"],
        ),
        Flexible(
          flex: 12,
          child: Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 210,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                      child: CupertinoButton(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MinhaConta(),
                                ),
                              );
                              break;
                            case 1:
                              // TODO: tela central de ajuda
                              break;
                            default:
                            // TODO: tela sobre o flyvoo
                          }
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
                                child: Text(
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
                                },
                                child: Text(
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
                      color: Color(0xffFF545E),
                      child: Text(
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
      ],
    );
  }
}
