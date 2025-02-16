import 'package:flutter/material.dart';
import 'habit.dart';
import 'add_habit.dart';

// TODO: dedup with an app theme
const Color MAIN_COLOR = Colors.lime;

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key, required this.title, required this.habits, required this.displayHabitAtIndex, required this.addHabit});
  final String title;
  final List<Habit> habits;
  final Function displayHabitAtIndex;
  final Function addHabit;

  @override
  State<HabitListPage> createState() => _HabitListPageState();
}

class _HabitListPageState extends State<HabitListPage> {
  bool addingHabit = false;

  switchToHabitAdder(bool addingHabit) {
    setState( () {
      this.addingHabit = addingHabit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),

            // top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Semantics(
                button: true,
                child: ListTile(
                  onTap: () => {switchToHabitAdder(false)},
                  leading: Icon(Icons.menu, size: 40),
                  title: Center(child: Text(widget.title)),
                  tileColor: MAIN_COLOR,
                ),
              ),
            ),

            SizedBox(height: 20),
            addingHabit ? NewHabitForm(addHabit: widget.addHabit, switchToHabitAdder: switchToHabitAdder) : HabitList(habits: widget.habits, displayHabitAtIndex: widget.displayHabitAtIndex, switchToHabitAdder: switchToHabitAdder),

          ],
        ),
      ),
    );
  }
}

class HabitList extends StatelessWidget {
  const HabitList({super.key, required this.habits, required this.displayHabitAtIndex, required this.switchToHabitAdder});

  final List<Habit> habits;
  final Function displayHabitAtIndex;
  final Function switchToHabitAdder;


  @override
  Widget build(BuildContext context) {
    // TODO: ability to reorder habits displayed in list
    return Column(
      children: [
        // TODO: wrap list of habits in a scrollable ListView and learn about layout constraints
        for (int i = 0; i < habits.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Semantics(
              button: true,
              child: ListTile(
                onTap: () => {displayHabitAtIndex(i)},
                title: Center(child: Text(habits[i].title)),
                tileColor: habits[i].color,
              ),
            ),
          ),
          
        // plus sign button
        Padding(
          padding: const EdgeInsets.symmetric(vertical:10.0),
          child: TextButton(
            onPressed: () {
              // switch to HabitAdder display
              switchToHabitAdder(true);
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
            ),
            child: Icon(Icons.add, size: 60)
          ),
        ),]
      );
  }
}

