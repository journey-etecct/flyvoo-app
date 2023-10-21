import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

class Doacoes extends StatelessWidget {
  const Doacoes({super.key});

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
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Text(
                  "DOAÇÕES - CHAVE PIX",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Tema.noFundo.cor(),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Image.asset(
                  dark
                      ? "assets/imagens/pix_dark.png"
                      : "assets/imagens/pix_light.png",
                ),
                const SizedBox(
                  height: 15,
                ),
                Theme(
                  data: ThemeData.from(
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: const Color(0xff1E3C87),
                      brightness: dark ? Brightness.dark : Brightness.light,
                    ),
                    useMaterial3: true,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        const ClipboardData(
                          text:
                              "00020126770014BR.GOV.BCB.PIX0128journeycompany2023@gmail.com0223agradecemos sua doação!5204000053039865802BR5920Danilo Carvalho Lima6009SAO PAULO61080540900062250521XGNbrBtjrAltS1i1gow7n6304A08D",
                        ),
                      );
                      if (!context.mounted) return;
                      Flushbar(
                        margin: const EdgeInsets.all(20),
                        borderRadius: BorderRadius.circular(50),
                        message: "Copiado!",
                        duration: const Duration(seconds: 5),
                      ).show(context);
                    },
                    icon: const Icon(Symbols.content_copy),
                    label: const Text("Copiar chave"),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
