import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

List<BotaoIndex> _botoes = [
  BotaoIndex(
    (null, Symbols.mail_outline_rounded),
    "Continuar com email",
  ),
  BotaoIndex(
    (const AssetImage("assets/icons/email.png"), null),
    "Continuar com Google",
  ),
  BotaoIndex(
    (const AssetImage("assets/icons/user.png"), null),
    "Continuar com Microsoft",
  ),
];

class BotaoIndex {
  final String text;
  final (AssetImage?, IconData?) icon;
  BotaoIndex(this.icon, this.text);
}

class OpcoesDeCadastro extends StatefulWidget {
  const OpcoesDeCadastro({Key? key}) : super(key: key);

  @override
  State<OpcoesDeCadastro> createState() => _OpcoesDeCadastroState();
}

class Tipo {
  final String tipo;
  Tipo(this.tipo);
}

class _OpcoesDeCadastroState extends State<OpcoesDeCadastro> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      _botoes = [
        BotaoIndex(
          (null, Symbols.mail_outline_rounded),
          "Continuar com email",
        ),
        BotaoIndex(
          (const AssetImage("assets/icons/google.png"), null),
          "Continuar com Google",
        ),
        BotaoIndex(
          (const AssetImage("assets/icons/microsoft.png"), null),
          "Continuar com Microsoft",
        ),
      ];
    });
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controllerBG.value.size.width,
                height: controllerBG.value.size.height,
                child: VideoPlayer(controllerBG),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const Expanded(
                  child: Center(
                    child: Text(
                      "Cadastro",
                      style: TextStyle(
                        fontFamily: "Queensides Light",
                        fontSize: 60,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.fromLTRB(60, 0, 60, 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: tema["fundo"],
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                          color: const Color(0xff000000).withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(100),
                      color: tema["botaoIndex"],
                      padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 25,
                          ),
                          _botoes[index].icon.$1 != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image(
                                    image: _botoes[index].icon.$1!,
                                    height: 29,
                                    color: tema["textoBotaoIndex"],
                                  ),
                                )
                              : Icon(
                                  _botoes[index].icon.$2,
                                  size: 30,
                                  color: tema["textoBotaoIndex"],
                                ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            _botoes[index].text,
                            style: GoogleFonts.inter(
                              color: tema["textoBotaoIndex"],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        switch (index) {
                          case 0:
                            Navigator.pushNamed(
                              context,
                              "/opcoesCadastro/email",
                            );
                            break;
                          case 1:
                            Navigator.pushNamed(
                              context,
                              "/cadastro",
                              arguments: "google",
                            );
                            break;
                          default:
                            Navigator.pushNamed(
                              context,
                              "/cadastro",
                              arguments: "microsoft",
                            );
                        }
                      },
                    ),
                  ),
                  itemCount: _botoes.length,
                  shrinkWrap: true,
                ),
                const SizedBox(
                  height: 70,
                ),
                Text.rich(
                  style: GoogleFonts.inter(
                    color: tema["noFundo"],
                  ),
                  TextSpan(
                    text: "Já possui cadastro? ",
                    children: <InlineSpan>[
                      TextSpan(
                        text: "Clique aqui",
                        style: GoogleFonts.inter(
                          color:
                              dark ? tema["primaria"] : tema["textoBotaoIndex"],
                          decoration: TextDecoration.underline,
                          decorationColor:
                              dark ? tema["primaria"] : tema["textoBotaoIndex"],
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(context, "/login");
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
