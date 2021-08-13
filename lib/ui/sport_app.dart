import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/domain/provider/home_provider.dart';
import 'package:flutter_sport_firebase/ui/navigation/navigation.dart';
import 'package:flutter_sport_firebase/ui/screens/auth.dart';
import 'package:flutter_sport_firebase/ui/screens/home.dart';
// import 'package:flutter_sport_firebase/ui/screens/landing.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sport_firebase/model/user.dart';
import 'package:flutter_sport_firebase/data/services/auth.dart';
import 'package:flutter_sport_firebase/ui/style/app_style.dart';

class SportApp extends StatelessWidget {
  static final _navigation = MainNavigation();
  // final StreamProvider<UserModel?>  model;

  const SportApp({
    Key? key,
    // required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder<UserModel?>(
    //     initialData: null,
    //     stream: AuthServise().currentUser,
    //     builder: (context, snapshot) {
    //       final isAuth = snapshot.hasData;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sport App',
      theme: ThemeData(
        primaryColor: AppColors.backroundColor,
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.white),
        ),
      ),
      routes: _navigation.routes,
      onGenerateRoute: (RouteSettings setting) =>
          _navigation.onGenerateRoute(setting),
      // initialRoute: _navigation.initialRoute(isAuth),
      // onGenerateInitialRoutes: (text) {
      //   return [
      //     _navigation.onGenerateInitialRoutes(isAuth),
      //   ];
      // },
      home: const LandingPage(),
    );
    // }else
    //   return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Sport App',
    //     theme: ThemeData(
    //       primaryColor: AppColors.backroundColor,
    //       textTheme: const TextTheme(
    //         headline6: TextStyle(color: Colors.white),
    //       ),
    //     ),
    //     routes: _navigation.routes,
    //     initialRoute: NavigationRouteNames.auth,
    //   );
    // },
    // );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: AuthServise().currentUser,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Provider<HomeModel>(
            create: (context) => HomeModel(),
            child: const HomePage(),
          );
        }
        return const AuthPage();
      },
    );
  }
}
