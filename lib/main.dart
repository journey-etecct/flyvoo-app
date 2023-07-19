import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flyvoo/blablabla/termos.dart';
import 'package:flyvoo/cadastro/opcoes.dart';
import 'package:flyvoo/cadastro/telas/cadastro.dart';
import 'package:flyvoo/cadastro/verificacao/email_enviado.dart';
import 'package:flyvoo/cadastro/verificacao/index.dart';
import 'package:flyvoo/firebase_options.dart';
import 'package:flyvoo/home/home.dart';
import 'package:flyvoo/index.dart';
import 'package:flyvoo/login/opcoes.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:video_player/video_player.dart';

late StreamSubscription<String?> _sub;

// variaveis iniciais
late VideoPlayerController controllerBG;
final ValueNotifier<Brightness> notifier = ValueNotifier(
  dark ? Brightness.dark : Brightness.light,
);
User? userFlyvoo;

Future<void> main() async {
  var widgetsbinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsbinding);

  //firebase inicializa
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //pegar situação de login
  userFlyvoo = FirebaseAuth.instance.currentUser;
  final instS = await SharedPreferences.getInstance();

  //pagina inicial de acordo com a situação de login
  if (userFlyvoo == null) {
    runApp(const Flyvoo(Index(true)));
  } else {
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
    _sub = linkStream.listen((String? link) {
      if (link != null && link.isNotEmpty) {
        navigatorKey.currentState!.pushNamed('/cadastro', arguments: "email");
      }
    }, onError: (err) {
      debugPrint(err);
    });
  }

  @override
  void initState() {
    initUniLinks();
    super.initState();
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
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
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
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
            case "/home":
              return CupertinoPageRoute(
                builder: (context) => const Home(),
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
        theme: _buildTheme(value),
        home: widget.home,
        navigatorKey: navigatorKey,
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

ThemeData _buildTheme(mode) {
  var baseTheme = ThemeData(
    useMaterial3: true,
    brightness: mode,
    colorSchemeSeed: tema["primaria"],
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: TextStyle(
        color: tema["primaria"],
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: tema["primaria"]!,
        ),
      ),
    ),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
