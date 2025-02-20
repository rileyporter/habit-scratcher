import 'package:flutter/material.dart';
import 'habit_calendar_view.dart';
import 'habit_list_view.dart';
import 'habit.dart';

// TODO: figure out how to store state in phone storage between loads of the app


// TODO: switch to some Spacer() widgets or Expanded instead of sized box for all available space
// Expandeds take a flex attribute to figure out what scale they should be
// Align widgets can align containers to specific places

const Color MAIN_COLOR = Colors.lime;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Scratcher',
      // TODO: figure out best practices for app theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MAIN_COLOR),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Habit Scratcher'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _habitIndex = -1;
  List<Habit> habits = [Habit(title: 'seeded'), Habit(title: 'seeded'), Habit(title: 'seeded'), Habit(title: 'seeded'), Habit(title: 'seeded'), Habit(title: 'seeded'), Habit(title: 'seeded'),
                        ]; //Habit(title: 'seeded'), Habit(title: 'seeded'),Habit(title: 'seeded'),Habit(title: 'seeded'),Habit(title: 'seeded'),Habit(title: 'seeded'),];

  updateHabitIndex(int newIndex) {
    setState(() {
      _habitIndex = newIndex;
    });
  }

  // TODO: should we move list of habits to AppState to update from
  //       list view directly instead of with callbacks?
  addHabit(Habit newHabit) {
    setState(() {
        habits = [...habits, newHabit];
    });
  }

  removeHabit(Habit remove) {
    if (habits.contains(remove)) {
      throw ArgumentError('Unknown habit');
    }
    setState(() {
      int removeIndex = habits.indexOf(remove);
      if (removeIndex < habits.length - 1) {
        habits = [...habits.getRange(0, removeIndex), 
                  ...habits.getRange(removeIndex + 1, habits.length)];
      } else {
        habits = [...habits.getRange(0, removeIndex)];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_habitIndex < 0) {
      return HabitListPage(title: widget.title, habits: habits,
                           displayHabitAtIndex: updateHabitIndex,
                           addHabit: addHabit);
    } else if (_habitIndex < habits.length) {
      return HabitViewPage(habit: habits[_habitIndex],
                          updateHabitIndex: updateHabitIndex);
    } else {
      throw UnsupportedError('Unknown State');
    }
  }
}

