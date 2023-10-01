import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:material_symbols_icons/symbols.dart';

class SemInternet extends StatefulWidget {
  const SemInternet({super.key});

  @override
  State<SemInternet> createState() => _SemInternetState();
}

class _SemInternetState extends State<SemInternet> {
  @override
  void initState() {
    super.initState();
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          Navigator.pop(context);
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.wifi_off_rounded,
                    color: Tema.texto.cor(),
                    size: 100,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Você está offline",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Tema.texto.cor(),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      "Conecte-se à internet para continuar sua jornada!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w200,
                        color: Tema.texto.cor(),
                        letterSpacing: -0.41,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
