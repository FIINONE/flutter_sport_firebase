import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/domain/add_workout_provider.dart';
import 'package:provider/provider.dart';

class AddWorkoutPage extends StatelessWidget {
  const AddWorkoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddWorkoutModel>(
      create: (context) => AddWorkoutModel(),
      builder: (context, widget) {
        final modelRead = context.read<AddWorkoutModel>();
        final modelWatch = context.watch<AddWorkoutModel>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Workout'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    errorText: modelWatch.errorText,
                  ),
                  onChanged: (String value) {
                    modelRead.titleText = value;
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select level'),
                  value: modelRead.levelSelect,
                  onChanged: (value) => modelRead.levelSelect = value,
                  items: modelRead.levelFilter.map((level) {
                    return DropdownMenuItem<String>(
                      value: level,
                      child: Text(level),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Weeks',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () => modelRead.addWorkoutWeek(context),
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                workoutWeekListBuilder(
                  modelRead: modelRead,
                  modelWatch: modelWatch,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => modelRead.save(),
            child: const Icon(Icons.save),
          ),
        );
      },
    );
  }

  Widget workoutWeekListBuilder({
    required AddWorkoutModel modelWatch,
    required AddWorkoutModel modelRead,
  }) {
    if (modelRead.workoutSchedule.week.isNotEmpty) {
      return Expanded(
        child: ListView.builder(
          itemCount: modelWatch.workoutSchedule.week.length,
          itemBuilder: (context, int index) {
            return ListTile(
              leading: const Icon(Icons.check),
              title: Text(
                'Week ${index + 1} - ${modelRead.workoutSchedule.week[index].daysWithDrills} Training Days',
              ),
              trailing: IconButton(
                onPressed: () => modelRead.changeWorkoutWeek(
                    indexWeek: index, context: context),
                icon: const Icon(Icons.keyboard_arrow_right),
              ),
            );
          },
        ),
      );
    }
    return const Text('Please enter at least one week.');
  }
}
