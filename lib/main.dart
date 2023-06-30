import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  userFlyvoo = FirebaseAuth.instance.currentUser;
  if (userFlyvoo != null) {
    runApp(const Flyvoo(Home()));
  } else {
    runApp(const Flyvoo(Index()));
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
        navigatorKey.currentState!.pushNamed('/cadastro');
      }
    } on PlatformException catch (e) {
      debugPrint(e.code);
    }
    _sub = linkStream.listen((String? link) {
      if (link != null && link.isNotEmpty) {
        navigatorKey.currentState!.pushNamed('/cadastro');
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, child) => MaterialApp(
          routes: {
            "/index": (context) => const Index(),
            "/cadastro": (context) => const Cadastro(),
          }, // NÂO remove essa linha
          // mesmo que ela seja muito bobinha
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case "/index":
                return CupertinoPageRoute(
                  builder: (context) => const Index(),
                );
              case "/opcoesCadastro":
                return CupertinoPageRoute(
                  builder: (context) => const OpcoesDeCadastro(),
                );
              case "/opcoesCadastro/email":
                return CupertinoPageRoute(
                  builder: (context) => const VerificacaoEmail(),
                );
              case "/opcoesCadastro/email/enviado":
                return CupertinoPageRoute(
                  builder: (context) => const EmailEnviado(),
                );
              case "/cadastro":
                return CupertinoPageRoute(
                  builder: (context) => const Cadastro(),
                );
              case "/login":
                return CupertinoPageRoute(
                  builder: (context) => const Login(),
                );
              case "/home":
                return CupertinoPageRoute(
                  builder: (context) => const Home(),
                );
              case "/termos":
                return CupertinoPageRoute(
                  builder: (context) => const Termos(),
                );
            }
            return null;
          },
          theme: _buildTheme(value),
          home: widget.home,
          navigatorKey: navigatorKey,
        ),
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
