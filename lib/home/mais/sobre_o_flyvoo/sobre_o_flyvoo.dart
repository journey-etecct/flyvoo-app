import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SobreOFlyvoo extends StatefulWidget {
  const SobreOFlyvoo({super.key});

  @override
  State<SobreOFlyvoo> createState() => _SobreOFlyvooState();
}

String versao = "...";
String nversao = "...";
String id = "...";

class _SobreOFlyvooState extends State<SobreOFlyvoo> {
  List<List<dynamic>> listaPessoas = [
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 1",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição",
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 2",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 3",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 4",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 5",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 6",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 7",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 8",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 9",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
    [
      const AssetImage("assets/icons/user.png"),
      "Pessoa 10",
      "descriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescriçãodescrição"
    ],
  ];

  _pegarInfoApp() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      versao = info.version;
      nversao = info.buildNumber;
      id = info.packageName;
    });
  }

  @override
  void initState() {
    super.initState();
    _pegarInfoApp();
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
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Sobre o aplicativo",
                        style: GoogleFonts.inter(
                          color: tema["texto"],
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Versão instalada",
                              style: TextStyle(
                                fontFamily: "Sometype",
                                color: dark
                                    ? const Color(0xFFA3A3A3)
                                    : const Color(0xFF7D7D7D),
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Text(
                            "$versao ($nversao)",
                            style: TextStyle(
                              fontFamily: "Sometype",
                              color: dark
                                  ? const Color(0xFFA3A3A3)
                                  : const Color(0xFF7D7D7D),
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          id,
                          style: TextStyle(
                            fontFamily: "Sometype",
                            color: dark
                                ? const Color(0xFFA3A3A3)
                                : const Color(0xFF7D7D7D),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "© ${DateTime.now().year} Journey\nTodos os direitos reservados",
                          style: TextStyle(
                            height: 1.1,
                            fontFamily: "Sometype",
                            color: dark
                                ? const Color(0xFFA3A3A3)
                                : const Color(0xFF7D7D7D),
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Theme(
                          data: ThemeData.from(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: const Color(0xff1E3C87),
                              brightness:
                                  dark ? Brightness.dark : Brightness.light,
                            ),
                            useMaterial3: true,
                          ),
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              await Clipboard.setData(
                                ClipboardData(
                                  text:
                                      "Versão instalada: $versao ($nversao), ID do aplicativo: $id",
                                ),
                              );
                              if (!mounted) return;
                              Flushbar(
                                margin: const EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(50),
                                message: "Copiado!",
                                duration: const Duration(seconds: 5),
                              ).show(context);
                            },
                            icon: const Icon(Symbols.content_copy),
                            label: const Text("Copiar"),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "O que é o Flyvoo?",
                        style: GoogleFonts.inter(
                          color: tema["texto"],
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Construído com Flutter, Firebase, café e muito amor, o aplicativo Flyvoo é uma ferramenta de utilidade pública para a aplicação do usuário na carreira de seu interesse sem precisar se preocupar com mudança de interesses e falsas esperanças do mercado de trabalho. Nossa missão é facilitar ao máximo a conexão pessoa-carreira com base no seu apetite profissional e assim criar um ambiente de conforto e controle sobre suas opções de trabalho/curso.",
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          letterSpacing: -0.41,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Equipe do Journey",
                  style: GoogleFonts.inter(
                    color: tema["texto"],
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: PessoaInfo(
                          listaPessoas[index][0],
                          listaPessoas[index][1],
                          listaPessoas[index][2],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: tema["texto"]!.withOpacity(0.5),
                      ),
                    ],
                  ),
                  itemCount: listaPessoas.length,
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 23,
                    right: 23,
                    bottom: 30,
                  ),
                  child: Text(
                    "Graças a todos os envolvidos, esse projeto foi possível${String.fromCharCode(0x2764)}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      height: 1.1,
                      letterSpacing: -0.41,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PessoaInfo extends StatelessWidget {
  final AssetImage img;
  final String nome;
  final String desc;
  const PessoaInfo(this.img, this.nome, this.desc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Image(
            image: img,
            color: tema["texto"],
            width: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                nome,
                style: GoogleFonts.inter(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                desc,
                maxLines: 2,
                style: GoogleFonts.inter(
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CupertinoButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                        child: CupertinoAlertDialog(
                          title: Column(
                            children: [
                              Image(
                                image: img,
                                fit: BoxFit.cover,
                                color: tema["texto"],
                                width: 150,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(nome),
                            ],
                          ),
                          content: Text(desc),
                          actions: [
                            CupertinoDialogAction(
                              isDefaultAction: true,
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
                  },
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  color: tema["texto"],
                  child: Text(
                    "Ver mais",
                    style: GoogleFonts.inter(
                      color: tema["fundo"],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
