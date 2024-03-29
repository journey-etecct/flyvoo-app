import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emailjs/emailjs.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/mais/minha_conta/editar_perfil.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../principal/teste/resultados.dart';

final _txtMensagem1 = TextEditingController();
final _txtMensagem2 = TextEditingController();
double? _nota;
bool feedbackEnviado = false;
late Future<DataSnapshot> _userInfo;
int _step = 0;
bool _reversed = false;
List<String> _listaBotao = [
  "Próximo",
  "Próximo",
  "ENVIAR",
];
List<String> _listaBotaoCancelar = [
  "Cancelar",
  "Voltar",
  "Voltar",
];

bool fezTeste = false;
bool jaPegouFezTeste = false;

class MinhaConta extends StatefulWidget {
  const MinhaConta({super.key});

  @override
  State<MinhaConta> createState() => _MinhaContaState();
}

class _MinhaContaState extends State<MinhaConta> {
  List<Widget> lista = [
    const Tela1(),
    const Tela2(),
    const Tela3(),
  ];

  @override
  void initState() {
    super.initState();

    if (userFlyvoo != null) {
      _userInfo = FirebaseDatabase.instance.ref("users/${userFlyvoo!.uid}").get();
    } else {
      _userInfo = FirebaseDatabase.instance.ref("users/").get();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.cor(),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image(
              image: AssetImage(
                dark ? "assets/background/esfumadodark.png" : "assets/background/esfumadolight.png",
              ),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: OverflowBox(
              maxHeight: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top + 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: dark
                          ? const Color.fromRGBO(43, 74, 128, 0.5)
                          : const Color.fromRGBO(184, 204, 255, 50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    height: 180,
                    child: Row(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipOval(
                            child: userFlyvoo != null
                                ? FadeInImage(
                                    width: 100,
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
                                    width: 100,
                                    color: Tema.texto.cor(),
                                  ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                userFlyvoo != null ? userFlyvoo!.displayName! : "Usuário anônimo",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Tema.texto.cor(),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  userFlyvoo != null ? userFlyvoo!.providerData.first.email! : "",
                                  style: GoogleFonts.inter(
                                    color: Tema.texto.cor(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  30,
                                  0,
                                  30,
                                  0,
                                ),
                                child: OpenContainer(
                                  transitionDuration: const Duration(
                                    milliseconds: 500,
                                  ),
                                  closedColor: CupertinoColors.systemPink,
                                  closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  tappable: false,
                                  onClosed: (data) => setState(() {}),
                                  closedBuilder: (context, action) => Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CupertinoButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        if (userFlyvoo != null) {
                                          action.call();
                                        } else {
                                          alertaLogin(context);
                                        }
                                      },
                                      padding: const EdgeInsets.only(
                                        top: 0,
                                        bottom: 0,
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
                                  openColor: Tema.fundo.cor(),
                                  openBuilder: (context, retorno) => const EditarPerfil(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        "/home/configGerais",
                      );
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        children: [
                          Text(
                            "Configurações Gerais",
                            style: GoogleFonts.inter(
                              color: Tema.texto.cor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            "assets/icons/seta2.png",
                            color: Tema.texto.cor(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  fezTeste
                      ? Divider(
                          height: 2,
                          color: Tema.texto.cor().withOpacity(0.5),
                        )
                      : const SizedBox(),
                  fezTeste
                      ? InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const Resultados(),
                              ),
                            );

                            setState(() {});
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Row(
                              children: [
                                Text(
                                  "Meus resultados",
                                  style: GoogleFonts.inter(
                                    color: Tema.texto.cor(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Image.asset(
                                  "assets/icons/seta2.png",
                                  color: Tema.texto.cor(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Segurança e Privacidade",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  password ?? false
                      ? InkWell(
                          onTap: () async {
                            final retorno =
                                await Navigator.pushNamed(context, "/home/alterarSenha");
                            if ((retorno as bool?) ?? false) {
                              if (!context.mounted) return;
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 2,
                                    sigmaY: 2,
                                  ),
                                  child: CupertinoAlertDialog(
                                    content: Text(
                                      "Senha alterada com sucesso",
                                      style: GoogleFonts.inter(
                                        fontSize: 16,
                                      ),
                                    ),
                                    actions: [
                                      CupertinoDialogAction(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "OK",
                                          style: GoogleFonts.inter(
                                            color: CupertinoColors.systemBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                            child: Row(
                              children: [
                                Text(
                                  "Alterar senha",
                                  style: GoogleFonts.inter(
                                    color: Tema.texto.cor(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox(),
                                ),
                                Image.asset(
                                  "assets/icons/seta2.png",
                                  color: Tema.texto.cor(),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  password ?? false
                      ? Divider(
                          height: 2,
                          color: Tema.texto.cor().withOpacity(0.5),
                        )
                      : const SizedBox(),
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        "/home/termosdeuso",
                      );
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        children: [
                          Text(
                            "Termos de Uso",
                            style: GoogleFonts.inter(
                              color: Tema.texto.cor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            "assets/icons/seta2.png",
                            color: Tema.texto.cor(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Tema.texto.cor().withOpacity(0.5),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        "/home/politica",
                      );
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          statusBarColor: Colors.transparent,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        children: [
                          Text(
                            "Política de Privacidade",
                            style: GoogleFonts.inter(
                              color: Tema.texto.cor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            "assets/icons/seta2.png",
                            color: Tema.texto.cor(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Tema.texto.cor().withOpacity(0.5),
                  ),
                  !feedbackEnviado ? futureFeedback() : const SizedBox(),
                  InkWell(
                    onTap: () {
                      if (userFlyvoo != null) {
                        Navigator.pushNamed(
                          context,
                          "/excluirConta",
                        );
                      } else {
                        alertaLogin(context);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      width: double.infinity,
                      child: Text(
                        "Excluir minha conta",
                        style: GoogleFonts.inter(
                          color: dark ? const Color(0xffFF545E) : const Color(0xffF81B50),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
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

  FutureBuilder<DataSnapshot> futureFeedback() {
    return FutureBuilder<DataSnapshot>(
        future: _userInfo,
        builder: (context, data) {
          if (data.hasData && data.connectionState == ConnectionState.done) {
            if (data.data!.child("feedback").value == null) {
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      if (userFlyvoo != null) {
                        final resposta = await showCupertinoDialog<bool?>(
                          context: context,
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2,
                              sigmaY: 2,
                            ),
                            child: alertaFeedback(),
                          ),
                        );
                        if (resposta != null && resposta) {
                          if (!context.mounted) return;
                          setState(() {
                            feedbackEnviado = true;
                          });
                          Flushbar(
                            duration: const Duration(seconds: 5),
                            margin: const EdgeInsets.all(20),
                            borderRadius: BorderRadius.circular(50),
                            message: "Feedback enviado com sucesso!",
                          ).show(context);
                        }
                      } else {
                        if (!mounted) return;
                        alertaLogin(context);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        children: [
                          Text(
                            "Nos dê um feedback!",
                            style: GoogleFonts.inter(
                              color: Tema.texto.cor(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Image.asset(
                            "assets/icons/seta2.png",
                            color: Tema.texto.cor(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 2,
                    color: Tema.texto.cor().withOpacity(0.5),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        });
  }

  String _formatarNome(String nome) {
    return nome.replaceRange(4, null, "************");
  }

  GestureDetector alertaFeedback() {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: Theme(
        data: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Tema.texto.cor(),
            brightness: dark ? Brightness.dark : Brightness.light,
          ),
          useMaterial3: true,
        ),
        child: StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text("Muito obrigado pelo feedback!"),
            content: PageTransitionSwitcher(
              reverse: _reversed,
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
              child: lista[_step],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  switch (_step) {
                    case 0:
                      _txtMensagem1.text = "";
                      _txtMensagem2.text = "";
                      Navigator.pop(context);
                      break;
                    case 1:
                      setState(() {
                        _reversed = true;
                        --_step;
                      });
                      break;
                    default:
                      setState(() {
                        _reversed = true;
                        --_step;
                      });
                  }
                },
                child: Text(
                  _listaBotaoCancelar[_step],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  switch (_step) {
                    case 0:
                      if (_txtMensagem1.text != "") {
                        setState(() {
                          _reversed = false;
                          ++_step;
                        });
                      }
                      break;
                    case 1:
                      if (_txtMensagem2.text != "") {
                        setState(() {
                          _reversed = false;
                          ++_step;
                        });
                      }
                      break;
                    default:
                      if (_nota != null) {
                        Navigator.pop<bool>(context, true);
                        EmailJS.send(
                          "service_4znv29e",
                          "template_xvzp5qu",
                          {
                            "mensagem1": _txtMensagem1.text,
                            "mensagem2": _txtMensagem2.text,
                            "nota": _nota,
                            "nome": _formatarNome(userFlyvoo!.displayName!),
                          },
                        );
                        FirebaseDatabase.instance
                            .ref(
                              "users/${userFlyvoo!.uid}/feedback",
                            )
                            .set(true);
                        setState(() {
                          _userInfo =
                              FirebaseDatabase.instance.ref("users/${userFlyvoo!.uid}").get();
                        });
                      }
                  }
                },
                child: Text(
                  _listaBotao[_step],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class Tela1 extends StatelessWidget {
  const Tela1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "A equipe inteira do Journey agradece seu tempo para nos dar uma nota🥰\nPara começar, o que você está achando do app até agora?",
        ),
        TextField(
          controller: _txtMensagem1,
          minLines: 1,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Escreva aqui...",
          ),
        ),
      ],
    );
  }
}

class Tela2 extends StatelessWidget {
  const Tela2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Se você pudesse mudar alguma coisa no app, o que mudaria ou adicionaria?",
        ),
        TextField(
          controller: _txtMensagem2,
          minLines: 1,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: "Escreva aqui...",
          ),
        ),
      ],
    );
  }
}

class Tela3 extends StatelessWidget {
  const Tela3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Por favor, nos deixe uma nota sobre sua experiência até agora😊",
        ),
        const SizedBox(
          height: 20,
        ),
        RatingBar.builder(
          glow: false,
          tapOnlyMode: true,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const Icon(
                  Symbols.sentiment_very_dissatisfied_rounded,
                  color: Colors.red,
                );
              case 1:
                return const Icon(
                  Symbols.sentiment_dissatisfied_rounded,
                  color: Colors.orange,
                );
              case 2:
                return const Icon(
                  Symbols.sentiment_neutral_rounded,
                  color: Colors.amber,
                );
              case 3:
                return const Icon(
                  Symbols.sentiment_satisfied_rounded,
                  color: Colors.lightGreen,
                );
              default:
                return const Icon(
                  Symbols.sentiment_very_satisfied_rounded,
                  color: Colors.green,
                );
            }
          },
          onRatingUpdate: (valor) {
            _nota = valor;
          },
        ),
      ],
    );
  }
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;

  SlideUpRoute(
    this.page,
  ) : super(
          reverseTransitionDuration: const Duration(milliseconds: 400),
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
                reverseCurve: Curves.fastEaseInToSlowEaseOut,
              ),
            ),
            child: child,
          ),
        );
}
