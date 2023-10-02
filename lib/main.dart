import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flyvoo/blablabla/termos.dart';
import 'package:flyvoo/cadastro/opcoes.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/cadastro/verificacao/email_enviado.dart';
import 'package:flyvoo/cadastro/verificacao/index.dart';
import 'package:flyvoo/firebase_options.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/mais/minha_conta/alterar_senha.dart';
import 'package:flyvoo/home/mais/minha_conta/blablabla/politica.dart';
import 'package:flyvoo/home/mais/minha_conta/blablabla/termos.dart';
import 'package:flyvoo/home/mais/minha_conta/config_gerais.dart';
import 'package:flyvoo/home/mais/minha_conta/editar_perfil.dart';
import 'package:flyvoo/home/mais/minha_conta/excluir_conta/excluir_conta.dart';
import 'package:flyvoo/home/mais/minha_conta/excluir_conta/feedback.dart';
import 'package:flyvoo/home/mais/minha_conta/minha_conta.dart';
import 'package:flyvoo/index.dart';
import 'package:flyvoo/login/email_enviado.dart';
import 'package:flyvoo/login/opcoes.dart';
import 'package:flyvoo/login/recuperacao.dart';
import 'package:flyvoo/seminternet.dart';
import 'package:flyvoo/tema.dart';
import 'package:flyvoo/update.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:video_player/video_player.dart';

bool internetIniciado = false;

// variaveis iniciais
late VideoPlayerController controllerBG;
final ValueNotifier<Brightness> notifier = ValueNotifier(
  dark ? Brightness.dark : Brightness.light,
);
User? userFlyvoo;

Future<void> main() async {
  final widgetsbinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsbinding);

  //firebase inicializa
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  //pegar situação de login
  userFlyvoo = FirebaseAuth.instance.currentUser;
  final instS = await SharedPreferences.getInstance();
  dark = instS.getBool("dark") ??
      WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
  if (userFlyvoo != null) {
    password = (await FirebaseAuth.instance.fetchSignInMethodsForEmail(
          userFlyvoo!.email!,
        ))
            .first ==
        "password";
  }

  //pagina inicial de acordo com a situação de login
  if (instS.getBool("cadastroTerminado") != null) {
    if (!instS.getBool("cadastroTerminado")!) {
      runApp(const Flyvoo(Index(false)));
    } else {
      runApp(const Flyvoo(Home()));
    }
  } else {
    runApp(const Flyvoo(Index(true)));
  }
}

class Flyvoo extends StatefulWidget {
  final Widget home;
  const Flyvoo(
    this.home, {
    super.key,
  });

  @override
  State<Flyvoo> createState() => _FlyvooState();
}

class _FlyvooState extends State<Flyvoo> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> initUniLinks() async {
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        navigatorKey.currentState!.pushNamed('/cadastro', arguments: "email");
      }
    } on PlatformException catch (e) {
      debugPrint(e.code);
    }
    linkStream.listen((String? link) {
      if (link != null && link.isNotEmpty) {
        navigatorKey.currentState!.pushNamed('/cadastro', arguments: "email");
      }
    }, onError: (err) {
      debugPrint(err);
    });
  }

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) => MaterialApp(
        builder: (context, child) {
          return DefaultTextStyle(
            style: GoogleFonts.inter(
              letterSpacing: -0.41,
            ),
            child: Container(
              color: Tema.fundo.cor(),
              child: Banner(
                message: "DEMO",
                textStyle: TextStyle(
                  color: Tema.fundo.cor(),
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
                color: Tema.texto.cor(),
                location: BannerLocation.bottomEnd,
                child: child,
              ),
            ),
          );
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case "/semInternet":
              return CupertinoPageRoute(
                builder: (context) => const SemInternet(),
                settings: settings,
                fullscreenDialog: true,
              );
            case "/update":
              return CupertinoPageRoute(
                builder: (context) => const Update(),
                settings: settings,
                fullscreenDialog: true,
              );
            case "/index":
              return CupertinoPageRoute(
                builder: (context) => const Index(true),
                settings: const RouteSettings(name: "/index"),
              );
            case "/opcoesCadastro":
              return CupertinoPageRoute(
                builder: (context) => const OpcoesDeCadastro(),
                settings: settings,
              );
            case "/opcoesCadastro/email":
              return CupertinoPageRoute(
                builder: (context) => const VerificacaoEmail(),
                settings: settings,
              );
            case "/opcoesCadastro/email/enviado":
              return CupertinoPageRoute(
                builder: (context) => const EmailEnviado(),
                settings: settings,
              );
            case "/cadastro":
              return CupertinoPageRoute(
                builder: (context) => const Cadastro(),
                settings: settings,
              );
            case "/login":
              return CupertinoPageRoute(
                builder: (context) => const Login(),
                settings: settings,
              );
            case "/login/recuperacao":
              return CupertinoPageRoute(
                builder: (context) => const Recuperacao(),
                settings: settings,
              );
            case "/login/recuperacao/emailEnviado":
              return CupertinoPageRoute(
                builder: (context) => const EmailEnviadoSenha(),
                settings: settings,
              );
            case "/home":
              return CupertinoPageRoute(
                builder: (context) => const Home(),
                settings: settings,
              );
            case "/home/editarPerfil":
              return CupertinoPageRoute(
                builder: (context) => const EditarPerfil(),
                settings: settings,
              );
            case "/home/termosdeuso":
              return CupertinoPageRoute(
                builder: (context) => const TermosDeUso(),
                settings: settings,
              );
            case "/home/politica":
              return CupertinoPageRoute(
                builder: (context) => const Politica(),
                settings: settings,
              );
            case "/home/configGerais":
              return CupertinoPageRoute(
                builder: (context) => const ConfigGerais(),
                settings: settings,
              );
            case "/home/alterarSenha":
              return CupertinoPageRoute(
                builder: (context) => const AlterarSenha(),
                settings: settings,
              );
            case "/excluirConta":
              return SlideUpRoute(
                const ExcluirConta(),
              );
            case "/excluirConta/feedback":
              return CupertinoPageRoute(
                builder: (context) => const FeedbackEC(),
                settings: settings,
              );
            case "/termos":
              return CupertinoPageRoute(
                builder: (context) => const Termos(),
                settings: settings,
              );
          }
          return null;
        },
        theme: buildTheme(value, context),
        home: widget.home,
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

ThemeData buildTheme(mode, context) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    brightness: mode,
    colorSchemeSeed: Tema.primaria.cor(),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: GoogleFonts.inter(
        color: Tema.primaria.cor(),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Tema.primaria.cor(),
        ),
      ),
    ),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
