import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter_sport_firebase/domain/provider/add_workout_day_provider.dart';
import 'package:flutter_sport_firebase/model/workout.dart';
import 'package:flutter_sport_firebase/ui/style/app_style.dart';

class AddworkoutDayScreen extends StatelessWidget {
  final WorkoutWeekDay day;

  const AddworkoutDayScreen({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddWorkoutDayProvider>(
      create: (BuildContext context) => AddWorkoutDayProvider(day: day),
      builder: (BuildContext context, Widget? widget) {
        final modelRead = context.read<AddWorkoutDayProvider>();
        final modelWatch = context.watch<AddWorkoutDayProvider>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Day plan'),
          ),
          body: Column(
            children: [
              Expanded(
                child: Form(
                  key: modelRead.globalKey,
                  child: ListView.builder(
                    itemCount: modelWatch.workoutWeekDay.drillBlocks.length,
                    itemBuilder: (context, int index) {
                      return WorkoutDrillForm(
                        modelRead: modelRead,
                        modelWatch: modelWatch,
                        index: index,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ColoredBox(
                  color: AppColors.bottomBackroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => modelRead.save(context),
                            child: const Text('Save'),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Select Workout Type',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        DropdownButtonFormField<String>(
                                            value: modelRead.drillTypeSelect,
                                            onChanged: (value) {
                                              modelRead.drillTypeSelect = value;
                                            },
                                            items:
                                                modelRead.drillType.map((type) {
                                              return DropdownMenuItem<String>(
                                                  value: type,
                                                  child: Text(type));
                                            }).toList()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () => modelRead
                                                  .addWorkoutDrillBlock(
                                                      context),
                                              child: const Text('Apply'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('Cancel'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            child: const Text('Add Workout'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class WorkoutDrillForm extends StatelessWidget {
  final AddWorkoutDayProvider modelRead;
  final AddWorkoutDayProvider modelWatch;

  final int index;
  const WorkoutDrillForm({
    Key? key,
    required this.modelRead,
    required this.index,
    required this.modelWatch,
  }) : super(key: key);

  SizedBox _dropDownMenuNumberDrill() {
    if (modelRead.workoutWeekDay.drillBlocks[index].type ==
            WorkoutDrillType.SINGLE ||
        modelRead.workoutWeekDay.drillBlocks[index].type ==
            WorkoutDrillType.REST) {
      return const SizedBox.shrink();
    } else {
      return SizedBox(
        width: 100,
        child: DropdownButtonFormField(
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.deepPurple[300],
          ),
          value: modelWatch.numberBlocksSelect,
          onChanged: (String? number) {
            modelRead.numberBlocksSelect = number!;
            modelRead.changeDrillCount(index);
          },
          items: modelRead.numberBlocksList
              .map(
                (String number) => DropdownMenuItem(
                  child: Text(
                    number,
                    style: const TextStyle(color: Colors.orange),
                  ),
                  value: number,
                ),
              )
              .toList(),
        ),
      );
    }
  }

  Widget _createFieldOfBlockType(int index, BuildContext context) {
    if (modelRead.workoutWeekDay.drillBlocks[index].type ==
        WorkoutDrillType.AMRAP) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _createTextFormField(
          value:
              modelRead.drillBlockGetParam(index: index, paramName: 'Minutes*'),
          text: 'Minutes*',
          onChanged: (string) => modelRead.drillBlockSetParam(
              text: string, paramName: 'Minutes*', index: index),
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.done,
        ),
      );
    } else if (modelRead.workoutWeekDay.drillBlocks[index].type ==
        WorkoutDrillType.ForTime) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          _createTextFormField(
            value: modelRead.drillBlockGetParam(
                index: index, paramName: 'Rest Between Rounds in Minutes*'),
            text: 'Rest Between Rounds in Minutes*',
            onChanged: (string) => modelRead.drillBlockSetParam(
                text: string,
                paramName: 'Rest Between Rounds in Minutes*',
                index: index),
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            textInputAction: TextInputAction.next,
          ),
          _createTextFormField(
            value: modelRead.drillBlockGetParam(
                index: index, paramName: 'Rounds*'),
            text: 'Rounds*',
            onChanged: (string) => modelRead.drillBlockSetParam(
                text: string, paramName: 'Rounds*', index: index),
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            textInputAction: TextInputAction.next,
          ),
          _createTextFormField(
            value: modelRead.drillBlockGetParam(
                index: index, paramName: 'Time Cap in Minutes*'),
            text: 'Time Cap in Minutes*',
            onChanged: (string) => modelRead.drillBlockSetParam(
                text: string, paramName: 'Time Cap in Minutes*', index: index),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
            textInputAction: TextInputAction.done,
          ),
        ]),
      );
    } else if (modelRead.workoutWeekDay.drillBlocks[index].type ==
        WorkoutDrillType.EMOM) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          _createTextFormField(
            value: modelRead.drillBlockGetParam(
                index: index, paramName: 'Interval in Minutes*'),
            text: 'Interval in Minutes*',
            onChanged: (string) => modelRead.drillBlockSetParam(
                text: string, paramName: 'Interval in Minutes*', index: index),
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            textInputAction: TextInputAction.next,
          ),
          _createTextFormField(
            value: modelRead.drillBlockGetParam(
                index: index, paramName: 'Time Cap in Minutes*'),
            text: 'Time Cap in Minutes*',
            onChanged: (string) => modelRead.drillBlockSetParam(
                text: string, paramName: 'Time Cap in Minutes*', index: index),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
            },
            textInputAction: TextInputAction.done,
          ),
        ]),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  TextFormField _createTextFormField({
    dynamic value,
    required String text,
    required void Function()? onEditingComplete,
    required void Function(String)? onChanged,
    required TextInputAction textInputAction,
  }) {
    return TextFormField(
      initialValue: _initialValue(value),
      inputFormatters: _inputFormatters(text),
      keyboardType: _keyboardType(text),
      maxLines: _maxLines(text),
      validator: (String? value) {
        if (text == 'Weight') {
          return null;
        }
        if (value!.isEmpty) {
          return 'Please fill in this field';
        } else {
          return null;
        }
      },
      textInputAction: textInputAction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: const TextStyle(color: AppColors.backroundColor),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.backroundColor)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.backroundColor, width: 2)),
      ),
    );
  }

  String? _initialValue(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is String) {
      return value;
    } else {
      return value.toString();
    }
  }

  int? _maxLines(String text) {
    if (text == 'Sets*' || text == 'Peps*') {
      return 1;
    } else {
      return null;
    }
  }

  List<TextInputFormatter> _inputFormatters(String text) {
    if (text == 'Sets*' ||
        text == 'Peps*' ||
        text == 'Time Cap in Minutes*' ||
        text == 'Interval in Minutes*' ||
        text == 'Rounds*' ||
        text == 'Rest Between Rounds in Minutes*' ||
        text == 'Minutes*') {
      return [
        FilteringTextInputFormatter.allow(RegExp(r'\d')),
      ];
    } else {
      return [
        LengthLimitingTextInputFormatter(100),
      ];
    }
  }

  TextInputType _keyboardType(String text) {
    if (text == 'Sets*' ||
        text == 'Peps*' ||
        text == 'Time Cap in Minutes*' ||
        text == 'Interval in Minutes*' ||
        text == 'Rounds*' ||
        text == 'Rest Between Rounds in Minutes*' ||
        text == 'Minutes*') {
      return TextInputType.number;
    } else {
      return TextInputType.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    final drillFormType = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 3,
          color: AppColors.backroundColor,
        ),
      ),
      child: Column(
        children: [
          ColoredBox(
            color: modelRead.workoutWeekDay.drillBlocks[index].type.index == 5
                ? Colors.green
                : AppColors.backroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    modelRead.drillType[
                        modelRead.workoutWeekDay.drillBlocks[index].type.index],
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                _dropDownMenuNumberDrill(),
                IconButton(
                  onPressed: () => modelRead.removeDrillBlock(index),
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
          _createFieldOfBlockType(index, context),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(8.0),
            child: drillFormType,
          ),
          ListView.builder(
            itemCount:
                modelWatch.workoutWeekDay.drillBlocks[index].drills.length,
            addAutomaticKeepAlives: true,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int indexDrill) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(width: 3, color: AppColors.backroundColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      _createTextFormField(
                        value: modelWatch.workoutWeekDay.drillBlocks[index]
                            .drills[indexDrill].title,
                        text: 'Drill*',
                        onChanged: (String text) {
                          modelWatch.workoutWeekDay.drillBlocks[index]
                              .drills[indexDrill].title = text;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      _createTextFormField(
                        value: modelWatch.workoutWeekDay.drillBlocks[index]
                            .drills[indexDrill].set,
                        text: 'Sets*',
                        onChanged: (String text) {
                          final int number = int.parse(text);
                          modelWatch.workoutWeekDay.drillBlocks[index]
                              .drills[indexDrill].set = number;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      _createTextFormField(
                        value: modelWatch.workoutWeekDay.drillBlocks[index]
                            .drills[indexDrill].peps,
                        text: 'Peps*',
                        onChanged: (String text) {
                          final int number = int.parse(text);
                          modelWatch.workoutWeekDay.drillBlocks[index]
                              .drills[indexDrill].peps = number;
                        },
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).nextFocus(),
                      ),
                      _createTextFormField(
                        value: modelWatch.workoutWeekDay.drillBlocks[index]
                            .drills[indexDrill].weight,
                        text: 'Weight',
                        onChanged: (String text) {
                          modelWatch.workoutWeekDay.drillBlocks[index]
                              .drills[indexDrill].weight = text;
                        },
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () =>
                            FocusScope.of(context).unfocus(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
