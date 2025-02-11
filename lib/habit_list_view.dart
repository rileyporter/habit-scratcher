import 'package:flutter/material.dart';
import 'habit.dart';

class HabitListPage extends StatelessWidget {
  const HabitListPage({super.key, required this.title, required this.habits, required this.updateHabitIndex});
  final String title;
  final List<Habit> habits;
  final Function updateHabitIndex;

  // how to load a new page, and then route back to the other one?
  void _createHabit() {
    print('adding a new habit');
    // how to create a pop-up?
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
              child: ListTile(
                // maybe remove this icon, a little unintuitive since this isn't a button anymore
                leading: Icon(Icons.menu, size: 40),
                title: Center(child: Text(title)),
                tileColor: _mainColor,
              ),
            ),
  
            SizedBox(height: 20),

            // list of habits
            for (int i = 0; i < habits.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Semantics(
                  button: true,
                  child: ListTile(
                    onTap: () => {updateHabitIndex(i)},
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
                  _createHabit();
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                ),
                child: GestureDetector(
                  onTap: () {
                    // TODO: add functionality to add a new habit
                    /* Steps involved:
                          - move habit list to state and add callbacks to update list
                          - making a pop up layer in UI with an input form
                            - validating habit name input (length restricted?)
                            - adding a list of possible colors to choose from
                          - ability to delete habit, maybe a little trash can?
                    */
                    _createHabit();
                  },
                  child: Icon(Icons.add, size: 60)
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}