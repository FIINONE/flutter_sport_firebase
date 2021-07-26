import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/model/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sport App'),
        centerTitle: true,
        leading: const Icon(Icons.fitness_center),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: WorkoutList(),
    );
  }
}

class WorkoutList extends StatelessWidget {
  WorkoutList({Key? key}) : super(key: key);

  final List<Workout> _workouts = <Workout>[
    Workout(
        title: 'Test1',
        author: 'Azamat 1',
        description: 'Test Workout 1',
        level: 'Elementary'),
    Workout(
        title: 'Test3',
        author: 'Azamat 2',
        description: 'Test Workout 2',
        level: 'Intermediate'),
    Workout(
        title: 'Test3',
        author: 'Azamat 3',
        description: 'Test Workout 3',
        level: 'Advanced'),
    Workout(
        title: 'Test4',
        author: 'Azamat 4',
        description: 'Test Workout 4',
        level: 'Intermediate'),
    Workout(
        title: 'Test5',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
  ];

  // List<Workout>.generate(
  //   100,
  //   (int index) => Workout(
  //     title: 'Name $index',
  //     author: 'Azamat $index',
  //     description: 'Desc $index',
  //     level: '$index',
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ColoredBox(
            color: const Color.fromRGBO(50, 65, 85, 0.9),
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
