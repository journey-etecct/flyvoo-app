import 'package:flutter/material.dart';
import 'package:flyvoo/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          dark ? temaDark["cores"]["fundo"] : temaLight["cores"]["fundo"],
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: const Image(
                  image: AssetImage("assets/logo.png"),
                  width: 242,
                  height: 242,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Login",
                  border: UnderlineInputBorder(),
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: UnderlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
