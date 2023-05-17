// ignore_for_file: prefer_const_constructors

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

int _step = 0;

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late List<Widget> telas = <Widget>[Tela1(_formKey), Tela2()];
  bool _reverse = false;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 60, 50, 40),
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                setState(() {});
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                                color: tema["primaria"],
                              ),
                            ),
                            child: Image(
                              image: AssetImage(
                                dark
                                    ? "assets/logodark.png"
                                    : "assets/logolight.png",
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
                        reverse: _reverse,
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
                    SizedBox(
                      height: 80,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Já possui cadastro? ",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                        children: [
                          TextSpan(
                            text: "Clique aqui",
                            style: TextStyle(
                              color: tema["primaria"],
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: tela de login
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                      color: tema["primaria"].withOpacity(0.65),
                      onPressed: () {
                        setState(() {
                          if (_step == 0) {
                            _reverse = false;
                            _step++;
                          } else {
                            _reverse = true;
                            _step--;
                          }
                        });
                      },
                      child: Text(
                        "Próximo",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

class Tela1 extends StatefulWidget {
  final Key formKey;
  const Tela1(this.formKey, {super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  IconData _iconeOlho = Icons.visibility_rounded;
  bool _txtEscondido = true;
  final _loginKey = GlobalKey<FormFieldState>();
  final _senhaKey = GlobalKey<FormFieldState>();
  final _senhaConfKey = GlobalKey<FormFieldState>();
  final _txtSenha = TextEditingController();
  final _txtSenhaConf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            key: _loginKey,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (!value.contains(
                RegExp(
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                ),
              ) /* !value.contains("@gmail.com") &&
                  !value.contains("@etec.sp.gov.br") &&
                  !value.contains("@outlook.com") &&
                  !value.contains("@hotmail.com") &&
                  !value.contains("@yahoo.com") &&
                  !value.contains("@terra.com.br") */
                  ) {
                return "Email inválido";
              }
              return null;
            },
            onChanged: (value) {
              _loginKey.currentState!.validate();
            },
            cursorColor: tema["primaria"],
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
              suffix: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.transparent,
                      size: 20,
                    ),
                    onTap: () {
                      // ignorar
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            key: _senhaKey,
            controller: _txtSenha,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: tema["primaria"],
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
              suffix: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Icon(
                      _iconeOlho,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        if (_txtEscondido) {
                          _iconeOlho = Icons.visibility_off_rounded;
                          _txtEscondido = false;
                        } else {
                          _iconeOlho = Icons.visibility_rounded;
                          _txtEscondido = true;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          TextFormField(
            key: _senhaConfKey,
            controller: _txtSenhaConf,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (_txtSenha.text != _txtSenhaConf.text) {
                return "Senhas não coincidem";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            cursorColor: tema["primaria"],
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Confirmação da senha",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
