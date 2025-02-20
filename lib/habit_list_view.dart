import 'package:flutter/material.dart';
import 'habit.dart';
import 'add_habit.dart';

// TODO: dedup with an app theme
const Color MAIN_COLOR = Colors.lime;

class HabitListPage extends StatefulWidget {
  const HabitListPage({super.key, required this.title,
                      required this.habits, required this.displayHabitAtIndex,
                      required this.addHabit});
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
            Header(title: widget.title, switchToHabitAdder: switchToHabitAdder),
            SizedBox(height: 20),
            // TODO: add a quick edit box for updating today's date for all habits?
            addingHabit ? 
                NewHabitForm(addHabit: widget.addHabit,
                            switchToHabitAdder: switchToHabitAdder) 
              : HabitList(habits: widget.habits, 
                               displayHabitAtIndex: widget.displayHabitAtIndex, 
                               switchToHabitAdder: switchToHabitAdder),
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

class HabitList extends StatelessWidget {
  const HabitList({super.key, required this.habits, 
                  required this.displayHabitAtIndex,
                  required this.switchToHabitAdder});

  final List<Habit> habits;
  final Function displayHabitAtIndex;
  final Function switchToHabitAdder;


  @override
  Widget build(BuildContext context) {
    // TODO: ability to reorder habits displayed in list
    return Expanded(
      child: ListView(
        children: [
          // TODO: make the habit list draggable to edit the order?
          for (int i = 0; i < habits.length; i++)
            HabitListTile(displayHabitAtIndex: displayHabitAtIndex, i: i, habits: habits),
        ],
      ),
    );
  }
}

class HabitListTile extends StatelessWidget {
  const HabitListTile({
    super.key,
    required this.displayHabitAtIndex,
    required this.i,
    required this.habits,
  });

  final Function displayHabitAtIndex;
  final int i;
  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Semantics(
        button: true,
        // TODO: add an edit button with ability to delete the habit
        //      or make them slidable with flutter_slidable for multiple actions
        // TODO: figure out why ListTiles mean this list overflows
        //      onto the header and under the add button. The text in the list
        //      tiles goes away when they should be out of view, but the background
        //      is still visible.
        child: ListTile(
          onTap: () => {displayHabitAtIndex(i)},
          title: Center(child: Text(habits[i].title)),
          tileColor: habits[i].color,
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

