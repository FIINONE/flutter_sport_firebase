import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/screens/auth.dart';
import 'package:flutter_sport_firebase/screens/home.dart';

void main() {
  runApp(const SportApp());
}

class SportApp extends StatelessWidget {
  const SportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport App',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(50, 65, 85, 1),
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      home: const AuthPage(),
    );
  }
}
