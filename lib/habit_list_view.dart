import 'package:flutter/material.dart';
import 'habit.dart';
import 'add_habit.dart';

// TODO: dedup with an app theme
const Color MAIN_COLOR = Colors.lime;

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key, required this.title,
                      required this.habits, required this.updateDisplayHabit,
                      required this.addHabit,
                      required this.reorderHabits});
  final String title;
  final List<Habit> habits;
  final Function updateDisplayHabit;
  final Function addHabit;
  final Function reorderHabits;

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
            Header(title: widget.title, switchToHabitAdder: switchToHabitAdder),
            SizedBox(height: 20),
            // TODO: add a quick edit box for updating today's date for all habits?
            addingHabit ? 
                NewHabitForm(addHabit: widget.addHabit,
                            switchToHabitAdder: switchToHabitAdder) 
              : HabitList(habits: widget.habits, 
                               updateDisplayHabit: widget.updateDisplayHabit, 
                               switchToHabitAdder: switchToHabitAdder,
                               reorderHabits: widget.reorderHabits),
            if (!addingHabit)
              AddHabitButton(switchToHabitAdder: switchToHabitAdder),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key,
                required this.title,
                required this.switchToHabitAdder});
    final String title;
    final Function switchToHabitAdder;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Semantics(
        button: true,
        child: ListTile(
          onTap: () => {switchToHabitAdder(false)},
          leading: Icon(Icons.menu, size: 40),
          title: Center(child: Text(title)),
          tileColor: MAIN_COLOR,
        ),
      ),
    );
  }
}

// TODO: list of habits should probably live here in HabitList widget or 
//       in AppState instead of using these callbacks to update
class HabitList extends StatelessWidget {
  const HabitList({super.key, required this.habits, 
                  required this.updateDisplayHabit,
                  required this.switchToHabitAdder,
                  required this.reorderHabits});

  final List<Habit> habits;
  final Function updateDisplayHabit;
  final Function switchToHabitAdder;
  final Function reorderHabits;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        children: [
          for (int i = 0; i < habits.length; i++)
            HabitListTile(key: Key('$i'), updateDisplayHabit: updateDisplayHabit, habit: habits[i]),
        ],
        onReorder: (int oldIndex, int newIndex) {
          reorderHabits(oldIndex, newIndex);
        },
      ),
    );
  }
}

class HabitListTile extends StatelessWidget {
  const HabitListTile({
    super.key,
    required this.updateDisplayHabit,
    required this.habit,
  });

  final Function updateDisplayHabit;
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        child: Semantics(
          button: true,
          // TODO: add an edit button with ability to delete the habit
          //      or make them slidable with flutter_slidable for multiple actions
          child: ListTile(
            onTap: () => {updateDisplayHabit(habit)},
            title: Center(child: Text(habit.title)),
            tileColor: habit.color,
          ),
        ),
      ),
    );
  }
}

class AddHabitButton extends StatelessWidget {
  const AddHabitButton({super.key, required this.switchToHabitAdder});
  final Function switchToHabitAdder;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: TextButton(
          onPressed: () {
            // switch to HabitAdder display
            switchToHabitAdder(true);
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            backgroundColor: MAIN_COLOR,
          ),
          child: Icon(Icons.add, size: 60)
        ),
      ),
    );
  }  
}

