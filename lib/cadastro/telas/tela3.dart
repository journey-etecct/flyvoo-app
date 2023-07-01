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
  Future<CroppedFile?> _pegarImagem() async {
    XFile? sim = await picker.pickImage(source: ImageSource.gallery);
    if (!mounted) return null;
    if (sim == null) {
      return null;
    } else {
      CroppedFile? imgCortada = await ImageCropper().cropImage(
        sourcePath: sim.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: '✂️Cortando...',
            hideBottomControls: true,
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Theme.of(context).colorScheme.onPrimary,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: Theme.of(context).colorScheme.onPrimary,
            statusBarColor: Theme.of(context).colorScheme.primary,
            lockAspectRatio: true,
          ),
        ],
      );
      if (imgCortada == null) {
        return null;
      } else {
        return imgCortada;
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
                        var cortado = await _pegarImagem();
                        if (cortado != null) {
                          userImg = File(cortado.path);
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
                      onPressed: () async {},
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
                Image(
                  image: AssetImage("assets/icons/user.png"),
                  color: tema["texto"],
                  width: 180,
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
