import 'package:flutter/material.dart';

import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:flutter_sport_firebase/ui/navigation/navigation.dart';

class AddWorkoutModel extends ChangeNotifier {
  AddWorkoutModel();

  final globalKey = GlobalKey<FormState>();

  String _titleText = '';
  set titleText(String value) {
    _titleText = value;
  }

  String? _errorText;
  String? get errorText => _errorText;
  // set errorText(String text) {}

  String? levelSelect;
  List<String> levelFilter = const <String>[
    'Elementary',
    'Intermediate',
    'Advanced',
  ];

  final WorkoutSchedule _workoutSchedule = WorkoutSchedule(week: []);
  WorkoutSchedule get workoutSchedule => _workoutSchedule;

  void save() {
    if (_titleText.isEmpty) {
      _errorText = 'Please fill out this field';
      notifyListeners();
      return;
    }
    _errorText = null;
    notifyListeners();
  }

  Future<void> addWorkoutWeek(BuildContext context) async {
    final newWeek = await Navigator.of(context).pushNamed<WorkoutWeek>(
      NavigationRouteNames.addWorkoutWeek,
    );
    if (newWeek != null) {
      _workoutSchedule.week.add(newWeek);
      notifyListeners();
    }
  }

  Future<void> changeWorkoutWeek(
      {required int indexWeek, required BuildContext context}) async {
    final changeWeek = await Navigator.of(context).pushNamed<WorkoutWeek>(
      NavigationRouteNames.addWorkoutWeek,
      arguments: _workoutSchedule.week[indexWeek],
    );
    if (changeWeek != null) {
      _workoutSchedule.week[indexWeek] = changeWeek;
      notifyListeners();
    }
  }
}
