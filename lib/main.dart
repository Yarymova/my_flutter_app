import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Импортируем стартовый экран
import 'constants/constants.dart'; // Импортируем константы

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: myColor, // Используем основной цвет
      ),
      home: const SplashScreen(),
    );
  }
}
