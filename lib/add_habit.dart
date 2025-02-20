import 'package:flutter/material.dart';
import 'habit.dart';

class NewHabitForm extends StatefulWidget {
  const NewHabitForm({super.key, required this.addHabit,
                      required this.switchToHabitAdder});
  
  final Function addHabit;
  final Function switchToHabitAdder;
  static final Color DEFAULT_COLOR = Habit.COLOR_OPTIONS[0];

  @override
  State<NewHabitForm> createState() => _NewHabitFormState();
}

class _NewHabitFormState extends State<NewHabitForm> {
  final _formKey = GlobalKey<FormState>();
  final _formController = TextEditingController();
  Color? _selectedColor = NewHabitForm.DEFAULT_COLOR;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _formController.dispose();
    super.dispose();
  }

  _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adding Habit')),
      );
      widget.addHabit(Habit(title: _formController.text, color: _selectedColor));
      widget.switchToHabitAdder(false);
    }
  }

  _updateSelectedColor(Color newColor) {
    setState(() {
      _selectedColor = newColor;
    });
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
              maxLength: 50,
              onFieldSubmitted: (value) {_submitForm();},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a habit name';
                }
                return null;
              },
            ),
            Wrap(
              children: [
                for (Color color in Habit.COLOR_OPTIONS)
                  ColorRadioButton(color: color, 
                                  updateSelectedColor: _updateSelectedColor,
                                  selectedColor: _selectedColor),
              ],
            ),
            SizedBox(height: 30),
            // TODO: add styling to the add habit button
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Add Habit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorRadioButton extends StatelessWidget {
  const ColorRadioButton({super.key, required this.color, 
                          required this.updateSelectedColor, 
                          required this.selectedColor});
  final Color color;
  final Function updateSelectedColor;
  final Color? selectedColor;
  
  @override
  Widget build(BuildContext context) {
    // TODO: want to scale the radio buttons to be bigger, but that seems to
    // affect clicking accuracy for selecting
    return Radio<Color>(
      value: color,
      groupValue: selectedColor,
      onChanged: (Color? value) {updateSelectedColor(value);},
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return color;
      }),
      
    );
  }
}
