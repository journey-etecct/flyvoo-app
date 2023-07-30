// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flyvoo/home/mais/central_de_ajuda/data.dart' show data;

class CentralDeAjuda extends StatefulWidget {
  const CentralDeAjuda({super.key});

  @override
  State<CentralDeAjuda> createState() => _CentralDeAjudaState();
}

class _CentralDeAjudaState extends State<CentralDeAjuda> {
  (String, dynamic, List<String>)? _selecionado;
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "TJAfLE39ZZ8",
    flags: YoutubePlayerFlags(
      autoPlay: !kDebugMode,
      hideControls: false,
      enableCaption: false,
      controlsVisibleAtStart: false,
    ),
  );
  final _txtPesquisa = TextEditingController();

  @override
  void initState() {
    _selecionado = null;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          playedColor: Color(0xff1E3C87),
          handleColor: Color(0xff1E3C87),
        ),
        bottomActions: [
          ProgressBar(
            controller: _controller,
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: Color(0xff1E3C87),
              handleColor: Color(0xff1E3C87),
            ),
          ),
          RemainingDuration(
            controller: _controller,
          ),
          FullScreenButton(
            controller: _controller,
          ),
        ],
      ),
      builder: (context, player) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus!.unfocus();
            setState(() {});
          },
          child: Scaffold(
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
                  physics: BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Central de Ajuda",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 30,
                          color: tema["texto"],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "Como podemos te ajudar?",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: tema["texto"],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Theme(
                          data: ThemeData.from(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: tema["texto"]!,
                              brightness:
                                  dark ? Brightness.dark : Brightness.light,
                            ),
                            useMaterial3: true,
                          ),
                          child: SearchBar(
                            onChanged: (value) => setState(() {}),
                            controller: _txtPesquisa,
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.transparent,
                            ),
                            elevation: MaterialStatePropertyAll(0),
                            hintText: "Pesquisar...",
                            hintStyle: MaterialStatePropertyAll(
                              GoogleFonts.inter(),
                            ),
                            textStyle: MaterialStatePropertyAll(
                              GoogleFonts.inter(),
                            ),
                            leading: Icon(Symbols.search_rounded),
                            shape: MaterialStatePropertyAll(
                              LinearBorder.bottom(
                                side: BorderSide(color: tema["texto"]!),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AnimatedSize(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOutCirc,
                        child: SizedBox(
                          height: _txtPesquisa.text == "" ? null : 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: player,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Perguntas Frequentes",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: tema["texto"],
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      listaFAQ(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _existe(String pesquisa, List<String> data) {
    bool retorno = false;
    pesquisa.split(" ").forEach((element1) {
      for (var element2 in data) {
        if (element2.contains(element1)) {
          retorno = true;
        }
      }
    });
    return retorno;
  }

  ListView listaFAQ() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Column(
        children: _existe(_txtPesquisa.text, data[index].$3) ||
                _txtPesquisa.text == ""
            ? [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (_selecionado == data[index]) {
                        _selecionado = null;
                      } else {
                        _selecionado = data[index];
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      15,
                      20,
                      10,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            data[index].$1,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              color: tema["texto"],
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.41,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        AnimatedRotation(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeOutCirc,
                          turns: _selecionado == data[index] ? 0.75 : 0.25,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (_selecionado == data[index]) {
                                  _selecionado = null;
                                } else {
                                  _selecionado = data[index];
                                }
                              });
                            },
                            icon: Icon(Symbols.arrow_forward_ios),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    0,
                    20,
                    10,
                  ),
                  child: AnimatedSize(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCirc,
                    child: SizedBox(
                      height: _selecionado == data[index] ? null : 0,
                      child: data[index].$2.runtimeType != String
                          ? RichText(
                              text: TextSpan(
                                children:
                                    (data[index].$2 as List).map<InlineSpan>(
                                  (e) {
                                    if (e.runtimeType == String) {
                                      if ((e as String).contains(
                                        "journeycompany2023@gmail.com",
                                      )) {
                                        return TextSpan(
                                          style: GoogleFonts.inter(
                                            color: tema["texto"],
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 18,
                                          ),
                                          text: e,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              launchUrl(
                                                Uri.parse(
                                                  "mailto:journeycompany2023@gmail.com",
                                                ),
                                              );
                                            },
                                        );
                                      } else {
                                        return TextSpan(
                                          style: GoogleFonts.inter(
                                            color: dark
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 17,
                                          ),
                                          text: e,
                                        );
                                      }
                                    } else {
                                      return WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          e,
                                          size: 25,
                                        ),
                                      );
                                    }
                                  },
                                ).toList(),
                              ),
                            )
                          : Text(
                              data[index].$2,
                              style: GoogleFonts.inter(
                                color: dark ? Colors.white : Colors.black,
                                fontSize: 17,
                              ),
                            ),
                    ),
                  ),
                ),
                data[index] != data.last
                    ? Divider(
                        color: tema["texto"]!.withOpacity(0.5),
                        height: 2,
                      )
                    : SizedBox(),
              ]
            : [],
      ),
    );
  }
}
