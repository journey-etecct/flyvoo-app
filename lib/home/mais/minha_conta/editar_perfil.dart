// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:flyvoo/tema.dart';

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({super.key});

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
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
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            height: 170,
            child: Row(
              children: [
                ClipOval(
                  child: Image(
                    width: 100,
                    image: CachedNetworkImageProvider(
                      userFlyvoo!.photoURL!,
                    ),
                  ),
                ),
                Column(
                  children: [],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
