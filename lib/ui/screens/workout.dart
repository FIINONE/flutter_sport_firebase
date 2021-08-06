import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/domain/provider/workoutlist_provider.dart';
import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:flutter_sport_firebase/ui/style/app_style.dart';
import 'package:flutter_sport_firebase/ui/widgets/workout/workout_list.dart';
import 'package:provider/provider.dart';

class WorkoutListScreen extends StatelessWidget {
  WorkoutListScreen({Key? key}) : super(key: key);

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
    Workout(
        title: 'Test5',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
    Workout(
        title: 'Test5',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
    Workout(
        title: 'Test8',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
    Workout(
        title: 'Test6',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
    Workout(
        title: 'Testx',
        author: 'Azamat 5',
        description: 'Test Workout 5',
        level: 'Advanced'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const _FilterWorkoutForm(),
          SizedBox(
              height: MediaQuery.of(context).size.height - 266,
              child: WorkoutList(workouts: _workouts)),
        ],
      ),
    );
  }
}

class _FilterWorkoutForm extends StatelessWidget {
  const _FilterWorkoutForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<WorkoutListModel>(context);
    return Column(
      children: [
        GestureDetector(
          onTap: () => model.toggleOpen(),
          child: Container(
            decoration:  BoxDecoration(
              color: Colors.blueGrey[600],
              // Color(0x55324155),
              // (0x3241551f),
            ),
            // color: const Color.fromRGBO(50, 65, 85, 0.8),
            height: 75,
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.filter_list),
                const SizedBox(width: 20),
                Text(
                    '${model.myWorkouts} / ${model.levelSelect}${model.searchTitle}'),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          curve: Curves.easeInOutCubic,
          color: model.isOpen ? Colors.grey[400] : Colors.white24,
          width: MediaQuery.of(context).size.width,
          height: model.isOpen ? 300 : 0,
          duration: const Duration(milliseconds: 1000),
          child: model.isOpen
              ? ListView(
                  // physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SwitchListTile(
                        title: const Text('Only My Workouts'),
                        value: model.switchState,
                        onChanged: (state) => model.toggleSwitch = state,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Level'),
                        value: model.levelSelect ?? model.levelFilter[0],
                        onChanged: (value) => model.levelSelect = value,
                        items: model.levelFilter.map((level) {
                          return DropdownMenuItem<String>(
                            value: level,
                            child: Text(level),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(hintText: 'Title'),
                        onChanged: (String value) {
                          model.searchTitle = ' / $value';
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => model.applyPressed(),
                              child: const Text('Apply'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.backroundColor)),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () => model.clearPressed(),
                              child: const Text('Clear'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : null,
        )
      ],
    );
    // return ExpansionTile(
    //   key: model.valueKey,
    //   initiallyExpanded: model.isOpen,
    //   maintainState: true,
    //   onExpansionChanged: (value) {
    //     model.togglePanel = value;
    //   },
    //   backgroundColor: Colors.grey[300],
    //   collapsedBackgroundColor: Colors.white24,
    //   title:
    //       Text('${model.myWorkouts} / ${model.levelSelect}${model.searchTitle}'),
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: SwitchListTile(
    //         title: const Text('Only My Workouts'),
    //         value: model.switchState,
    //         onChanged: (state) => model.toggleSwitch = state,
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: DropdownButtonFormField<String>(
    //         decoration: const InputDecoration(labelText: 'Level'),
    //         value: model.levelSelect ?? model.levelFilter[0],
    //         onChanged: (value) => model.levelSelect = value,
    //         items: model.levelFilter.map((level) {
    //           return DropdownMenuItem<String>(
    //             value: level,
    //             child: Text(level),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: TextField(
    //         decoration: InputDecoration(hintText: 'Title'),
    //         onChanged: (String value) {
    //           model.searchTitle = ' / $value';
    //         },
    //       ),
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: ElevatedButton(
    //               onPressed: () => model.applyPressed(),
    //               child: const Text('Apply'),
    //               style: ButtonStyle(
    //                   backgroundColor:
    //                       MaterialStateProperty.all(AppColors.backroundColor)),
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: ElevatedButton(
    //               onPressed: ()=> model.clearPressed(),
    //               child: const Text('Clear'),
    //               style: ButtonStyle(
    //                   backgroundColor: MaterialStateProperty.all(Colors.red)),
    //             ),
    //           ),
    //         ),
    //       ],
    //     )
    //   ],
    // );
  }
}
