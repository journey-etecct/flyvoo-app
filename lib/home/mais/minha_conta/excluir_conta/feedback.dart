import 'package:emailjs/emailjs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackEC extends StatefulWidget {
  const FeedbackEC({super.key});

  @override
  State<FeedbackEC> createState() => _FeedbackECState();
}

class _FeedbackECState extends State<FeedbackEC> {
  List<String> listaOpcoes = [
    "Já achei o que queria com o app",
    "Não achei o que queria com o app",
    "Está ocupando muita memória",
    "Faltou informações profundas",
    "Achei um outro app melhor",
    "Outro",
  ];
  String? _escolhido;
  bool _btnAtivado = true;
  final _txtMensagem = TextEditingController();

  @override
  void initState() {
    _escolhido = null;
    _btnAtivado = true;
    _txtMensagem.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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
                      ? "assets/background/esfumadodeletedark.png"
                      : "assets/background/esfumadodeletelight.png",
                ),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            CupertinoButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Pular",
                style: GoogleFonts.inter(
                  color: tema["texto"],
                  fontSize: 18,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Text(
                  "Poxa, que pena ;(",
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: dark
                        ? const Color(0xFFFC2828)
                        : const Color(0xFF871E1E),
                  ),
                ),
                Text(
                  "Conte para nós por que está indo embora!",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.41,
                    color: dark ? Colors.white : const Color(0xFF871E1E),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast,
                    ),
                    itemCount: listaOpcoes.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
                      child: Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () {
                              setState(() {
                                _txtMensagem.text = "";
                                _escolhido = listaOpcoes[index];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 11,
                                horizontal: 16,
                              ),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                color: dark
                                    ? tema["fundo"]
                                    : tema["fundo"]!.withOpacity(0.7),
                              ),
                              child: Row(
                                children: [
                                  CupertinoRadio<String>(
                                    inactiveColor: !dark
                                        ? CupertinoColors.systemGrey4
                                        : CupertinoColors.white,
                                    value: listaOpcoes[index],
                                    groupValue: _escolhido,
                                    onChanged: (value) {
                                      setState(() {
                                        _txtMensagem.text = "";
                                        _escolhido = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    listaOpcoes[index],
                                    style: GoogleFonts.inter(
                                      color: dark ? Colors.white : Colors.black,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutCirc,
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                            height: _escolhido == listaOpcoes[index] ? 170 : 0,
                            decoration: ShapeDecoration(
                              color: dark ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: OverflowBox(
                              maxHeight: double.infinity,
                              child: AnimatedOpacity(
                                opacity:
                                    _escolhido == listaOpcoes[index] ? 1 : 0,
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeOutCirc,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Poderia dar mais detalhes?${listaOpcoes[index] != listaOpcoes.last ? " (opcional)" : ""}",
                                      style: GoogleFonts.inter(
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: _txtMensagem,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                            color: tema["texto"]!,
                                          ),
                                        ),
                                      ),
                                      cursorColor: tema["texto"],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(
                    left: 36,
                    right: 36,
                    bottom: 80,
                    top: 10,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: _escolhido != null
                        ? <BoxShadow>[
                            BoxShadow(
                              blurRadius: 20,
                              spreadRadius: 0,
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(0.2),
                            ),
                          ]
                        : [],
                  ),
                  width: double.infinity,
                  child: CupertinoButton(
                    onPressed: _escolhido != null
                        ? _btnAtivado
                            ? () async {
                                setState(() {
                                  _btnAtivado = false;
                                });
                                try {
                                  await EmailJS.send(
                                    "service_4znv29e",
                                    "template_acyg5v9",
                                    {
                                      "motivo": _escolhido,
                                      "mensagem": _txtMensagem.text,
                                    },
                                  );
                                  setState(() {
                                    _btnAtivado = true;
                                  });
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                } catch (e) {
                                  debugPrint(e.toString());
                                  setState(() {
                                    _btnAtivado = true;
                                  });
                                }
                              }
                            : null
                        : null,
                    color: dark ? const Color(0xFFCD2F2F) : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    borderRadius: BorderRadius.circular(12),
                    disabledColor: CupertinoColors.systemGrey6,
                    child: Text(
                      "Enviar",
                      style: GoogleFonts.inter(
                        color: _escolhido != null
                            ? dark
                                ? Colors.white
                                : const Color(0xFF990000)
                            : CupertinoColors.inactiveGray,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
