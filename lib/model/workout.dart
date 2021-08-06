class Workout {
  String title;
  String author;
  String description;
  String level;

  Workout({
    required this.title,
    required this.author,
    required this.description,
    required this.level,
  });
}

class WorkputSchedule {
  List<WorkoutWeek> week;

  WorkputSchedule({
    required this.week,
  });

  WorkputSchedule copy() {
    final List<WorkoutWeek> copiedWeek = week.map((w) => w.copy()).toList();
    return WorkputSchedule(
      week: copiedWeek,
    );
  }
}

class WorkoutWeek {
  String notes;
  List<WorkoutWeekDay> days;

  int get daysWithDrills =>
      days != null ? days.where((d) => d.isSet).length : 0;

  WorkoutWeek({
    required this.notes,
    required this.days,
  });

  WorkoutWeek copy() {
    final copiedDays = days.map((d) => d.copy()).toList();
    return WorkoutWeek(
      notes: notes,
      days: copiedDays,
    );
  }
}

class WorkoutWeekDay {
  String notes;
  List<WorkoutDrillsBlock> drillBlocks;

  bool get isSet => drillBlocks != null && drillBlocks.length > 0;
  
  int get notRestDrillBlocksCount =>
      isSet ? drillBlocks.where((b) => b is! WorkoutRestDrillBlock).length : 0;

  WorkoutWeekDay({
    required this.notes,
    required this.drillBlocks,
  });

  WorkoutWeekDay copy() {
    final copiedDrillBlocks = drillBlocks.map((w) => w.copy()).toList();
    return WorkoutWeekDay(notes: notes, drillBlocks: copiedDrillBlocks);
  }
}

abstract class WorkoutDrillsBlock {
  WorkoutDrillType type;
  List<WorkoutDrill> drills;

  WorkoutDrillsBlock({
    required this.type,
    required this.drills,
  });

  void changeDrillCount(int count) {
    final diff = count - drills.length;
    if (diff == 0) {
      return;
    }

    if (diff > 0) {
      for (var i = 0; i < diff; i++) {
        drills.add(WorkoutDrill(
          title: drills[i].title,
          weight: drills[i].weight,
          set: drills[i].set,
          peps: drills[i].peps,
        ));
      }
    } else {
      drills = drills.sublist(0, drills.length + diff);
    }
  }

  WorkoutDrillsBlock copy();

  List<WorkoutDrill> copyDrills() {
    return drills.map((w) => w.copy()).toList();
  }
}

class WorkoutDrill {
  String title;
  String weight;
  int set;
  int peps;

  WorkoutDrill({
    required this.title,
    required this.weight,
    required this.set,
    required this.peps,
  });

  WorkoutDrill copy() {
    return WorkoutDrill(title: title, weight: weight, set: set, peps: peps);
  }
}

enum WorkoutDrillType {
  SINGLE,
  MULTISET,
  AMRAP,
  ForTime,
  EMOM,
  REST,
  //TABATA,
}

class WorkoutSingleDrillBlock extends WorkoutDrillsBlock {
  WorkoutSingleDrillBlock({required WorkoutDrill drill})
      : super(
          drills: [drill],
          type: WorkoutDrillType.SINGLE,
        );

  @override
  WorkoutSingleDrillBlock copy() {
    return WorkoutSingleDrillBlock(drill: copyDrills().first);
  }
}

class WorkoutMultiDrillBlock extends WorkoutDrillsBlock {
  WorkoutMultiDrillBlock({required List<WorkoutDrill> drills})
      : super(
          drills: drills,
          type: WorkoutDrillType.MULTISET,
        );

  @override
  WorkoutMultiDrillBlock copy() {
    return WorkoutMultiDrillBlock(drills: copyDrills());
  }
}

class WorkoutAmrapDrillBlock extends WorkoutDrillsBlock {
  final int minutes;
  WorkoutAmrapDrillBlock({
    required this.minutes,
    required List<WorkoutDrill> drills,
  }) : super(
          drills: drills,
          type: WorkoutDrillType.AMRAP,
        );

  @override
  WorkoutAmrapDrillBlock copy() {
    return WorkoutAmrapDrillBlock(drills: copyDrills(), minutes: minutes);
  }
}

class WorkoutForTimeDrillBlock extends WorkoutDrillsBlock {
  final int timeCapMin;
  final int rounds;
  final int restBetweenRoundsMin;
  WorkoutForTimeDrillBlock({
    required List<WorkoutDrill> drills,
    required this.timeCapMin,
    required this.rounds,
    required this.restBetweenRoundsMin,
  }) : super(
          drills: drills,
          type: WorkoutDrillType.ForTime,
        );

  @override
  WorkoutForTimeDrillBlock copy() {
    return WorkoutForTimeDrillBlock(
      drills: copyDrills(),
      timeCapMin: timeCapMin,
      rounds: rounds,
      restBetweenRoundsMin: restBetweenRoundsMin,
    );
  }
}

class WorkoutEmomDrillBlock extends WorkoutDrillsBlock {
  final int timeCapMin;
  final int intervalMin;
  WorkoutEmomDrillBlock({
    required List<WorkoutDrill> drills,
    required this.timeCapMin,
    required this.intervalMin,
  }) : super(
          drills: drills,
          type: WorkoutDrillType.EMOM,
        );

  @override
  WorkoutEmomDrillBlock copy() {
    return WorkoutEmomDrillBlock(
      drills: copyDrills(),
      intervalMin: intervalMin,
      timeCapMin: timeCapMin,
    );
  }
}

class WorkoutRestDrillBlock extends WorkoutDrillsBlock {
  final int timeMin;

  WorkoutRestDrillBlock({
    required this.timeMin,
  }) : super(type: WorkoutDrillType.REST, drills: <WorkoutDrill>[]);

  @override
  WorkoutRestDrillBlock copy() {
    return WorkoutRestDrillBlock(timeMin: timeMin);
  }
}
