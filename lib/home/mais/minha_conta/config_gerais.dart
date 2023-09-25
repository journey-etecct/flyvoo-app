import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _notificacoes = true;
bool _som = true;
bool _vibracao = true;
bool _animcoes = true;
late SharedPreferences instS;

class ConfigGerais extends StatefulWidget {
  const ConfigGerais({super.key});

  @override
  State<ConfigGerais> createState() => _ConfigGeraisState();
}

class _ConfigGeraisState extends State<ConfigGerais> {
  _setDark(dark) async {
    final inst = await SharedPreferences.getInstance();
    inst.setBool("dark", dark);
  }

  _shp() async {
    instS = await SharedPreferences.getInstance();
    setState(() {
      _notificacoes = instS.getBool("notificacoes") ?? true;
      _som = instS.getBool("som") ?? true;
      _vibracao = instS.getBool("vibracao") ?? true;
      _animcoes = instS.getBool("animacoes") ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    _shp();
  }

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
                const SizedBox(
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
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: () async {
                      await instS.setBool("notificacoes", !_notificacoes);
                      setState(() {
                        _notificacoes = !_notificacoes;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Icon(
                            Symbols.notifications_rounded,
                            size: 30,
                            color: tema["texto"],
                            fill: 1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Notificações",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: _notificacoes,
                              onChanged: (value) async {
                                await instS.setBool("notificacoes", value);
                                setState(() {
                                  _notificacoes = value;
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
                Divider(
                  height: 2,
                  color: tema["texto"]!.withOpacity(0.5),
                ),
                SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: _notificacoes
                        ? () async {
                            await instS.setBool("som", !_som);
                            setState(() {
                              _som = !_som;
                            });
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 30, 0),
                      child: Row(
                        children: [
                          Icon(
                            Symbols.volume_up_rounded,
                            size: 30,
                            color: _notificacoes ? tema["texto"] : Colors.grey,
                            fill: 1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Som",
                                style: GoogleFonts.inter(
                                  color: _notificacoes
                                      ? tema["texto"]
                                      : Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: _som,
                              onChanged: _notificacoes
                                  ? (value) async {
                                      await instS.setBool("som", value);
                                      setState(() {
                                        _som = value;
                                      });
                                    }
                                  : null,
                              activeColor: const Color(0xff1E3C87),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  color: tema["texto"]!.withOpacity(0.5),
                ),
                SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: _notificacoes
                        ? () async {
                            await instS.setBool("vibracao", !_vibracao);
                            setState(() {
                              _vibracao = !_vibracao;
                            });
                          }
                        : null,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(60, 0, 30, 0),
                      child: Row(
                        children: [
                          Icon(
                            Symbols.vibration_rounded,
                            size: 30,
                            color: _notificacoes ? tema["texto"] : Colors.grey,
                            fill: 1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Vibração",
                                style: GoogleFonts.inter(
                                  color: _notificacoes
                                      ? tema["texto"]
                                      : Colors.grey,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: _vibracao,
                              onChanged: _notificacoes
                                  ? (value) async {
                                      await instS.setBool("vibracao", value);
                                      setState(() {
                                        _vibracao = value;
                                      });
                                    }
                                  : null,
                              activeColor: const Color(0xff1E3C87),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  color: tema["texto"]!.withOpacity(0.5),
                ),
                SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        dark = !dark;
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
                          "botaoIndex": dark
                              ? const Color(0xff00FFD8).withOpacity(0.37)
                              : const Color(0xffFFD3BD).withOpacity(0.60),
                          "textoBotaoIndex":
                              dark ? Colors.white : const Color(0xffA93535),
                        };
                        notifier.value =
                            dark ? Brightness.dark : Brightness.light;
                        _setDark(dark);
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
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
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
                                    "botaoIndex": dark
                                        ? const Color(0xff00FFD8)
                                            .withOpacity(0.37)
                                        : const Color(0xffFFD3BD)
                                            .withOpacity(0.60),
                                    "textoBotaoIndex": dark
                                        ? Colors.white
                                        : const Color(0xffA93535),
                                  };
                                  notifier.value =
                                      dark ? Brightness.dark : Brightness.light;
                                  _setDark(dark);
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
                Divider(
                  height: 2,
                  color: tema["texto"]!.withOpacity(0.5),
                ),
                SizedBox(
                  height: 60,
                  child: InkWell(
                    onTap: () async {
                      await instS.setBool("animacoes", !_animcoes);
                      setState(() {
                        _animcoes = !_animcoes;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Animações de fundo",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CupertinoSwitch(
                              value: _animcoes,
                              onChanged: (value) async {
                                await instS.setBool("animacoes", value);
                                setState(() {
                                  _animcoes = value;
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
                onPressed: () => Navigator.pop(context),
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
