import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/user.dart';
import 'package:flutter_sport_firebase/ui/screens/landing.dart';
import 'package:flutter_sport_firebase/services/auth.dart';
import 'package:flutter_sport_firebase/ui/style/app_style.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SportApp());
}

class SportApp extends StatelessWidget {
  const SportApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      initialData: null,
      value: AuthServise().currentUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sport App',
        theme: ThemeData(
          primaryColor: AppColors.backroundColor,
          textTheme: const TextTheme(
            headline6: TextStyle(color: Colors.white),
          ),
        ),
        home: const LandingPage(),
      ),
    );
  }
}
