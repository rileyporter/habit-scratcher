import 'package:flutter/material.dart';
import 'habit.dart';

// TODO: add functionality to add a new habit
/* Steps involved:
      - move habit list to state and add callbacks to update list
      - making a pop up layer in UI with an input form
        - validating habit name input (length restricted?)
        - adding a list of possible colors to choose from
      - ability to delete habit, maybe a little trash can?
*/
class NewHabitForm extends StatefulWidget {
  const NewHabitForm({super.key, required this.addHabit, required this.switchToHabitAdder});
  
  final Function addHabit;
  final Function switchToHabitAdder;

  @override
  State<NewHabitForm> createState() => _NewHabitFormState();
}

class _NewHabitFormState extends State<NewHabitForm> {
  final _formKey = GlobalKey<FormState>();
  final _formController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            TextFormField(
              controller: _formController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a habit name';
                } else if (value.length > 100) {
                  return 'Habit name must be less than 100 characters';
                }
                return null;
              },
            ),
            // TODO: add a radio list of the color options
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: update habit list
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Adding Habit')),
                  );
                  widget.addHabit(Habit(title: _formController.text));
                  widget.switchToHabitAdder(false);
                }
              },
              child: const Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }
}
