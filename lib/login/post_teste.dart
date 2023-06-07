import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteCoiso extends StatefulWidget {
  const TesteCoiso({super.key});

  @override
  State<TesteCoiso> createState() => _TesteCoisoState();
}

class _TesteCoisoState extends State<TesteCoiso> {
  final _txtPost = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _txtPost,
            ),
            FilledButton(
              onPressed: () {
                Map<String, String> body = {"meudeus": _txtPost.text};
                http
                    .post(
                  Uri.parse(
                    "https://etec199-danilolima.xp3.biz/2023/testepost/index.php",
                  ),
                  body: body,
                )
                    .then(
                  (value) {
                    Flushbar(
                      message: "resposta: ${value.body}",
                      duration: const Duration(seconds: 3),
                      flushbarStyle: FlushbarStyle.FLOATING,
                    ).show(context);
                  },
                );
              },
              child: const Text(
                "enviar",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
