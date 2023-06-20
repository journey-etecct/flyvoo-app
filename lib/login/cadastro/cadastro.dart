// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/login/cadastro/tela1.dart';
import 'package:flyvoo/login/cadastro/tela2.dart';
import 'package:flyvoo/login/cadastro/tela3.dart';
import 'package:flyvoo/login/login.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

int _step = 0;
final txtSenha = TextEditingController();
final txtSenhaConf = TextEditingController();

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> with TickerProviderStateMixin {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  late List<Widget> telas = <Widget>[
    Tela1(_formKey1),
    Tela2(_formKey2),
    Tela3(),
  ];
  bool _reversed = false;

  @override
  void initState() {
    _step = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_step == 1) {
          setState(() {
            _reversed = true;
            _step--;
          });
          return false;
        } else {
          txtSenha.text = "";
          txtSenhaConf.text = "";
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: Padding(
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
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: dark
                                  ? Colors.black.withOpacity(0.2)
                                  : Colors.transparent,
                              border: Border.all(
                                color: tema["primaria"]!,
                              ),
                            ),
                            child: Image(
                              image: AssetImage(
                                dark
                                    ? "assets/logo/logodark.png"
                                    : "assets/logo/logolight.png",
                              ),
                              width: 90,
                              height: 90,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "CADASTRO",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                            transitionType: SharedAxisTransitionType.horizontal,
                            child: child,
                          );
                        },
                        child: telas[_step],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Já possui cadastro? ",
                        style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        children: [
                          TextSpan(
                            text: "Clique aqui",
                            style: GoogleFonts.inter(
                              color: tema["primaria"],
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(10),
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                      color: tema["primaria"]?.withOpacity(0.65),
                      onPressed: () {
                        setState(() {
                          if (_step == 0) {
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
                          }
                        });
                      },
                      child: Text(
                        _step == 0 ? "Próximo" : "Cadastrar",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
