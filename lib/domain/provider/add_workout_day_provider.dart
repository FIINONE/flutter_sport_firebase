import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_sport_firebase/model/workout.dart';

class AddWorkoutDayProvider extends ChangeNotifier {
  final globalKey = GlobalKey<FormState>();

  AddWorkoutDayProvider({
    required this.day,
  }) {
    if (day.drillBlocks.isNotEmpty) {
      _workoutWeekDay = day.copy();
      notifyListeners();
    } else {
      _createSingleBlockInStart();
    }
  }

  final WorkoutWeekDay day;

  String? drillTypeSelect = 'SINGLE';
  final List<String> drillType = [
    'SINGLE',
    'MULTISET',
    'AMRAP',
    'ForTime',
    'EMOM',
    'REST',
  ];

  String numberBlocksSelect = '2 Drill';
  final List<String> numberBlocksList = [
    '1 Drill',
    '2 Drill',
    '3 Drill',
    '4 Drill',
    '5 Drill',
  ];

  int _parseStringToInt() {
    final splitText = numberBlocksSelect.split(' ');
    final numberText = splitText.first;
    final numberBlock = int.parse(numberText);
    return numberBlock;
  }

  void changeDrillCount(int index) {
    final numberBlock = _parseStringToInt();
    workoutWeekDay.drillBlocks[index].changeDrillCount(numberBlock);
    notifyListeners();
  }

  WorkoutWeekDay _workoutWeekDay = WorkoutWeekDay(drillBlocks: []);
  WorkoutWeekDay get workoutWeekDay => _workoutWeekDay;

  String? drillBlockGetParam({required int index, required String paramName}) {
    final WorkoutDrillsBlock block = _workoutWeekDay.drillBlocks[index];
    if (block is WorkoutAmrapDrillBlock) {
      if (block.minutes == null) {
        return null;
      } else {
        return block.minutes.toString();
      }
    }
    if (block is WorkoutForTimeDrillBlock) {
      if (paramName == 'Rounds*') {
        if (block.rounds == null) {
          return null;
        } else {
          return block.rounds.toString();
        }
      }
      if (paramName == 'Time Cap in Minutes*') {
        if (block.timeCapMin == null) {
          return null;
        } else {
          return block.timeCapMin.toString();
        }
      }
      if (paramName == 'Rest Between Rounds in Minutes*') {
        if (block.restBetweenRoundsMin == null) {
          return null;
        } else {
          return block.restBetweenRoundsMin.toString();
        }
      }
    }
    if (block is WorkoutEmomDrillBlock) {
      if (paramName == 'Interval in Minutes*') {
        if (block.intervalMin == null) {
          return null;
        } else {
          return block.intervalMin.toString();
        }
      }
      if (paramName == 'Time Cap in Minutes*') {
        if (block.timeCapMin == null) {
          return null;
        } else {
          return block.timeCapMin.toString();
        }
      }
    }
  }

  void drillBlockSetParam(
      {required int index, required String paramName, required String text}) {
    if (text.isEmpty) {
      return;
    }
    final WorkoutDrillsBlock block = _workoutWeekDay.drillBlocks[index];
    if (block is WorkoutAmrapDrillBlock) {
      final number = int.parse(text);
      block.minutes = number;
    }
    if (block is WorkoutForTimeDrillBlock) {
      if (paramName == 'Rounds*') {
        final number = int.parse(text);
        block.rounds = number;
      }
      if (paramName == 'Time Cap in Minutes*') {
        final number = int.parse(text);
        block.timeCapMin = number;
      }
      if (paramName == 'Rest Between Rounds in Minutes*') {
        final number = int.parse(text);
        block.restBetweenRoundsMin = number;
      }
    }
    if (block is WorkoutEmomDrillBlock) {
      if (paramName == 'Interval in Minutes*') {
        final number = int.parse(text);
        block.intervalMin = number;
      }
      if (paramName == 'Time Cap in Minutes*') {
        final number = int.parse(text);
        block.timeCapMin = number;
      }
    }
  }

  void _createSingleBlockInStart() {
    _workoutWeekDay.drillBlocks
        .add(WorkoutSingleDrillBlock(drill: WorkoutDrill()));
  }

  void addWorkoutDrillBlock(BuildContext context) {
    WorkoutDrillsBlock? newBlock;
    switch (drillTypeSelect) {
      case 'SINGLE':
        newBlock = WorkoutSingleDrillBlock(drill: WorkoutDrill());
        break;

      case 'MULTISET':
        newBlock =
            WorkoutMultiDrillBlock(drills: [WorkoutDrill(), WorkoutDrill()]);
        break;
      case 'AMRAP':
        newBlock = WorkoutAmrapDrillBlock(
            drills: [WorkoutDrill(), WorkoutDrill()], minutes: null);
        break;
      case 'ForTime':
        newBlock = WorkoutForTimeDrillBlock(
          drills: [WorkoutDrill(), WorkoutDrill()],
          restBetweenRoundsMin: null,
          rounds: null,
          timeCapMin: null,
        );
        break;
      case 'EMOM':
        newBlock = WorkoutEmomDrillBlock(
          drills: [WorkoutDrill(), WorkoutDrill()],
          intervalMin: null,
          timeCapMin: null,
        );
        break;
      case 'REST':
        newBlock = WorkoutRestDrillBlock(timeMin: 1);
        break;
    }
    if (newBlock != null) {
      _workoutWeekDay.drillBlocks.add(newBlock);
      notifyListeners();
    }
    Navigator.pop(context);
    return;
  }

  void save(BuildContext context) {
    if (globalKey.currentState!.validate()) {
      if (_workoutWeekDay.drillBlocks.isNotEmpty) {
        if (_workoutWeekDay.drillBlocks
                .whereType<WorkoutRestDrillBlock>()
                .length ==
            _workoutWeekDay.drillBlocks.length) {
          Fluttertoast.showToast(msg: 'Please add at least one Drill');
          return;
        }
        Navigator.of(context).pop(_workoutWeekDay);
      } else {
        Fluttertoast.showToast(msg: 'Please add at least one Drill');
        return;
      }
    } else {
      Fluttertoast.showToast(msg: 'Ooops! Something is not right');
    }
  }

  void removeDrillBlock(int index) {
    _workoutWeekDay.drillBlocks.remove(_workoutWeekDay.drillBlocks[index]);
    notifyListeners();
  }
}
