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
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor:
            dark ? temaDark["cores"]["fundo"] : temaLight["cores"]["fundo"],
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    enabledBorder: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  autofillHints: const [AutofillHints.password],
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
      ),
    );
  }
}
