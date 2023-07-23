// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigGerais extends StatefulWidget {
  const ConfigGerais({super.key});

  @override
  State<ConfigGerais> createState() => _ConfigGeraisState();
}

class _ConfigGeraisState extends State<ConfigGerais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
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
          SizedBox.expand(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    "Configurações Gerais",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        dark = !dark;
                        Theme.of(context).textTheme.apply();
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
                          "textoSecundario": dark
                              ? const Color(0xffd8d8d8)
                              : const Color(0xff404040).withOpacity(0.77),
                        };
                        notifier.value =
                            dark ? Brightness.dark : Brightness.light;
                        buildTheme(notifier.value);
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
                                style: GoogleFonts.inter(
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
                                  Theme.of(context).textTheme.apply();
                                  tema = {
                                    "primaria": dark
                                        ? const Color(0xff00FFD8)
                                        : const Color(0xffFB5607),
                                    "secundaria": dark
                                        ? const Color(0xff31b6b0)
                                        : Colors.black,
                                    "terciaria": dark
                                        ? const Color(0xff096073)
                                        : const Color(0xff054BFD).withOpacity(
                                            0.4,
                                          ),
                                    "fundo": dark
                                        ? const Color(0xff252525)
                                        : Colors.white,
                                    "noFundo":
                                        dark ? Colors.white : Colors.black,
                                    "texto": dark
                                        ? Colors.white
                                        : const Color(0xff1E3C87),
                                    "botao": dark
                                        ? const Color(0xffB8CCFF)
                                        : const Color(0xffF0F4FF),
                                    "textoSecundario": dark
                                        ? const Color(0xffd8d8d8)
                                        : const Color(0xff404040)
                                            .withOpacity(0.77),
                                  };
                                  notifier.value =
                                      dark ? Brightness.dark : Brightness.light;
                                  buildTheme(notifier.value);
                                });
                              },
                              activeColor: const Color(0xff1E3C87),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(0, 5),
                    color: const Color(
                      0xff000000,
                    ).withOpacity(0.25),
                  ),
                ],
              ),
              height: 43,
              width: 129,
              margin: const EdgeInsets.only(
                bottom: 50,
              ),
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Text(
                  "Voltar",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
