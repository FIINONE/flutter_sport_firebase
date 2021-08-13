import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/ui/navigation/navigation.dart';

class HomeModel {
  void showAddWorkout(BuildContext context) {
    Navigator.pushNamed(context, NavigationRouteNames.addWorkout);
  }
}
