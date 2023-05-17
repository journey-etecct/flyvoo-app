// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'main.dart';

int _step = 0;
final _txtNome = TextEditingController();
final _txtEmail = TextEditingController();
final _txtTelefone = TextEditingController();
final _txtSenha = TextEditingController();
final _txtSenhaConf = TextEditingController();

class Cadastro extends StatefulWidget {
  const Cadastro({Key? key}) : super(key: key);

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> with TickerProviderStateMixin {
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  late List<Widget> telas = <Widget>[Tela1(_formKey1), Tela2(_formKey2)];
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
          _txtSenha.text = "";
          _txtSenhaConf.text = "";
          return true;
        }
      },
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: Scaffold(
          backgroundColor: tema["fundo"],
          body: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
                      SizedBox(
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
                              if (_formKey1.currentState!.validate()) {
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
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
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

class Tela1 extends StatefulWidget {
  final Key formKey;
  const Tela1(this.formKey, {super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {
  IconData _iconeOlho = Icons.visibility_rounded;
  bool _txtEscondido = true;
  final _senhaConfKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _txtNome,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            keyboardType: TextInputType.text,
            maxLength: 255,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.contains(
                RegExp(
                  r'''[!@#<>?":,.'_/`~;[\]\\|=+)(*&^%0-9-]''',
                ),
              )) {
                return "Nome inválido";
              } else if (!value.contains(
                RegExp(
                  r'^[A-ZÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð][a-zàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšž∂ð]{1,}( {1,2}[A-ZÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð][a-za-zàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšž∂ð]{1,}){1,10}$',
                ),
              )) {
                return "Insira seu nome completo";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Nome Completo",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
            ),
            cursorColor: tema["primaria"],
          ),
          TextFormField(
            controller: _txtEmail,
            textInputAction: TextInputAction.next,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            ),
            cursorColor: tema["primaria"],
          ),
          TextFormField(
            controller: _txtTelefone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (value.length < 14) {
                return "Muito curto";
              }
              return null;
            },
            autofillHints: const [AutofillHints.telephoneNumberNational],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: "Telefone (Celular ou fixo)",
              labelStyle: TextStyle(fontSize: 20),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
            ),
            cursorColor: tema["primaria"],
            inputFormatters: [
              PhoneInputFormatter(
                defaultCountryCode: "BR",
              )
            ],
          ),
          TextFormField(
            controller: _txtSenha,
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              }
              return null;
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (value) => _senhaConfKey.currentState!.validate(),
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Senha",
              labelStyle: TextStyle(
                fontSize: 20,
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
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
            ),
            cursorColor: tema["primaria"],
          ),
          TextFormField(
            key: _senhaConfKey,
            controller: _txtSenhaConf,
            enableInteractiveSelection: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "*Obrigatório";
              } else if (_txtSenha.text != value) {
                return "Senhas não coincidem";
              } else {
                return null;
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            autofillHints: const [AutofillHints.password],
            obscureText: _txtEscondido,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Confirmação da Senha",
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: tema["primaria"],
                ),
              ),
            ),
            cursorColor: tema["primaria"],
          ),
        ],
      ),
    );
  }
}

class Tela2 extends StatefulWidget {
  final Key formKey;
  const Tela2(this.formKey, {super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  final List<ColorItem> items = [
    ColorItem("default", Colors.white),
    ColorItem("verde", Colors.green),
    ColorItem("laranja", Colors.yellow),
    ColorItem("azul", Colors.blue),
    ColorItem("vermelho", Colors.blue),
    ColorItem("roxo", Colors.blue),
  ];
  late ColorItem currentChoice;

  @override
  void initState() {
    currentChoice = items.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.amber),
            child: DropdownButtonFormField(
              borderRadius: BorderRadius.circular(25),
              value: currentChoice,
              decoration: InputDecoration(fillColor: Colors.amber),
              items: items
                  .map<DropdownMenuItem<ColorItem>>(
                    (ColorItem item) => DropdownMenuItem<ColorItem>(
                      value: item,
                      child: Container(
                        constraints: BoxConstraints(minHeight: 48.0),
                        color: item.color,
                        child: Text(item.name),
                      ),
                    ),
                  )
                  .toList(),
              /* <DropdownMenuItem>[
                DropdownMenuItem(
                  value: "",
                  enabled: false,
                  child: Text("Qual área mais te interessa?"),
                ),
                DropdownMenuItem(
                  value: "essa",
                  child: Text("essa"),
                ),
                DropdownMenuItem(
                  value: "essa outra",
                  child: Text("essa outra"),
                ),
                DropdownMenuItem(
                  value: "mais uma",
                  child: Text("mais uma"),
                ),
              ], */
              onChanged: (ColorItem? value) => setState(
                () => currentChoice = value!,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ColorItem {
  ColorItem(this.name, this.color);
  final String name;
  final Color color;
}
