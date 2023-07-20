// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/telas/tela3.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  File? _imgEscolhida;

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
                child: Column(),
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
                      onPressed: () {},
                      color: Colors.white,
                      padding: EdgeInsets.all(0),
                      child: Text(
                        "Cancelar",
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
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
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      color: Color(0xffF81B50),
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
              SizedBox(
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
  const CampoEdicao({super.key});

  @override
  State<CampoEdicao> createState() => _CampoEdicaoState();
}

class _CampoEdicaoState extends State<CampoEdicao> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
