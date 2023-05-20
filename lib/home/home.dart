// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tema["fundo"],
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 71),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    constraints: BoxConstraints(minHeight: 70),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text("data"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
