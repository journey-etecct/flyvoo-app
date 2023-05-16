// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  IconData _iconeOlho = Icons.visibility_rounded;
  bool _txtEscondido = true;
  final _loginKey = GlobalKey<FormFieldState>();
  final _senhaKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Scaffold(
          backgroundColor: dark ? temaDark["fundo"] : temaLight["fundo"],
          body: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Form(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image(
                            image: AssetImage(
                              dark
                                  ? "assets/logogradientedark.png"
                                  : "assets/logogradientelight.png",
                            ),
                            width: 266,
                            height: 266,
                          ),
                        ),
                        Text(
                          "Flyvoo",
                          style: TextStyle(
                            fontFamily: "Queensides",
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          key: _loginKey,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*Obrigatório";
                            } else if (!value.contains("@gmail.com") &&
                                !value.contains("@etec.sp.gov.br") &&
                                !value.contains("@outlook.com") &&
                                !value.contains("@hotmail.com")) {
                              return "Email inválido";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _loginKey.currentState!.validate();
                          },
                          autofillHints: const [AutofillHints.email],
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*Obrigatório";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _senhaKey.currentState!.validate();
                          },
                          autofillHints: const [AutofillHints.password],
                          obscureText: _txtEscondido,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: const TextStyle(fontSize: 20),
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
                                        _iconeOlho =
                                            Icons.visibility_off_rounded;
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
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              // TODO: mudar senha
                            },
                            child: Text(
                              "Esqueceu a senha?",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Não possui cadastro? ",
                            children: [
                              TextSpan(
                                text: "Clique aqui",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // TODO: criar conta
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
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.65),
                          onPressed: () {
                            // TODO: entrar
                            if (_loginKey.currentState!.validate() &&
                                _senhaKey.currentState!.validate()) {
                              debugPrint("ebaa");
                            }
                          },
                          child: Text(
                            "Entrar",
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
        ),
      ),
    );
  }
}
