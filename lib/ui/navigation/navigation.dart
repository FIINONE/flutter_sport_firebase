import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:flutter_sport_firebase/ui/screens/add_workout.dart';
import 'package:flutter_sport_firebase/ui/screens/add_workout_day.dart';
import 'package:flutter_sport_firebase/ui/screens/add_workout_week.dart';
import 'package:flutter_sport_firebase/ui/screens/auth.dart';
import 'package:flutter_sport_firebase/ui/screens/home.dart';

abstract class NavigationRouteNames {
  static const String landing = 'landing';
  static const String auth = 'auth';
  static const String home = 'home/';
  static const String addWorkout = 'home/addWorkout';
  static const String addWorkoutWeek = 'home/addWorkout/week';
  static const String addWorkoutDay = 'home/addWorkout/week/day';
}

class MainNavigation {
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRouteNames.auth: (BuildContext context) => const AuthPage(),
    NavigationRouteNames.home: (BuildContext context) => const HomePage(),
    NavigationRouteNames.addWorkout: (BuildContext context) =>
        const AddWorkoutPage(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRouteNames.addWorkoutDay:
        final argument = settings.arguments;
        final WorkoutWeekDay weekDay = argument! as WorkoutWeekDay;
        return MaterialPageRoute<WorkoutWeekDay>(
          builder: (BuildContext context) {
            return AddworkoutDayScreen(day: weekDay);
          },
        );
      case NavigationRouteNames.addWorkoutWeek:
        final argument = settings.arguments;
        if (argument == null) {
          return MaterialPageRoute<WorkoutWeek>(
              builder: (BuildContext context) {
            return const AddWorkoutWeekScreen(week: null);
          });
        }
        final week = argument as WorkoutWeek;
        return MaterialPageRoute<WorkoutWeek>(
          builder: (BuildContext context) {
            return AddWorkoutWeekScreen(week: week);
          },
        );
      default:
        return MaterialPageRoute(
          builder: (BuildContext context) {
            return const HomePage();
          },
        );
    }
  }

  // String initialRoute(bool isAuth) {
  //   // final UserModel? userModel = Provider.of<UserModel?>(context);
  //   // final bool isAuth = userModel != null;
  //   if (isAuth) {
  //     return NavigationRouteNames.home;
  //   } else {}
  //   return NavigationRouteNames.auth;
  // }

  // Route onGenerateInitialRoutes(bool isAuth) {
  //   if (isAuth) {
  //     return MaterialPageRoute<Object>(builder: (_) {
  //       return const HomePage();
  //     });
  //   }
  //   return MaterialPageRoute<Object>(builder: (_) {
  //     return const AuthPage();
  //   });
  // }

}
