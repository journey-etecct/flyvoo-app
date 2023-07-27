// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flyvoo/home/mais/central_de_ajuda/data.dart' show data;

(String, dynamic)? _selecionado;

class CentralDeAjuda extends StatefulWidget {
  const CentralDeAjuda({super.key});

  @override
  State<CentralDeAjuda> createState() => _CentralDeAjudaState();
}

class _CentralDeAjudaState extends State<CentralDeAjuda> {
  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: "pp68RJNStZM",
    flags: YoutubePlayerFlags(
      autoPlay: true,
      hideControls: false,
    ),
  );

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
                    child: Column(
                      children: [
                        Text(
                          "Central de Ajuda",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: tema["texto"],
                          ),
                        ),
                        Text(
                          "Como podemos te ajudar?",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: tema["texto"],
                          ),
                        ),
                        Theme(
                          data: ThemeData.from(
                            colorScheme: ColorScheme.fromSeed(
                              seedColor: tema["texto"]!,
                              brightness:
                                  dark ? Brightness.dark : Brightness.light,
                            ),
                            useMaterial3: true,
                          ),
                          child: SearchBar(),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: player,
                        ),
                        Text(
                          "Perguntas Frequentes",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: tema["texto"],
                            fontSize: 24,
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selecionado = data[index];
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
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: -0.41,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      AnimatedRotation(
                                        duration: Duration(seconds: 1),
                                        turns: 0.25,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Symbols.arrow_forward_ios),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              data[index].$2.runtimeType != String
                                  ? Text(
                                      data[index].$2.toString(),
                                    )
                                  : AnimatedSize(
                                      duration: Duration(seconds: 1),
                                      child: Text(
                                        data[index].$2,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
