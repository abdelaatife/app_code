import 'package:app/home.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenView(
        navigateRoute: const home(),
        duration: 4000,
        imageSize: 500,
        text: "Welcome to ECG T-shirt",
        imageSrc:
            "assets/xiaomi-Mijia-Sports-Cardiogram-t-shirt-ecg-tricko-5-removebg-preview.png",
        backgroundColor: Colors.white,
        pageRouteTransition: PageRouteTransition.SlideTransition,
        textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      )));
}
