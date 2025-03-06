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
  Habit? displayHabit;
  List<Habit> habits = [Habit(title: 'one'), Habit(title: 'two'), Habit(title: 'three'),  ]; 

  updateDisplayHabit(Habit? habit) {
    setState(() {
      displayHabit = habit;
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
    if (!habits.contains(remove)) {
      throw ArgumentError('Unknown habit');
    }
    setState(() {
      habits.removeAt(habits.indexOf(remove));
    });
  }

  reorderHabits(int oldIndex, int newIndex) {
    // setState(() {
    //   if (oldIndex < newIndex) {
    //     newIndex -= 1;
    //   }
    //   final int item = _items.removeAt(oldIndex);
    //   _items.insert(newIndex, item);
    // });
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      habits.insert(newIndex, habits.removeAt(oldIndex));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (displayHabit == null) {
      return HabitListPage(title: widget.title, habits: habits,
                           updateDisplayHabit: updateDisplayHabit,
                           addHabit: addHabit,
                           reorderHabits: reorderHabits);
    } else {
      return HabitViewPage(habit: displayHabit!,
                          updateDisplayHabit: updateDisplayHabit);
    }
  }
}

