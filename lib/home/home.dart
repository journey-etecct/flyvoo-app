import 'package:animations/animations.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flyvoo/home/empresas/empresas.dart';
import 'package:flyvoo/home/mais/mais.dart';
import 'package:flyvoo/home/principal/principal.dart';
import 'package:flyvoo/home/univcursos/univcursos.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:shared_preferences/shared_preferences.dart';

late int indexHome;
List<Area?> fundos = [
  null,
  ...Area.values,
];
late BuildContext contextHome;
late DataSnapshot carreirasDB;
bool jaPegouCarreirasDB = false;
late DataSnapshot cursosDB;
bool jaPegouCursosDB = false;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool _reverse = false;
  late List<Widget> telasHome = [
    Principal(atualizar),
    const UnivCursos(),
    const Empresas(),
    const Mais()
  ];
  bool _popupMao = false;
  bool _sumir = true;

  atualizar(int areaAtualS) {
    setState(() {
      areaAtual = areaAtualS;
    });
  }

  _init() async {
    final shp = await SharedPreferences.getInstance();
    if (!(shp.getBool("jaFoiPopupMao") ?? false)) {
      setState(() {
        _popupMao = true;
        shp.setBool("jaFoiPopupMao", true);
      });
    } else {
      _sumir = false;
    }

    if (!jaPegouCarreirasDB) {
      final ref = FirebaseDatabase.instance.ref("carreiras");
      carreirasDB = await ref.get();

      jaPegouCarreirasDB = true;
    }
    if (!jaPegouCursosDB) {
      final ref = FirebaseDatabase.instance.ref("cursos");
      cursosDB = await ref.get();

      jaPegouCursosDB = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
    indexHome = 0;
    contextHome = context;
    if (!internetIniciado && !kIsWeb) {
      connecteo.connectionStream.listen((conectado) {
        if (!conectado) {
          Navigator.pushNamed(context, "/semInternet");
        }
      });
      internetIniciado = true;
    }
    if (userFlyvoo != null) {
      password = userFlyvoo?.providerData.first.providerId == "password";
    }
    animacoesStart();
    userFlyvoo = FirebaseAuth.instance.currentUser;
    FlutterNativeSplash.remove();
    if (userFlyvoo != null) {
      CachedNetworkImage.evictFromCache(userFlyvoo!.photoURL!);
    }
  }

  @override
  void dispose() {
    animacoesDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Tema.fundo.cor(),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Tema.fundo.cor(),
          body: Stack(
            children: [
              FadeIndexedStack(
                duration: const Duration(milliseconds: 250),
                index: areaAtual,
                children: fundos.map<Widget>(
                  (e) {
                    if (e != null) {
                      return Column(
                        children: [
                          Expanded(
                            child: Image(
                              image: AssetImage(
                                dark
                                    ? "assets/background/areas_dark/esf_${e.name}.png"
                                    : "assets/background/areas/esf_${e.name}.png",
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: Image(
                              image: AssetImage(
                                dark
                                    ? "assets/background/esfumadodark.png"
                                    : "assets/background/esfumadolight.png",
                              ),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ).toList(),
              ),
              navbar(context),
              Column(
                children: [
                  const SizedBox(
                    height: 101,
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
                      child: telasHome[indexHome],
                    ),
                  ),
                ],
              ),
              _sumir
                  ? InkWell(
                      highlightColor: Colors.transparent,
                      enableFeedback: false,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      onTap: () {
                        setState(() {
                          _popupMao = false;
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              _sumir = false;
                            },
                          );
                        });
                      },
                      child: SizedBox.expand(
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _popupMao ? 1 : 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.2),
                            ),
                            child: Image.asset(
                              "assets/imagens/mao.webp",
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Container navbar(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
        color: !dark ? Tema.fundo.cor() : const Color(0xff161616),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: dark
                ? const Color.fromARGB(255, 18, 18, 18)
                : Colors.transparent,
            blurRadius: 100,
            spreadRadius: 100,
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 60,
                width: 60,
                child: InkWell(
                  splashColor: Colors.transparent,
                  onLongPress: () => Navigator.pushNamed(context, "/update"),
                  onTap: () {
                    _index0.forward();
                    _index1.reset();
                    _index2.reset();
                    _index3.reset();

                    _icon0.forward();
                    _icon1.reset();
                    _icon2.reset();
                    _icon3.reset();
                    setState(() {
                      if (indexHome < 0) {
                        _reverse = false;
                      } else {
                        _reverse = true;
                      }
                      indexHome = 0;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: _anim0.value,
                        height: _anim0.value,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          decoration: BoxDecoration(
                            color: indexHome == 0 && fundos[areaAtual] != null
                                ? fundos[areaAtual]!.navbar()
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      Icon(
                        Symbols.mountain_flag_rounded,
                        size: _animIcon0.value,
                        fill: indexHome == 0 ? 1 : 0,
                        color: indexHome == 0
                            ? Tema.fundo.cor()
                            : Tema.noFundo.cor(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 60,
                width: 60,
                child: InkWell(
                  onTap: () {
                    atualizar(0);
                    _index0.reset();
                    _index1.forward();
                    _index2.reset();
                    _index3.reset();

                    _icon0.reset();
                    _icon1.forward();
                    _icon2.reset();
                    _icon3.reset();
                    setState(() {
                      if (indexHome < 1) {
                        _reverse = false;
                      } else {
                        _reverse = true;
                      }
                      indexHome = 1;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: indexHome == 1
                              ? Tema.terciaria.cor()
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: _anim1.value,
                        height: _anim1.value,
                      ),
                      Icon(
                        Symbols.school_rounded,
                        size: _animIcon1.value,
                        fill: indexHome == 1 ? 1 : 0,
                        color: indexHome == 1
                            ? Tema.secundaria.cor()
                            : Tema.noFundo.cor(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 60,
                width: 60,
                child: InkWell(
                  onTap: () {
                    atualizar(0);
                    _index0.reset();
                    _index1.reset();
                    _index2.forward();
                    _index3.reset();

                    _icon0.reset();
                    _icon1.reset();
                    _icon2.forward();
                    _icon3.reset();
                    setState(() {
                      if (indexHome < 2) {
                        _reverse = false;
                      } else {
                        _reverse = true;
                      }
                      indexHome = 2;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: indexHome == 2
                              ? Tema.terciaria.cor()
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: _anim2.value,
                        height: _anim2.value,
                      ),
                      Icon(
                        indexHome == 2
                            ? BootstrapIcons.briefcase_fill
                            : BootstrapIcons.briefcase,
                        size: _animIcon2.value,
                        color: indexHome == 2
                            ? Tema.secundaria.cor()
                            : Tema.noFundo.cor(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: SizedBox(
                height: 60,
                width: 60,
                child: InkWell(
                  onTap: () {
                    atualizar(0);
                    _index0.reset();
                    _index1.reset();
                    _index2.reset();
                    _index3.forward();

                    _icon0.reset();
                    _icon1.reset();
                    _icon2.reset();
                    _icon3.forward();
                    setState(() {
                      if (indexHome < 3) {
                        _reverse = false;
                      } else {
                        _reverse = true;
                      }
                      indexHome = 3;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: indexHome == 3
                              ? Tema.terciaria.cor()
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: _anim3.value,
                        height: _anim3.value,
                      ),
                      Icon(
                        Symbols.settings_rounded,
                        size: _animIcon3.value,
                        fill: indexHome == 3 ? 1 : 0,
                        color: indexHome == 3
                            ? Tema.secundaria.cor()
                            : Tema.noFundo.cor(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  late AnimationController _index0;
  late Animation<double> _anim0;
  late AnimationController _index1;
  late Animation<double> _anim1;
  late AnimationController _index2;
  late Animation<double> _anim2;
  late AnimationController _index3;
  late Animation<double> _anim3;
  late AnimationController _icon0;
  late Animation<double> _animIcon0;
  late AnimationController _icon1;
  late Animation<double> _animIcon1;
  late AnimationController _icon2;
  late Animation<double> _animIcon2;
  late AnimationController _icon3;
  late Animation<double> _animIcon3;

  void animacoesStart() {
    _index0 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _anim0 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(
      CurvedAnimation(parent: _index0, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _index0.value = 60;
    _index1 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _anim1 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(
      CurvedAnimation(parent: _index1, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _index2 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _anim2 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(
      CurvedAnimation(parent: _index2, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _index3 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _anim3 = Tween<double>(
      begin: 30,
      end: 60,
    ).animate(
      CurvedAnimation(parent: _index3, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _icon0 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _animIcon0 = Tween<double>(
      begin: 45,
      end: 35,
    ).animate(
      CurvedAnimation(parent: _icon0, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _icon0.value = 35;
    _icon1 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _animIcon1 = Tween<double>(
      begin: 50,
      end: 40,
    ).animate(
      CurvedAnimation(parent: _icon1, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _icon2 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _animIcon2 = Tween<double>(
      begin: 40,
      end: 30,
    ).animate(
      CurvedAnimation(parent: _icon2, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
    _icon3 = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
    _animIcon3 = Tween<double>(
      begin: 50,
      end: 40,
    ).animate(
      CurvedAnimation(parent: _icon3, curve: Curves.easeOut),
    )..addListener(() {
        setState(() {});
      });
  }

  void animacoesDispose() {
    _index0.dispose();
    _icon0.dispose();
    _index1.dispose();
    _icon1.dispose();
    _index2.dispose();
    _icon2.dispose();
    _index3.dispose();
    _icon3.dispose();
  }
}
