import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateData {
  final DateTime date;
  final Color completedColor;
  bool completed = false;

  DateData({required this.date, required this.completedColor});
}

// TODO: make the date detail view slide in with a transition from the package:animation?
// using OpenContainer with an open and closed widget defined
class DateView extends StatefulWidget {
  const DateView({super.key, required this.dateData,
                 required this.habitColor,
                 required this.updateDateDisplay});
  final DateData dateData;  
  final Color habitColor;
  final Function updateDateDisplay;

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {

  _updateDateCompleted(bool updateVal) {
    setState(() {
      widget.dateData.completed = updateVal;
    });
  }

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 70),
          // Date Card
          SizedBox(
            width: 200,
            height: 200,
            child: GestureDetector(
              onTap: () {_updateDateCompleted(true);},
              child: Card(
                color: widget.dateData.completed ? widget.dateData.completedColor : null,
              ),
            )
          ),
          SizedBox(height: 50),
          DateTitle(widget: widget),
          if (widget.dateData.completed)
            RefreshButton(updateDateCompleted: _updateDateCompleted),
          // TODO: Fix the sizing of the column elements so the button is actually
          // always in the lower right
          // Back button
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {widget.updateDateDisplay(null);},
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.habitColor,
              ),
              child: Icon(Icons.keyboard_return),
            ),
          ),
        ],
      );
  }
}

// TODO: format the title to look better
class DateTitle extends StatelessWidget {
  const DateTitle({
    super.key,
    required this.widget,
  });

  final DateView widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(DateFormat(DateFormat.WEEKDAY).format(widget.dateData.date)),
        Text(DateFormat('${DateFormat.MONTH} ${DateFormat.DAY}')
            .format(widget.dateData.date)),
        Text(DateFormat(DateFormat.YEAR).format(widget.dateData.date)),
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({super.key, required this.updateDateCompleted});
  final Function updateDateCompleted;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:30.0),
      child: TextButton(
        onPressed: () { updateDateCompleted(false); },
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
        ),
        child: Icon(Icons.refresh, size: 40)
      ),
    );
  }
}