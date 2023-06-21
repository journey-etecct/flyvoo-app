// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignInAccount? account;

class Google extends StatefulWidget {
  const Google({super.key});

  @override
  State<Google> createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ["email", "profile", "openid"],
  );

  Future<void> _handleSignIn() async {
    try {
      _googleSignIn.signIn().then((value) async {
        if (value != null) {
          debugPrint((await value.authentication).toString());
          setState(() {
            account = value;
          });
        }
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    _handleSignIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("esse(a) aqui é voce? ${account?.displayName ?? "eita"}"),
            Image(
              image: NetworkImage(
                account?.photoUrl ??
                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
