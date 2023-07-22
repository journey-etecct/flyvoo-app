import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flyvoo/cadastro/telas_email/tela3.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

String? sexoEscolhido;
String? pronomesEscolhidos;
final _txtNome = TextEditingController();
final _txtTelefone = TextEditingController();
final _txtSexo = TextEditingController();
final _txtPronome = TextEditingController();
late DataSnapshot userInfo;
bool carregando = true;
List<String> _listaCampos = [
  "Nome",
  "Email",
  "Telefone",
  "Sexo",
  "Pronomes",
];
final List<String> sexos = [
  "Sexo",
  "Masculino",
  "Feminino",
  "Não Binário",
  "Prefiro não dizer",
];
final List<String> pronomes = [
  "Nenhum",
  "ele/dele",
  "ela/dela",
  "elu/delu",
];

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  File? _imgEscolhida;
  bool _btnAtivado = true;
  final inst = FirebaseDatabase.instance.ref("users/${userFlyvoo!.uid}");
  final instSt = FirebaseStorage.instance.ref("users/${userFlyvoo!.uid}");

  Future _deleteImageFromCache() async {
    String url = userFlyvoo!.photoURL!;
    await CachedNetworkImage.evictFromCache(url);
  }

  void _pegarInfo() async {
    setState(() {
      carregando = true;
    });
    userInfo = await inst.get();
    setState(() {
      _txtNome.text = userFlyvoo!.displayName!;
      _txtTelefone.text = userInfo.child("telefone").value.toString();
      _txtSexo.text = userInfo.child("sexo").value.toString();
      sexoEscolhido = userInfo.child("sexo").value.toString();
      _txtPronome.text = userInfo.child("pronomes").value.toString();
      pronomesEscolhidos = userInfo.child("pronomes").value.toString();
      carregando = false;
    });
  }

  @override
  void initState() {
    _pegarInfo();
    super.initState();
  }

  Future<File?> _pegarImagemGaleria() async {
    XFile? sim = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (!mounted) return null;
    if (sim == null) {
      return null;
    } else {
      var imgCortada = await ImageCropper().cropImage(
        sourcePath: sim.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '✂️Cortando...',
            hideBottomControls: true,
            toolbarColor: tema["fundo"],
            toolbarWidgetColor: tema["noFundo"],
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: tema["fundo"],
            lockAspectRatio: true,
          ),
        ],
      );
      if (imgCortada == null) {
        return null;
      } else {
        return File(imgCortada.path);
      }
    }
  }

  Future<File?> _pegarImagemCamera() async {
    XFile? sim = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    if (!mounted) return null;
    if (sim == null) {
      return null;
    } else {
      var imgCortada = await ImageCropper().cropImage(
        sourcePath: sim.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '✂️Cortando...',
            hideBottomControls: true,
            toolbarColor: tema["fundo"],
            toolbarWidgetColor: tema["noFundo"],
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: tema["fundo"],
            lockAspectRatio: true,
          ),
        ],
      );
      if (imgCortada == null) {
        return null;
      } else {
        return File(imgCortada.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      body: Stack(
        children: [
          SizedBox.expand(
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
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                child: Center(
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancelar",
                              style: GoogleFonts.inter(
                                color: CupertinoColors.systemBlue,
                              ),
                            ),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                var cortado = await _pegarImagemGaleria();
                                if (cortado != null) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  setState(() {
                                    _imgEscolhida = cortado;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      content: Text(
                                        "Imagem enviada com sucesso!",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "OK",
                                            style: GoogleFonts.inter(
                                              color: CupertinoColors.systemBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Galeria",
                                style: GoogleFonts.inter(
                                  color: CupertinoColors.systemBlue,
                                ),
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                var cortado = await _pegarImagemCamera();
                                if (cortado != null) {
                                  if (!mounted) return;
                                  Navigator.pop(context);
                                  setState(() {
                                    _imgEscolhida = cortado;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      content: Text(
                                        "Imagem enviada com sucesso!",
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "OK",
                                            style: GoogleFonts.inter(
                                              color: CupertinoColors.systemBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                "Câmera",
                                style: GoogleFonts.inter(
                                  color: CupertinoColors.systemBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipOval(
                          child: _imgEscolhida == null
                              ? CachedNetworkImage(
                                  imageUrl: userFlyvoo!.photoURL!,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _imgEscolhida!,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: tema["texto"],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Symbols.camera_alt,
                            color: dark ? Colors.black : Colors.white,
                            size: 35,
                            opticalSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: !carregando
                    ? ListView.builder(
                        itemBuilder: (context, index) => CampoEdicao(
                          campo: _listaCampos[index],
                          index: index,
                        ),
                        itemCount: _listaCampos.length,
                        shrinkWrap: true,
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: tema["texto"],
                        ),
                      ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 5),
                          color: const Color(
                            0xff000000,
                          ).withOpacity(0.25),
                        ),
                      ],
                    ),
                    height: 43,
                    width: 129,
                    child: CupertinoButton(
                      borderRadius: BorderRadius.circular(10),
                      onPressed: () => Navigator.pop(context),
                      color: Colors.white,
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 0,
                          offset: const Offset(0, 5),
                          color: const Color(
                            0xff000000,
                          ).withOpacity(0.25),
                        ),
                      ],
                    ),
                    height: 43,
                    width: 129,
                    child: CupertinoButton(
                      onPressed: _btnAtivado
                          ? () async {
                              setState(() {
                                _btnAtivado = false;
                              });
                              if (_imgEscolhida != null) {
                                await instSt.putFile(_imgEscolhida!);
                                await _deleteImageFromCache();
                                if (userFlyvoo!.providerData.first.providerId !=
                                    "password") {
                                  await userFlyvoo!.updatePhotoURL(
                                    "https://firebasestorage.googleapis.com/v0/b/flyvoo.appspot.com/o/users%2F${userFlyvoo?.uid}?alt=media",
                                  );
                                }
                              }
                              await userFlyvoo
                                  ?.updateDisplayName(_txtNome.text);
                              await inst.update({
                                "telefone": _txtTelefone.text,
                                "sexo": _txtSexo.text,
                                "pronomes": _txtPronome.text,
                              });
                              setState(() {
                                _btnAtivado = true;
                              });
                              if (!mounted) return;
                              showDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                  content: Text(
                                    "Informações atualizadas com sucesso",
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                    ),
                                  ),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "OK",
                                        style: GoogleFonts.inter(
                                          color: CupertinoColors.systemBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          : null,
                      padding: const EdgeInsets.all(0),
                      color: const Color(0xffF81B50),
                      borderRadius: BorderRadius.circular(10),
                      child: Text(
                        "Salvar",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class CampoEdicao extends StatefulWidget {
  final String campo;
  final int index;
  const CampoEdicao({super.key, required this.campo, required this.index});

  @override
  State<CampoEdicao> createState() => _CampoEdicaoState();
}

class _CampoEdicaoState extends State<CampoEdicao> {
  final _keyNome = GlobalKey<FormFieldState>();
  final _keyTelefone = GlobalKey<FormFieldState>();

  String _camposSwitch() {
    switch (widget.index) {
      case 0:
        return _txtNome.text;
      case 1:
        return userFlyvoo!.email!;
      case 2:
        return _txtTelefone.text;
      case 3:
        return _txtSexo.text;
      case 4:
        return _txtPronome.text;
      default:
        return "";
    }
  }

  TextEditingController _txtCamposSwitch() {
    switch (widget.index) {
      case 0:
        return _txtNome;
      case 2:
        return _txtTelefone;
      default:
        return TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.campo != "Email"
          ? () {
              var txtAntigo = _camposSwitch();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                  child: Theme(
                    data: ThemeData(
                      useMaterial3: true,
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: const Color(0xff0000ff),
                        brightness: dark ? Brightness.dark : Brightness.light,
                      ),
                    ),
                    child: AlertDialog(
                      alignment: Alignment.bottomCenter,
                      backgroundColor: tema["fundo"],
                      title: Text(widget.campo),
                      content: switch (widget.index) {
                        0 => TextFormField(
                            key: _keyNome,
                            controller: _txtNome,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autofillHints: const [AutofillHints.name],
                            cursorColor: ColorScheme.fromSeed(
                              seedColor: const Color(0xff0000ff),
                              brightness:
                                  dark ? Brightness.dark : Brightness.light,
                            ).primary,
                          ),
                        2 => TextFormField(
                            key: _keyTelefone,
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
                            autofillHints: const [
                              AutofillHints.telephoneNumberNational
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: const InputDecoration(
                              prefixText: "+55 ",
                            ),
                            cursorColor: ColorScheme.fromSeed(
                              seedColor: const Color(0xff0000ff),
                              brightness:
                                  dark ? Brightness.dark : Brightness.light,
                            ).primary,
                            inputFormatters: [
                              PhoneInputFormatter(
                                defaultCountryCode: "BR",
                              ),
                            ],
                          ),
                        3 => DropdownButtonFormField(
                            value: sexoEscolhido,
                            dropdownColor: tema["fundo"],
                            elevation: 1,
                            style: GoogleFonts.inter(
                              color: tema["noFundo"],
                              fontSize: 20,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            icon: Image.asset(
                              "assets/icons/seta.png",
                              color: tema["noFundo"],
                            ),
                            selectedItemBuilder: (context) => sexos
                                .map(
                                  (e) => Text(
                                    e,
                                  ),
                                )
                                .toList(),
                            validator: (value) {
                              if (value == sexos.first) {
                                return "*Obrigatório";
                              }
                              return null;
                            },
                            items: sexos
                                .map(
                                  (String pele) => DropdownMenuItem<String>(
                                    value: pele,
                                    enabled: pele != sexos.first,
                                    child: Text(pele),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  sexoEscolhido = value;
                                });
                              }
                            },
                          ),
                        4 => DropdownButtonFormField(
                            value: pronomesEscolhidos,
                            dropdownColor: tema["fundo"],
                            elevation: 1,
                            style: GoogleFonts.inter(
                              color: tema["noFundo"],
                              fontSize: 20,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            icon: Image.asset(
                              "assets/icons/seta.png",
                              color: tema["noFundo"],
                            ),
                            selectedItemBuilder: (context) => pronomes
                                .map(
                                  (e) => Text(
                                    e,
                                  ),
                                )
                                .toList(),
                            items: pronomes
                                .map(
                                  (String pele) => DropdownMenuItem<String>(
                                    value: pele,
                                    child: Text(pele),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  pronomesEscolhidos = value;
                                });
                              }
                            },
                          ),
                        _ => TextFormField(
                            controller: _txtNome,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            autofillHints: const [AutofillHints.name],
                            decoration: InputDecoration(
                              labelText: "Nome Completo",
                              labelStyle: GoogleFonts.inter(
                                fontSize: 20,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: tema["primaria"]!,
                                ),
                              ),
                            ),
                            cursorColor: tema["primaria"],
                          ),
                      },
                      /* TextField(
                        controller: switch (widget.index) {
                          0 => _txtNome,
                          2 => _txtTelefone,
                          3 => _txtSexo,
                          4 => _txtPronome,
                          _ => _txtNome
                        },

                      ), */
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await Future.delayed(
                              const Duration(
                                milliseconds: 500,
                              ),
                            );
                            setState(() {
                              _txtCamposSwitch().text = txtAntigo;
                              if (widget.index == 3) {
                                sexoEscolhido = txtAntigo;
                              }
                              if (widget.index == 4) {
                                pronomesEscolhidos = txtAntigo;
                              }
                            });
                          },
                          child: const Text("Cancelar"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            setState(() {
                              _txtCamposSwitch().text = _txtCamposSwitch().text;
                              if (widget.index == 3) {
                                _txtSexo.text = sexoEscolhido!;
                              }
                              if (widget.index == 4) {
                                _txtPronome.text = pronomesEscolhidos!;
                              }
                            });
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          : null,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        width: double.infinity,
        height: 66,
        margin: const EdgeInsets.only(
          left: 25,
          right: 25,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: tema["texto"]!,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.campo,
                      style: GoogleFonts.inter(
                        color: tema["texto"],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _camposSwitch(),
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.inter(
                        color: tema["texto"],
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            widget.campo != "Email"
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                    child: Icon(
                      Bootstrap.pencil_fill,
                      color: tema["texto"],
                    ),
                  )
                : const Row(),
          ],
        ),
      ),
    );
  }
}
