import 'package:another_flushbar/flushbar.dart';
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
List<List<dynamic>> _listaPessoas = [
  [
    const AssetImage("assets/imagens/pessoas/camila.webp"),
    "Camila Vitória",
    "PESQUISA E DESIGN",
  ],
  [
    const AssetImage("assets/imagens/pessoas/daniel.webp"),
    "Daniel Alves",
    "DESIGN E DESENVOLVIMENTO"
  ],
  [
    const AssetImage("assets/imagens/pessoas/danilo.webp"),
    "Danilo Lima",
    "CEO \u2022 DESIGN E DESENVOLVIMENTO"
  ],
  [
    const AssetImage("assets/imagens/pessoas/felipe.webp"),
    "Felipe Araújo",
    "DESIGN E DESENVOLVIMENTO"
  ],
  [
    const AssetImage("assets/imagens/pessoas/guilherme.webp"),
    "Guilherme Barbosa",
    "PESQUISA E DESIGN"
  ],
  [
    const AssetImage("assets/imagens/pessoas/juliana.webp"),
    "Juliana Leal",
    "PESQUISA"
  ],
  [
    const AssetImage("assets/imagens/pessoas/paulo.webp"),
    "Paulo Henrique",
    "PESQUISA"
  ],
  [
    const AssetImage("assets/imagens/pessoas/rafael.webp"),
    "Rafael Lucílio",
    "PESQUISA E DESIGN"
  ],
  [
    const AssetImage("assets/imagens/pessoas/robson.webp"),
    "Robson Dias",
    "DESIGN E DESENVOLVIMENTO"
  ],
  [
    const AssetImage("assets/imagens/pessoas/ryan.webp"),
    "Ryan Silva",
    "DESIGN",
  ],
];

class _SobreOFlyvooState extends State<SobreOFlyvoo> {
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
      backgroundColor: Tema.fundo.cor(),
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
                        height: 55,
                      ),
                      Text(
                        "Sobre o aplicativo",
                        style: GoogleFonts.inter(
                          color: Tema.texto.cor(),
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
                          color: Tema.texto.cor(),
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
                    color: Tema.texto.cor(),
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
                          _listaPessoas[index][0],
                          _listaPessoas[index][1],
                          _listaPessoas[index][2],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Divider(
                        color: Tema.texto.cor().withOpacity(0.5),
                      ),
                    ],
                  ),
                  itemCount: _listaPessoas.length,
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
                    "Graças a todos os envolvidos, esse projeto foi possível\u2764",
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: PhysicalModel(
            color: nome == _listaPessoas[2][1]
                ? Tema.primaria.cor().withOpacity(dark ? 0.2 : 0.5)
                : Tema.texto.cor().withOpacity(dark ? 0.2 : 0.5),
            shape: BoxShape.circle,
            child: ClipOval(
              child: Image(
                image: img,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
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
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
