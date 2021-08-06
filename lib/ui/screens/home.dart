import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sport_firebase/components/active_workout.dart';
import 'package:flutter_sport_firebase/domain/provider/workoutlist_provider.dart';
import 'package:flutter_sport_firebase/ui/screens/workout.dart';
import 'package:flutter_sport_firebase/services/auth.dart';
import 'package:flutter_sport_firebase/ui/style/app_style.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

final WorkoutListModel _workoutListModel = WorkoutListModel();

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final curvedNavigationBar = CurvedNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      animationDuration: const Duration(milliseconds: 500),
      color: AppColors.bottomBackroundColor,
      items: const [
        Icon(Icons.fitness_center),
        Icon(Icons.search),
      ],
      onTap: (int index) {
        setState(() => currentIndex = index);
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 81, 107, 1),
        title: const Text('Sport App'),
        centerTitle: true,
        leading: const Icon(Icons.fitness_center),
        actions: [
          IconButton(
              onPressed: () => AuthServise().logOut(),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: currentIndex == 0
          ? const ActiveWorkout()
          : ChangeNotifierProvider<WorkoutListModel>.value(
              value: _workoutListModel,
              child: WorkoutListScreen(),
            ),
      bottomNavigationBar: curvedNavigationBar,
    );
  }
}
