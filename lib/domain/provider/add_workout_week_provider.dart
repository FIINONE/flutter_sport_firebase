import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:flutter_sport_firebase/ui/navigation/navigation.dart';

class AddWorkoutWeekModel extends ChangeNotifier {
  AddWorkoutWeekModel({required this.week}) {
    if (week != null) {
      _workoutWeek = week!.copy();
    } else {
      _workoutWeek.days = [
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
        WorkoutWeekDay(drillBlocks: []),
      ];
    }
  }
  final WorkoutWeek? week;

  WorkoutWeek _workoutWeek = WorkoutWeek(days: [], notes: '');
  WorkoutWeek get workoutWeek => _workoutWeek;

  // void _initState() {
  //   if () {

  //   }
  //   _workoutWeek.days = [

  //   ];
  // }

  Future<void> showWorkoutDay(BuildContext context, int index) async {
    final workoutWeekDay =
        await Navigator.of(context).pushNamed<WorkoutWeekDay>(
      NavigationRouteNames.addWorkoutDay,
      arguments: _workoutWeek.days[index],
    );
    if (workoutWeekDay != null) {
      _workoutWeek.days[index] = workoutWeekDay;
      notifyListeners();
    }
  }

  void save(BuildContext context) {
    if (_workoutWeek.days.isNotEmpty) {
      Navigator.of(context).pop(_workoutWeek);
    }
  }

  String currentTime(int index) {
    final int currentDay = DateTime.now().millisecondsSinceEpoch;
    final DateTime allDay =
        DateTime.fromMillisecondsSinceEpoch(currentDay + index * 86400000);
    final int dayofWeek = allDay.weekday;
    final int dayNum = allDay.day;

    final String weekday;
    switch (dayofWeek) {
      case 1:
        weekday = 'Monday';
        break;
      case 2:
        weekday = 'Tuesday';
        break;
      case 3:
        weekday = 'Wednesday';
        break;
      case 4:
        weekday = 'Thursday';
        break;
      case 5:
        weekday = 'Friday';
        break;
      case 6:
        weekday = 'Saturday';
        break;
      case 7:
        weekday = 'Sunday';
        break;
      default:
        weekday = '';
    }
    return '$weekday, $dayNum';
  }
}
