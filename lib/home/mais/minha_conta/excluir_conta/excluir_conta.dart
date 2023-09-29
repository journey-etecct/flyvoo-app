import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher.dart';

final _keySenha = GlobalKey<FormFieldState>();
final _txtSenha = TextEditingController();
bool _txtEscondido = true;
IconData _iconeOlho = Icons.visibility_rounded;

class ExcluirConta extends StatefulWidget {
  const ExcluirConta({super.key});

  @override
  State<ExcluirConta> createState() => _ExcluirContaState();
}

class _ExcluirContaState extends State<ExcluirConta> {
  bool _btnAtivado = true;
  bool _confirmado = false;

  String provider() {
    return userFlyvoo!.providerData.first.providerId;
  }

  Future<void> verificar(Function setStateDialogo) async {
    if (_keySenha.currentState!.validate()) {
      setStateDialogo(() {
        _btnAtivado = false;
      });
      try {
        final cr = await userFlyvoo!.reauthenticateWithCredential(
          EmailAuthProvider.credential(
            email: userFlyvoo!.email!,
            password: _txtSenha.text,
          ),
        );
        setStateDialogo(() {
          userFlyvoo = cr.user;
          _txtSenha.text = "";
          _txtEscondido = true;
          _btnAtivado = true;
        });
        if (!mounted) return;
        Navigator.pop<bool>(
          context,
          true,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == "wrong-password") {
          Flushbar(
            duration: const Duration(seconds: 5),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(50),
            backgroundColor: Theme.of(context).colorScheme.error,
            messageText: Row(
              children: [
                Icon(
                  Symbols.error_rounded,
                  fill: 1,
                  color: Theme.of(context).colorScheme.onError,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Senha incorreta",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).colorScheme.onError,
                  ),
                ),
              ],
            ),
          ).show(context);
        } else if (e.code == "too-many-requests") {
          Flushbar(
            duration: const Duration(seconds: 5),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(50),
            backgroundColor: Theme.of(context).colorScheme.error,
            messageText: Row(
              children: [
                Icon(
                  Symbols.error_rounded,
                  fill: 1,
                  color: Theme.of(context).colorScheme.onError,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    "Muitas tentativas, tente novamente mais tarde.",
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ),
              ],
            ),
          ).show(context);
        } else {
          Flushbar(
            duration: const Duration(seconds: 5),
            margin: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(50),
            backgroundColor: Theme.of(context).colorScheme.error,
            messageText: Row(
              children: [
                Icon(
                  Symbols.error_rounded,
                  fill: 1,
                  color: Theme.of(context).colorScheme.onError,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    "Erro desconhecido: ${e.code}",
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.onError,
                    ),
                  ),
                ),
              ],
            ),
          ).show(context);
        }
        setStateDialogo(() {
          _btnAtivado = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _btnAtivado = provider() == "password";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Tema.fundo.toColor(),
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
          SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: ClipOval(
                              child: Image(
                                width: 120,
                                opacity: const AlwaysStoppedAnimation(0.5),
                                color: Colors.grey,
                                colorBlendMode: BlendMode.color,
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                  userFlyvoo!.photoURL!,
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 70,
                            child: Icon(
                              Symbols.close,
                              color: Color(0xfffb252e),
                              size: 80,
                              weight: 900,
                              opticalSize: 24,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          userFlyvoo!.displayName!,
                          maxLines: 2,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 50,
                    ),
                    child: Text(
                      "Tem certeza que deseja excluir a sua conta?",
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        letterSpacing: -0.41,
                        fontWeight: FontWeight.w600,
                        color: dark
                            ? const Color(0xFFFC2828)
                            : const Color(0xFF871E1E),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 22,
                        right: 22,
                        top: 31,
                      ),
                      child: Text(
                        "Ao excluir sua conta, você vai desaparecer totalmente do aplicativo para sempre! (é muito tempo)\n\nSendo uma decisão permanente, você tem convicção disso? Você perderá todas suas estatísticas, informações de carreira e tudo salvo no seu perfil...",
                        style: GoogleFonts.inter(
                          color: dark ? Colors.white : const Color(0xFF871E1E),
                          letterSpacing: -0.41,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          height: 1.15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(36, 0, 36, 80),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: CupertinoButton(
                            onPressed: () => Navigator.pop(context),
                            color: dark
                                ? const Color(0xFFCD2F2F)
                                : const Color(0xFFFF6C6C),
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            borderRadius: BorderRadius.circular(12),
                            child: Text(
                              "Cancelar",
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                                color: Colors.black.withOpacity(0.2),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: CupertinoButton(
                            onPressed: () async {
                              final decisao = await showCupertinoDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => alertaDelete1(context),
                              );
                              if (decisao) {
                                if (!mounted) return;
                                final decisaoFinal = await showCupertinoDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) => alertaDelete2(context),
                                );
                                if (decisaoFinal) {
                                  await FirebaseDatabase.instance
                                      .ref(
                                        "users/${userFlyvoo!.uid}",
                                      )
                                      .remove();
                                  userFlyvoo!.delete();
                                  if (!mounted) return;
                                  Navigator.popUntil(
                                    context,
                                    (route) => route.isFirst,
                                  );
                                  Navigator.pushReplacementNamed(
                                    context,
                                    "/index",
                                  );
                                  Navigator.pushNamed(
                                    context,
                                    "/excluirConta/feedback",
                                  );
                                }
                              }
                            },
                            color: dark
                                ? const Color(0xFFFF2D2D)
                                : const Color(0xFFFF2C2C),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            borderRadius: BorderRadius.circular(12),
                            child: Text(
                              "APAGAR MINHA CONTA",
                              style: GoogleFonts.inter(
                                fontSize: 19,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Theme alertaDelete1(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: dark ? Brightness.dark : Brightness.light,
        ),
      ),
      child: AlertDialog(
        title: Text(
          "Tem certeza disso?",
          style: GoogleFonts.inter(),
        ),
        content: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    "Se o seu problema for seu perfil${password ?? false ? ' ou sua conta' : ''}, você pode ",
                style: GoogleFonts.inter(color: Tema.fundo.toColor()),
              ),
              TextSpan(
                text: "editar seu perfil${password ?? false ? '' : '.'}",
                style: TextStyle(
                  color: ThemeData.from(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.red,
                      brightness: dark ? Brightness.dark : Brightness.light,
                    ),
                  ).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context, false);
                    Navigator.pop(context);
                    Navigator.pushNamed(
                      context,
                      "/home/editarPerfil",
                    );
                  },
                children: password ?? false
                    ? [
                        TextSpan(
                          text: " ou ",
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            color: Tema.fundo.toColor(),
                          ),
                        ),
                        TextSpan(
                          text: "mudar sua senha.",
                          style: TextStyle(
                            color: ThemeData.from(
                              useMaterial3: true,
                              colorScheme: ColorScheme.fromSeed(
                                seedColor: Colors.red,
                                brightness:
                                    dark ? Brightness.dark : Brightness.light,
                              ),
                            ).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(
                                context,
                                false,
                              );
                              Navigator.pop(
                                context,
                              );
                              Navigator.pushNamed(
                                context,
                                "/home/alterarSenha",
                              );
                            },
                        ),
                      ]
                    : [],
              ),
              TextSpan(
                text:
                    "\n\nSe estiver tendo problema com outra coisa, você pode sempre ",
                style: GoogleFonts.inter(color: Tema.fundo.toColor()),
              ),
              TextSpan(
                text: "nos mandar um feedback.",
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context, false);
                    Navigator.pop(context);
                    launchUrl(
                      Uri.parse("mailto:journeycompany2023@gmail.com"),
                    );
                  },
                style: GoogleFonts.inter(
                  color: ThemeData.from(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.red,
                      brightness: dark ? Brightness.dark : Brightness.light,
                    ),
                  ).colorScheme.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(
              context,
              false,
            ),
            child: const Text("NÃO APAGUE MINHA CONTA"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(
              context,
              true,
            ),
            child: const Text("QUERO APAGAR MINHA CONTA"),
          ),
        ],
      ),
    );
  }

  StatefulBuilder alertaDelete2(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialogo) {
        return Theme(
          data: ThemeData.from(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red,
              brightness: dark ? Brightness.dark : Brightness.light,
            ),
          ),
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
              setStateDialogo(() {});
            },
            child: AlertDialog(
              title: Text(
                "Tão triste te ver partir assim...",
                style: GoogleFonts.inter(),
              ),
              content: conteudo(setStateDialogo),
              actions: [
                FilledButton(
                  onPressed: () {
                    setState(() {
                      _txtSenha.text = "";
                      _txtEscondido = true;
                      _btnAtivado = provider() == "password";
                      _confirmado = false;
                    });
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child: const Text("CANCELAR A EXCLUSÃO"),
                ),
                OutlinedButton(
                  onPressed: _btnAtivado
                      ? () async {
                          switch (provider()) {
                            case "password":
                              await verificar(setStateDialogo);
                              break;
                            default:
                              if (!mounted) return;
                              Navigator.pop<bool>(context, true);
                          }
                        }
                      : null,
                  child: const Text("APAGAR DEFINITIVAMENTE"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column conteudo(StateSetter setStateDialogo) {
    List<Widget> google = <Widget>[
      const Text(
        "Para continuar com a exclusão da sua conta, confirme sua conta abaixo:",
      ),
      const SizedBox(
        height: 15,
      ),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Symbols.check,
              color: !_confirmado ? Colors.transparent : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            width: _confirmado ? 230 : 500,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(100),
              color: ColorScheme.fromSeed(
                seedColor: Colors.red,
                brightness: Brightness.dark,
              ).primary,
              padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
              onPressed: () async {
                final flushbar = Flushbar(
                  message: "Confirmando...",
                  duration: const Duration(seconds: 10),
                  margin: const EdgeInsets.all(20),
                  borderRadius: BorderRadius.circular(50),
                );
                flushbar.show(context);
                try {
                  final googleUser = await GoogleSignIn().signInSilently();
                  if (googleUser != null) {
                    final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;
                    final cr = await userFlyvoo!.reauthenticateWithCredential(
                      GoogleAuthProvider.credential(
                        accessToken: googleAuth.accessToken,
                        idToken: googleAuth.idToken,
                      ),
                    );
                    setStateDialogo(() {
                      userFlyvoo = cr.user;
                      _confirmado = true;
                      _btnAtivado = true;
                    });
                    flushbar.dismiss();
                  }
                } on FirebaseAuthException catch (e) {
                  if (!mounted) return;
                  if (e.code == "user-mismatch") {
                    Flushbar(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      messageText: Row(
                        children: [
                          Icon(
                            Symbols.error_rounded,
                            fill: 1,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Usuário incorreto",
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ],
                      ),
                    ).show(context);
                  } else {
                    Flushbar(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      messageText: Row(
                        children: [
                          Icon(
                            Symbols.error_rounded,
                            fill: 1,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Erro desconhecido: ${e.code}",
                              style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).show(context);
                  }
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: const AssetImage("assets/icons/google.png"),
                      height: 29,
                      color: ColorScheme.fromSeed(
                        seedColor: Colors.red,
                        brightness: Brightness.dark,
                      ).onPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Confirmar",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

    List<Widget> email = <Widget>[
      const Text(
        "Para continuar com a exclusão da sua conta, confirme sua senha abaixo:",
      ),
      TextFormField(
        key: _keySenha,
        controller: _txtSenha,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "*Obrigatório";
          } else if (value.length < 8) {
            return "A senha tem mais de 8 caracteres.";
          }
          return null;
        },
        onChanged: (value) {
          _keySenha.currentState!.validate();
        },
        cursorColor: Tema.texto.toColor(),
        autofillHints: const [AutofillHints.password],
        obscureText: _txtEscondido,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          labelText: "Senha",
          labelStyle: GoogleFonts.inter(),
          floatingLabelStyle: TextStyle(
            color: Tema.texto.toColor(),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Tema.texto.toColor(),
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
                  setStateDialogo(() {
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
      )
    ];

    List<Widget> microsoft = <Widget>[
      const Text(
        "Para continuar com a exclusão da sua conta, confirme sua conta abaixo:",
      ),
      const SizedBox(
        height: 15,
      ),
      Stack(
        alignment: Alignment.centerLeft,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Symbols.check,
              color: !_confirmado ? Colors.transparent : null,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            width: _confirmado ? 230 : 500,
            child: CupertinoButton(
              borderRadius: BorderRadius.circular(100),
              color: ColorScheme.fromSeed(
                seedColor: Colors.red,
                brightness: Brightness.dark,
              ).primary,
              padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
              onPressed: () async {
                try {
                  final mauthpro = MicrosoftAuthProvider();
                  final cr = await userFlyvoo!.reauthenticateWithProvider(
                    mauthpro,
                  );
                  setStateDialogo(() {
                    userFlyvoo = cr.user;
                    _confirmado = true;
                    _btnAtivado = true;
                  });
                } on FirebaseAuthException catch (e) {
                  if (!mounted) return;
                  if (e.code == "user-mismatch") {
                    Flushbar(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      messageText: Row(
                        children: [
                          Icon(
                            Symbols.error_rounded,
                            fill: 1,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Usuário incorreto",
                            style: GoogleFonts.inter(
                              color: Theme.of(context).colorScheme.onError,
                            ),
                          ),
                        ],
                      ),
                    ).show(context);
                  } else if (e.code == "web-context-canceled") {
                  } else {
                    Flushbar(
                      duration: const Duration(seconds: 5),
                      margin: const EdgeInsets.all(20),
                      borderRadius: BorderRadius.circular(50),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      messageText: Row(
                        children: [
                          Icon(
                            Symbols.error_rounded,
                            fill: 1,
                            color: Theme.of(context).colorScheme.onError,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Erro desconhecido: ${e.code}",
                              style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).show(context);
                  }
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 25,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image(
                      image: const AssetImage("assets/icons/microsoft.png"),
                      height: 29,
                      color: ColorScheme.fromSeed(
                        seedColor: Colors.red,
                        brightness: Brightness.dark,
                      ).onPrimary,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Confirmar",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: switch (provider()) {
        "password" => email,
        "google.com" => google,
        _ => microsoft
      },
    );
  }
}
