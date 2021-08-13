import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/domain/provider/add_workout_week_provider.dart';
import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:provider/provider.dart';

class AddWorkoutWeekScreen extends StatelessWidget {
  final WorkoutWeek? week;
  const AddWorkoutWeekScreen({
    Key? key,
    required this.week,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddWorkoutWeekModel>(
      create: (context) => AddWorkoutWeekModel(week: week),
      builder: (context, widget) {
        final modelRead = context.read<AddWorkoutWeekModel>();
        final modelWatch = context.watch<AddWorkoutWeekModel>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Week Plan'),
          ),
          body: ListView.builder(
            itemCount: modelWatch.workoutWeek.days.length,
            itemBuilder: (context, int index) {
              return ListTile(
                leading: modelRead.workoutWeek.days[index].isSet
                    ? const Icon(Icons.check)
                    : const Icon(Icons.schedule),
                title: Text(dayTitle(index, modelRead, modelWatch)),
                trailing: IconButton(
                  onPressed: () => modelRead.showWorkoutDay(context, index),
                  icon: const Icon(Icons.keyboard_arrow_right),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () =>modelRead.save(context),
            child: const Icon(Icons.save),
          ),
        );
      },
    );
  }

  String dayTitle(int index, AddWorkoutWeekModel modelRead,
      AddWorkoutWeekModel modelWatch) {
    final drillCounter =
        modelRead.workoutWeek.days[index].notRestDrillBlocksCount;
    if (drillCounter > 0) {
      return '${modelRead.currentTime(index)} - $drillCounter Drills';
    } else {
      return '${modelRead.currentTime(index)} - Rest Day';
    }
  }
}
