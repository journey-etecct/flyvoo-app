// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyvoo/cadastro/opcoes.dart';
import 'package:flyvoo/main.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
      child: Scaffold(
        backgroundColor: tema["fundo"],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {});
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image(
                        image: AssetImage(
                          dark
                              ? "assets/logo/logogradientedark.png"
                              : "assets/logo/logogradientelight.png",
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
                      cursorColor: tema["primaria"],
                      autofillHints: const [AutofillHints.email],
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: GoogleFonts.inter(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: tema["primaria"]!,
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
                      cursorColor: tema["primaria"],
                      autofillHints: const [AutofillHints.password],
                      obscureText: _txtEscondido,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: "Senha",
                        labelStyle: GoogleFonts.inter(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: tema["primaria"]!,
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
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                            text: "Esqueceu a senha?",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              color: tema["primaria"],
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // TODO: mudar senha
                              }),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Não possui cadastro? ",
                        style: GoogleFonts.inter(
                          color: tema["noFundo"],
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
                                    builder: (context) =>
                                        const OpcoesDeCadastro(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CupertinoButton(
                      borderRadius: BorderRadius.circular(10),
                      padding: EdgeInsets.fromLTRB(35, 10, 35, 10),
                      color: tema["primaria"]?.withOpacity(0.65),
                      onPressed: () {
                        TextInput.finishAutofillContext();
                        // TODO: entrar
                        if (_formKey.currentState!.validate()) {
                          debugPrint("ebaa");
                        }
                      },
                      child: Text(
                        "Entrar",
                        style: GoogleFonts.inter(
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
