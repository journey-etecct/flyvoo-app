import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/telas/tela1.dart';
import 'package:flyvoo/cadastro/telas/tela2.dart';
import 'package:flyvoo/cadastro/telas/tela3.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

final _formKey1 = GlobalKey<FormState>();
final _formKey2 = GlobalKey<FormState>();
final txtNome = TextEditingController();
final txtTelefone = TextEditingController();
final txtSenha = TextEditingController();
final txtSenhaConf = TextEditingController();
List<Widget> telas = <Widget>[
  Tela1(_formKey1),
  Tela2(_formKey2),
  const Tela3(),
];
List<String> botaoTxt = <String>[
  "Próximo",
  "Próximo",
  "Finalizar",
];
bool _reversed = false;
int _step = 0;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  @override
  void initState() {
    _step = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_step != 0) {
          setState(() {
            _reversed = true;
            _step--;
          });
          return false;
        } else {
          showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: Text(
                "Tem certeza que deseja sair da etapa de cadastro?",
                style: GoogleFonts.inter(),
              ),
              content: Text(
                "Sua conta será removida e você precisará verificar seu email novamente.",
                style: GoogleFonts.inter(),
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancelar",
                    style: GoogleFonts.inter(
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () async {
                    if (userFlyvoo != null) {
                      await userFlyvoo?.delete();
                    }
                    await FirebaseAuth.instance.signOut();
                    if (!mounted) return;
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                  child: Text(
                    "Sair",
                    style: GoogleFonts.inter(
                      color: CupertinoColors.systemPink,
                    ),
                  ),
                ),
              ],
            ),
          );
          return true;
        }
      },
      child: Scaffold(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        Text(
                          "CADASTRO",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: tema["texto"],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Expanded(
                          child: PageTransitionSwitcher(
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
                                transitionType:
                                    SharedAxisTransitionType.horizontal,
                                child: child,
                              );
                            },
                            child: telas[_step],
                          ),
                        ),
                        Text(
                          ModalRoute.of(context)
                                  ?.settings
                                  .arguments
                                  .toString() ??
                              "",
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tema["fundo"],
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
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(10),
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                            color: tema["botaoIndex"],
                            onPressed: () {
                              setState(() {
                                switch (_step) {
                                  case 0:
                                    if (true /* _formKey1.currentState!.validate() */) {
                                      _reversed = false;
                                      _step++;
                                    }
                                    break;
                                  case 1:
                                    if (true /* _formKey1.currentState!.validate() */) {
                                      _reversed = false;
                                      _step++;
                                    }
                                    break;
                                  default:
                                  // TODO: terminar o cadastro
                                }
                                /* if (_step == 0) {
                                  if (!kDebugMode) {
                                    if (_formKey1.currentState!.validate()) {
                                      _reversed = false;
                                      _step++;
                                    }
                                  } else {
                                    _reversed = false;
                                    _step++;
                                  }
                                } else {
                                  Navigator.pop(context);
                                } */
                              });
                            },
                            child: Text(
                              botaoTxt[_step],
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                color: tema["textoBotaoIndex"],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
