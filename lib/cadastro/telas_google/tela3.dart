import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/cadastro.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

final ImagePicker picker = ImagePicker();

class TelaGoogle3 extends StatefulWidget {
  const TelaGoogle3({super.key});

  @override
  State<TelaGoogle3> createState() => _TelaGoogle3State();
}

class _TelaGoogle3State extends State<TelaGoogle3> {
  Future<XFile?> _pegarImagemGaleria() async {
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
            toolbarColor:
                dark ? const Color(0xff157567) : const Color(0xffffe1d0),
            toolbarWidgetColor: Tema.textoBotaoIndex.cor(),
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor:
                dark ? const Color(0xff157567) : const Color(0xffffe1d0),
            lockAspectRatio: true,
          ),
          WebUiSettings(context: context),
        ],
      );
      if (imgCortada == null) {
        return null;
      } else {
        return XFile(imgCortada.path);
      }
    }
  }

  Future<XFile?> _pegarImagemCamera() async {
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
            toolbarColor:
                dark ? const Color(0xff157567) : const Color(0xffffe1d0),
            toolbarWidgetColor: Tema.textoBotaoIndex.cor(),
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor:
                dark ? const Color(0xff157567) : const Color(0xffffe1d0),
            lockAspectRatio: true,
          ),
        ],
      );
      if (imgCortada == null) {
        return null;
      } else {
        return XFile(imgCortada.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          InkWell(
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
                  actions: !kIsWeb
                      ? [
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              var cortado = await _pegarImagemGaleria();
                              if (cortado != null) {
                                if (!mounted) return;
                                Navigator.pop(context);
                                setState(() {
                                  userImg = cortado;
                                  btnAtivado = true;
                                });
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: CupertinoAlertDialog(
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
                                  userImg = cortado;
                                });
                                await showCupertinoDialog(
                                  context: context,
                                  builder: (context) => BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: CupertinoAlertDialog(
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
                                  ),
                                );
                                setStateBotao(() {
                                  btnAtivado = true;
                                });
                              }
                            },
                            child: Text(
                              "Câmera",
                              style: GoogleFonts.inter(
                                color: CupertinoColors.systemBlue,
                              ),
                            ),
                          ),
                        ]
                      : [
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              var cortado = await _pegarImagemGaleria();
                              if (cortado != null) {
                                if (!mounted) return;
                                Navigator.pop(context);
                                setState(() {
                                  userImg = cortado;
                                  btnAtivado = true;
                                });
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) => BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                    child: CupertinoAlertDialog(
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
                        ],
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                userImg != null
                    ? ClipOval(
                        child: Image(
                          image: kIsWeb
                              ? NetworkImage(userImg!.path)
                              : FileImage(File(userImg!.path)) as ImageProvider,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: userFlyvoo!.photoURL != null
                            ? FadeInImage(
                                placeholder: const AssetImage(
                                  "assets/background/loading.gif",
                                ),
                                image: CachedNetworkImageProvider(
                                  userFlyvoo!.photoURL!,
                                ),
                                width: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "assets/icons/user.png",
                                width: 200,
                                fit: BoxFit.cover,
                                color: Tema.texto.cor(),
                              ),
                      ),
                Container(
                  width: 65,
                  height: 65,
                  decoration: BoxDecoration(
                    color: Tema.texto.cor(),
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
          const SizedBox(
            height: 25,
          ),
          Text(
            "Se mostre para o mundo,\nselecione uma foto\npara seu perfil",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
