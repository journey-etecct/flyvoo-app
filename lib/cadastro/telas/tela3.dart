// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/cadastro/telas/cadastro.dart';
import 'package:flyvoo/tema.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

final ImagePicker picker = ImagePicker();

class Tela3 extends StatefulWidget {
  const Tela3({super.key});

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
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
            toolbarColor: dark ? Color(0xff157567) : Color(0xffffe1d0),
            toolbarWidgetColor: tema["textoBotaoIndex"],
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: dark ? Color(0xff157567) : Color(0xffffe1d0),
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
            toolbarColor: dark ? Color(0xff157567) : Color(0xffffe1d0),
            toolbarWidgetColor: tema["textoBotaoIndex"],
            initAspectRatio: CropAspectRatioPreset.square,
            statusBarColor: dark ? Color(0xff157567) : Color(0xffffe1d0),
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
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () async {
                        var cortado = await _pegarImagemGaleria();
                        if (cortado != null) {
                          setState(() {
                            userImg = cortado;
                            btnAtivado = true;
                          });
                          if (!mounted) return;
                          Navigator.pop(context);
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
                          setState(() {
                            userImg = cortado;
                            btnAtivado = true;
                          });
                          if (!mounted) return;
                          Navigator.pop(context);
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
                userImg != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: FileImage(userImg!),
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image(
                        image: AssetImage("assets/icons/user.png"),
                        color: tema["texto"],
                        width: 200,
                        fit: BoxFit.cover,
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
          SizedBox(
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
