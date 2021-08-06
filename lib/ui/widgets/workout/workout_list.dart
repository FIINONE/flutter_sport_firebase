import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/workout.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({
    Key? key,
    required List<Workout> workouts,
  })  : _workouts = workouts,
        super(key: key);

  final List<Workout> _workouts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ColoredBox(
            color: const Color.fromRGBO(69, 89, 116, 1),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Icon(
                  Icons.fitness_center,
                  color: Colors.white54,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1, color: Colors.white24)),
                ),
              ),
              title: Text(
                _workouts[index].title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white54,
              ),
              subtitle: _subtitle(_workouts[index]),
            ),
          ),
        );
      },
    );
  }
}

Widget _subtitle(Workout workout) {
  MaterialColor color = Colors.grey;
  double indicatorLivel = 0.0;

  switch (workout.level) {
    case 'Elementary':
      color = Colors.green;
      indicatorLivel = 0.33;
      break;
    case 'Intermediate':
      color = Colors.yellow;
      indicatorLivel = 0.66;
      break;
    case 'Advanced':
      color = Colors.red;
      indicatorLivel = 1;
      break;
    default:
  }

  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: indicatorLivel,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(
          workout.level,
          style: const TextStyle(color: Colors.white),
        ),
      )
    ],
  );
}
