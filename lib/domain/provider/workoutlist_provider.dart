import 'package:flutter/material.dart';

class WorkoutListModel extends ChangeNotifier {
  // final Random _random = Random();
  // int _value = 0;
  // ValueKey<String>? _valueKey;
  // ValueKey<String>? get valueKey => _valueKey;
  bool _isOpen = false;
  bool get isOpen => _isOpen;
  set togglePanel(bool state) {
    _isOpen = state;
    // notifyListeners();
  }

  List<String> levelFilter = const <String>[
    'Any Level',
    'Elementary',
    'Intermediate',
    'Advanced',
  ];
  String? levelSelect = 'Any Level';

  String _expansionTitleMyWorkouts = 'Any Workouts';
  String get myWorkouts => _expansionTitleMyWorkouts;

  String searchTitle = '';
  // String get searchTitle => _searchTitle;

  // set searchTitle(String value) {
  //   if (value.isEmpty) {
  //     return;
  //   }
  //   _searchTitle = value;
  // }

  bool switchState = false;
  set toggleSwitch(bool state) {
    switchState = state;
    notifyListeners();
  }

  void toggleOpen() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void applyPressed() {
    if (switchState == true) {
      _expansionTitleMyWorkouts = 'My Workouts';
    }
    if (switchState == false) {
      _expansionTitleMyWorkouts = 'Any Workouts';
    }

    // _value = _random.nextInt(100);
    // _valueKey = ValueKey<String>('$_value');
    _isOpen = false;
    notifyListeners();

    // _searchTitle = _searchTitle.isNotEmpty ? ' / $_searchTitle' : '';
    return;
  }

  void clearPressed() {
    searchTitle = '';
    switchState = false;
    _expansionTitleMyWorkouts = 'Any Workouts';
    levelSelect = 'Any Level';
    // _value = _random.nextInt(100);
    // _valueKey = ValueKey<String>('$_value');
    _isOpen = false;
    notifyListeners();
  }
}
