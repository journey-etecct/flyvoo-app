// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/mais/minha_conta/editar_perfil.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class MinhaConta extends StatefulWidget {
  const MinhaConta({super.key});

  @override
  State<MinhaConta> createState() => _MinhaContaState();
}

class _MinhaContaState extends State<MinhaConta> {
  final _txtMensagem1 = TextEditingController();
  final _txtMensagem2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: tema["fundo"],
      child: SafeArea(
        child: Scaffold(
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
                        height: 40,
                      ),
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
                        height: 180,
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: ClipOval(
                                child: Image(
                                  width: 100,
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    userFlyvoo!.photoURL!,
                                  ),
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
                                    userFlyvoo!.displayName!,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.inter(
                                      color: tema["texto"],
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      userFlyvoo!.email!,
                                      style: GoogleFonts.inter(
                                        color: tema["texto"],
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
                                      34,
                                      0,
                                      34,
                                      0,
                                    ),
                                    child: OpenContainer(
                                      transitionDuration: const Duration(
                                        milliseconds: 500,
                                      ),
                                      closedColor: CupertinoColors.systemPink,
                                      closedShape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      tappable: false,
                                      closedBuilder: (context, action) => Align(
                                        alignment: Alignment.bottomCenter,
                                        child: CupertinoButton(
                                          color: Colors.transparent,
                                          onPressed: () {
                                            action.call();
                                          },
                                          padding: const EdgeInsets.fromLTRB(
                                            23,
                                            5,
                                            23,
                                            5,
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
                                      openColor: tema["fundo"]!,
                                      openBuilder: (context, retorno) =>
                                          const EditarPerfil(),
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
                                  color: tema["texto"],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Expanded(
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
                                final retorno = await Navigator.pushNamed(
                                    context, "/home/alterarSenha");
                                if ((retorno as bool?) ?? false) {
                                  if (!mounted) return;
                                  showDialog(
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
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text(
                                              "OK",
                                              style: GoogleFonts.inter(
                                                color:
                                                    CupertinoColors.systemBlue,
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
                                margin:
                                    const EdgeInsets.fromLTRB(25, 15, 25, 15),
                                child: Row(
                                  children: [
                                    Text(
                                      "Alterar senha",
                                      style: GoogleFonts.inter(
                                        color: tema["texto"],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    Image.asset(
                                      "assets/icons/seta2.png",
                                      color: tema["texto"],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      password ?? false
                          ? Divider(
                              height: 2,
                              color: tema["texto"]!.withOpacity(0.5),
                            )
                          : const SizedBox(),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/home/termosdeuso",
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            children: [
                              Text(
                                "Termos de Uso",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Expanded(
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
                      Divider(
                        height: 2,
                        color: tema["texto"]!.withOpacity(0.5),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/home/politica",
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            children: [
                              Text(
                                "Política de Privacidade",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Expanded(
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
                      Divider(
                        height: 2,
                        color: tema["texto"]!.withOpacity(0.5),
                      ),
                      InkWell(
                        onTap: () async {
                          final resposta = await showDialog(
                            context: context,
                            builder: (context) => BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 2,
                                sigmaY: 2,
                              ),
                              child: alertaFeedback(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          child: Row(
                            children: [
                              Text(
                                "Nos dê um feedback!",
                                style: GoogleFonts.inter(
                                  color: tema["texto"],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                              const Expanded(
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
                      Divider(
                        height: 2,
                        color: tema["texto"]!.withOpacity(0.5),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          "/excluirConta",
                        ),
                        onLongPress: () => Navigator.pushNamed(
                          context,
                          "/excluirConta/feedback",
                        ), // TODO: deletar no modo release
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                          width: double.infinity,
                          child: Text(
                            "Excluir minha conta",
                            style: GoogleFonts.inter(
                              color: dark
                                  ? const Color(0xffFF545E)
                                  : const Color(0xffF81B50),
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
        ),
      ),
    );
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
            seedColor: tema["texto"]!,
          ),
          useMaterial3: true,
        ),
        child: AlertDialog(
          title: Text("Muito obrigado!"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "A equipe inteira do Journey agradece seu tempo para nos dar uma nota🥰\nPara começar, o que você está achando do app até agora?",
              ),
              TextField(
                controller: _txtMensagem1,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Escreva aqui...",
                ),
              ),
              Text("Agora sobre "),
              TextField(
                controller: _txtMensagem2,
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Escreva aqui...",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SlideUpRoute extends PageRouteBuilder {
  final Widget page;
  SlideUpRoute(this.page)
      : super(
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
                curve: Curves.fastOutSlowIn,
                reverseCurve: Curves.fastEaseInToSlowEaseOut,
              ),
            ),
            child: child,
          ),
        );
}
