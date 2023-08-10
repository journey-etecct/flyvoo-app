// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  Future _init() async {
    OneSignal.initialize("8ae86c8a-3e2e-4ca6-b474-ef5c641a0e22");
    debugPrint(OneSignal.Notifications.permission.toString());
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
