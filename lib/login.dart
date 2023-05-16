// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Icon _iconeOlho = const Icon(Icons.visibility_rounded);
  bool _txtEscondido = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark ? temaDark["fundo"] : temaLight["fundo"],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                    style: TextStyle(fontFamily: "Queensides", fontSize: 50),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    autofillHints: const [AutofillHints.email],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 20),
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.emoji_people),
                        iconSize: 0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    autofillHints: const [AutofillHints.password],
                    obscureText: _txtEscondido,
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle: const TextStyle(fontSize: 20),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_txtEscondido) {
                              _iconeOlho = const Icon(
                                Icons.visibility_off_rounded,
                              );
                              _txtEscondido = false;
                            } else {
                              _iconeOlho = const Icon(
                                Icons.visibility_rounded,
                              );
                              _txtEscondido = true;
                            }
                          });
                        },
                        icon: _iconeOlho,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        "Esqueceu a senha?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("aafolou"),
                                  ),
                                );
                              }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
