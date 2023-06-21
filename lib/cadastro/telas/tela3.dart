// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';
import 'package:material_symbols_icons/symbols.dart';

class Tela3 extends StatefulWidget {
  const Tela3({super.key});

  @override
  State<Tela3> createState() => _Tela3State();
}

class _Tela3State extends State<Tela3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
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
                  size: 40,
                  opticalSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
