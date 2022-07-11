// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image.asset(
              "assets/xiaomi-Mijia-Sports-Cardiogram-t-shirt-ecg-tricko-5-removebg-preview.png"),
        ),
      ),
    );
  }
}
