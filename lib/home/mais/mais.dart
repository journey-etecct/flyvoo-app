import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emailjs/emailjs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/mais/central_de_ajuda/central_de_ajuda.dart';
import 'package:flyvoo/home/mais/minha_conta/minha_conta.dart';
import 'package:flyvoo/home/mais/pub_key_ejs.dart';
import 'package:flyvoo/home/mais/sobre_o_flyvoo/sobre_o_flyvoo.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool? password;

class Mais extends StatefulWidget {
  const Mais({super.key});

  @override
  State<Mais> createState() => _MaisState();
}

class _MaisState extends State<Mais> {
  List<String> botoes = ["Minha Conta", "Central de Ajuda", "Sobre o Flyvoo"];
  final _keyImg = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    EmailJS.init(
      Options(
        publicKey: pubKey[0],
        privateKey: pubKey[1],
      ),
    );
  }

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
              ClipOval(
                child: userFlyvoo != null
                    ? FadeInImage(
                        key: _keyImg,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 100),
                        fadeOutDuration: const Duration(milliseconds: 100),
                        placeholder: const AssetImage(
                          "assets/background/loading.gif",
                        ),
                        image: CachedNetworkImageProvider(
                          userFlyvoo!.photoURL!,
                        ),
                      )
                    : Image.asset(
                        "assets/icons/user.png",
                        color: tema["texto"],
                      ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  userFlyvoo != null ? userFlyvoo!.displayName! : "Usuário",
                  style: GoogleFonts.inter(
                    color: tema["texto"],
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
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
                  "textoSecundario": dark
                      ? const Color(0xffd8d8d8)
                      : const Color(0xff404040).withOpacity(0.77),
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
        Expanded(
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
                    itemBuilder: (context, index) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                          child: OpenContainer(
                            openBuilder: (context, action) {
                              switch (index) {
                                case 0:
                                  return const MinhaConta();
                                case 1:
                                  return const CentralDeAjuda();
                                default:
                                  return const SobreOFlyvoo();
                              }
                            },
                            closedColor: tema["botao"]!,
                            closedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onClosed: (data) => setState(() {}),
                            tappable: false,
                            openColor: tema["fundo"]!,
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            closedBuilder: (context, action) => SizedBox(
                              width: double.infinity,
                              child: CupertinoButton(
                                onPressed: () async {
                                  switch (index) {
                                    case 0:
                                      if (userFlyvoo == null) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => BackdropFilter(
                                            filter: ImageFilter.blur(
                                              sigmaX: 2,
                                              sigmaY: 2,
                                            ),
                                            child: CupertinoAlertDialog(
                                              content: Text(
                                                "Para acessar isso, você precisa se cadastrar",
                                                style: GoogleFonts.inter(
                                                  fontSize: 18,
                                                ),
                                              ),
                                              actions: [
                                                CupertinoDialogAction(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    "Cancelar",
                                                    style: GoogleFonts.inter(
                                                      color: CupertinoColors
                                                          .systemBlue,
                                                    ),
                                                  ),
                                                ),
                                                CupertinoDialogAction(
                                                  onPressed: () =>
                                                      Navigator.popAndPushNamed(
                                                    context,
                                                    "/login",
                                                  ),
                                                  child: Text(
                                                    "Entrar como usuário",
                                                    style: GoogleFonts.inter(
                                                      color: CupertinoColors
                                                          .systemBlue,
                                                    ),
                                                  ),
                                                ),
                                                CupertinoDialogAction(
                                                  isDefaultAction: true,
                                                  onPressed: () =>
                                                      Navigator.popAndPushNamed(
                                                    context,
                                                    "/opcoesCadastro",
                                                  ),
                                                  child: Text(
                                                    "Criar uma conta",
                                                    style: GoogleFonts.inter(
                                                      color: CupertinoColors
                                                          .systemBlue,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        action.call();
                                      }
                                      break;
                                    case 1:
                                      action.call();
                                      break;
                                    default:
                                      action.call();
                                  }
                                },
                                borderRadius: BorderRadius.circular(15),
                                color: tema["botao"],
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Text(
                                  botoes[index],
                                  style: GoogleFonts.inter(
                                    color: const Color(0xff1E3C87),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    itemCount: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 8, 50, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(15),
                      onPressed: () {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                            child: CupertinoAlertDialog(
                              content: Text(
                                "Tem certeza que deseja sair?",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontSize: 17,
                                ),
                              ),
                              actions: <Widget>[
                                CupertinoButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancelar",
                                    style: GoogleFonts.inter(
                                      color: CupertinoColors.systemBlue,
                                    ),
                                  ),
                                ),
                                CupertinoButton(
                                  onPressed: () async {
                                    final inst =
                                        await SharedPreferences.getInstance();
                                    inst.remove("cadastroTerminado");
                                    await FirebaseAuth.instance.signOut();
                                    setState(() {
                                      userFlyvoo = null;
                                    });
                                    if (!mounted) return;
                                    Navigator.popUntil(
                                      context,
                                      (route) => route.isFirst,
                                    );
                                    Navigator.pushReplacementNamed(
                                      context,
                                      "/index",
                                    );
                                  },
                                  child: Text(
                                    "Sair",
                                    style: GoogleFonts.inter(
                                      color: CupertinoColors.systemPink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      color: const Color(0xffFF545E),
                      child: Text(
                        "Sair",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
