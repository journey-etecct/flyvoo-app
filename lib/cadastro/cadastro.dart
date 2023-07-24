import 'dart:io';

import 'package:animations/animations.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flyvoo/cadastro/telas_email/tela1.dart';
import 'package:flyvoo/cadastro/telas_email/tela2.dart';
import 'package:flyvoo/cadastro/telas_email/tela3.dart';
import 'package:flyvoo/cadastro/telas_google/tela1.dart';
import 'package:flyvoo/cadastro/telas_google/tela2.dart';
import 'package:flyvoo/cadastro/telas_google/tela3.dart';
import 'package:flyvoo/cadastro/telas_microsoft/tela1.dart';
import 'package:flyvoo/cadastro/telas_microsoft/tela2.dart';
import 'package:flyvoo/cadastro/telas_microsoft/tela3.dart';
import 'package:flyvoo/index.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

final formKey1 = GlobalKey<FormState>();
final formKey2 = GlobalKey<FormState>();
final txtNome = TextEditingController();
final txtTelefone = TextEditingController();
final txtSenha = TextEditingController();
final txtSenhaConf = TextEditingController();
String? carreiraEscolhida;
String? sexoEscolhido;
String? pronomesEscolhidos;
DateTime? nascimento;
File? userImg;
List<Widget> telas = const <Widget>[
  Tela1(),
  Tela2(),
  Tela3(),
];
List<Widget> telasGoogle = const <Widget>[
  TelaGoogle1(),
  TelaGoogle2(),
  TelaGoogle3(),
];
List<Widget> telasMicrosoft = const <Widget>[
  TelaMicrosoft1(),
  TelaMicrosoft2(),
  TelaMicrosoft3(),
];
List<String> botaoTxt = const <String>[
  "Próximo",
  "Próximo",
  "Finalizar",
];
bool _reversed = false;
int _step = 0;
bool btnAtivado = true;

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  init() async {
    if (!iniciado) {
      controllerBG = VideoPlayerController.asset(
        dark ? "assets/background/dark.webm" : "assets/background/light.webm",
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      await controllerBG.initialize();
      await controllerBG.setLooping(true);
      setState(() {});
      final inst = await SharedPreferences.getInstance();
      if (inst.getBool("animacoes") ?? true) {
        await controllerBG.play();
      }
      setState(() {
        iniciado = true;
      });
    }
    linearGradient = LinearGradient(
      colors: <Color>[
        tema["primaria"]!,
        tema["noFundo"]!,
      ],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 200.0));
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    init();
    txtNome.text = "";
    txtSenha.text = "";
    txtSenhaConf.text = "";
    txtTelefone.text = "";
    sexoEscolhido = null;
    carreiraEscolhida = null;
    pronomesEscolhidos = null;
    nascimento = null;
    userFlyvoo = FirebaseAuth.instance.currentUser;
    _step = 0;
    btnAtivado = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final argumento = ModalRoute.of(context)!.settings.arguments.toString();
    return WillPopScope(
      onWillPop: () async {
        if (_step != 0) {
          setState(() {
            _reversed = true;
            _step--;
            btnAtivado = true;
          });
          return false;
        } else if (argumento == "email") {
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
                    final instS = await SharedPreferences.getInstance();
                    await instS.remove("cadastroTerminado");
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
          return false;
        } else {
          final inst = await SharedPreferences.getInstance();
          inst.remove("cadastroTerminado");
          await FirebaseAuth.instance.currentUser?.delete();
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
                            child: switch (argumento) {
                              "email" => telas[_step],
                              "google" => telasGoogle[_step],
                              _ => telasMicrosoft[_step],
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: tema["fundo"],
                            boxShadow: btnAtivado
                                ? <BoxShadow>[
                                    BoxShadow(
                                      blurRadius: 4,
                                      spreadRadius: 0,
                                      offset: const Offset(0, 5),
                                      color: const Color(
                                        0xff000000,
                                      ).withOpacity(0.25),
                                    ),
                                  ]
                                : [],
                          ),
                          child: CupertinoButton(
                            borderRadius: BorderRadius.circular(10),
                            padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                            color: tema["botaoIndex"],
                            disabledColor: dark
                                ? const Color(0xff007AFF).withOpacity(0.15)
                                : const Color(0xffFB5607).withOpacity(0.30),
                            onPressed: btnAtivado
                                ? () async {
                                    switch (_step) {
                                      case 0:
                                        setState(() {
                                          if (formKey1.currentState!
                                              .validate()) {
                                            _reversed = false;
                                            _step++;
                                          }
                                        });
                                        break;
                                      case 1:
                                        setState(() {
                                          if (nascimento != null) {
                                            if (formKey2.currentState!
                                                .validate()) {
                                              _reversed = false;
                                              _step++;
                                              if (userImg == null &&
                                                  userFlyvoo!.photoURL ==
                                                      null) {
                                                btnAtivado = false;
                                              }
                                            }
                                          }
                                        });
                                        break;
                                      default:
                                        setState(() {
                                          btnAtivado = false;
                                        });
                                        Flushbar(
                                          message: "Conectando...",
                                          duration: const Duration(seconds: 10),
                                          margin: const EdgeInsets.all(20),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ).show(context);
                                        if (argumento == "email") {
                                          await userFlyvoo
                                              ?.reauthenticateWithCredential(
                                            EmailAuthProvider.credential(
                                              email: userFlyvoo!.email!,
                                              password: "123456",
                                            ),
                                          );
                                          await userFlyvoo
                                              ?.updatePassword(txtSenha.text);
                                        }
                                        await userFlyvoo
                                            ?.updateDisplayName(txtNome.text);
                                        var ref = FirebaseDatabase.instance.ref(
                                          "users/${userFlyvoo!.uid}",
                                        );
                                        await ref.update({
                                          "telefone": txtTelefone.text,
                                          "nascimento":
                                              "${nascimento?.day};${nascimento?.month};${nascimento?.year}",
                                          "area": carreiraEscolhida,
                                          "sexo": sexoEscolhido,
                                          "pronomes": pronomesEscolhidos ==
                                                  "Pronomes (opcional)"
                                              ? "Nenhum"
                                              : pronomesEscolhidos,
                                        });
                                        SharedPreferences inst =
                                            await SharedPreferences
                                                .getInstance();
                                        inst.setBool(
                                          "cadastroTerminado",
                                          true,
                                        );
                                        if (argumento == "email") {
                                          Reference instSt =
                                              FirebaseStorage.instance.ref(
                                            "users/${userFlyvoo?.uid}",
                                          );
                                          await instSt.putFile(userImg!);
                                        } else if (userImg != null) {
                                          Reference instSt =
                                              FirebaseStorage.instance.ref(
                                            "users/${userFlyvoo?.uid}",
                                          );
                                          await instSt.putFile(userImg!);
                                        }
                                        await userFlyvoo?.updatePhotoURL(
                                          argumento == "email"
                                              ? "https://firebasestorage.googleapis.com/v0/b/flyvoo.appspot.com/o/users%2F${userFlyvoo?.uid}?alt=media"
                                              : userImg == null
                                                  ? userFlyvoo!.photoURL
                                                  : "https://firebasestorage.googleapis.com/v0/b/flyvoo.appspot.com/o/users%2F${userFlyvoo?.uid}?alt=media",
                                        );
                                        setState(() {
                                          userFlyvoo =
                                              FirebaseAuth.instance.currentUser;
                                        });
                                        Navigator.popUntil(
                                          context,
                                          (route) => route.isFirst,
                                        );
                                        Navigator.pushReplacementNamed(
                                          context,
                                          "/home",
                                        );
                                    }
                                  }
                                : null,
                            child: Text(
                              botaoTxt[_step],
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                color: btnAtivado
                                    ? tema["textoBotaoIndex"]
                                    : CupertinoColors.systemGrey2,
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
