import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'date.dart';
import 'habit.dart';

// TODO: dedup with theme
const Color MAIN_COLOR = Colors.lime;

class HabitViewPage extends StatefulWidget {
  const HabitViewPage({super.key, required this.habit,
                      required this.updateHabitIndex});
  final Habit habit;
  final Function updateHabitIndex;

  @override
  State<HabitViewPage> createState() => _HabitViewPageState();
}

class _HabitViewPageState extends State<HabitViewPage> {
  DateData? dateDisplay;

  void _updateDateDisplay(DateData? newDateDisplay) {
    setState(() {
      dateDisplay = newDateDisplay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [ 
            SizedBox(height: 20),
            Header(habit: widget.habit, updateHabitIndex: widget.updateHabitIndex,
                  updateDateDisplay: _updateDateDisplay),
            SizedBox(height: 20),
            HabitCalendar(habit: widget.habit, dateDisplay: dateDisplay,
                          updateDateDisplay: _updateDateDisplay),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.habit,
                required this.updateHabitIndex, required this.updateDateDisplay});
  final Habit habit;
  final Function updateHabitIndex;
  final Function updateDateDisplay;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          // menu button
          GestureDetector(
            onTap: () {
              updateHabitIndex(-1);
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              color: MAIN_COLOR,
              child: Icon(Icons.menu, size: 40)
            ),
          ),
          // Header title
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
                child: Semantics(
                  button: true,
                  child: ListTile(
                    onTap: () {updateDateDisplay(null);},
                    title: Center(child: Text(habit.title)),
                    tileColor: habit.color
                  ),
                ),
            ),
          ),
        ],
      ),
    );
  }
}

class HabitCalendar extends StatelessWidget {
  const HabitCalendar({super.key, required this.habit, required this.dateDisplay,
                      required this.updateDateDisplay});
  final Habit habit;
  // TODO: update this to be index of date to display so that functionality
  // can be added to iterate through days in the larger date display view
  final DateData? dateDisplay;
  final Function updateDateDisplay;

  @override
  Widget build(BuildContext context) {
    if (dateDisplay == null) {
        return Expanded(
          child: ListView(
            children: [
              for (int month = 1; month <= 12; month++)
                MonthDisplay(habit: habit, month: month,
                                updateDateDisplay: updateDateDisplay),
            ],
          ),
        );
    } else {
      return DateView(dateData: dateDisplay!, completedColor: habit.color);
    }
  }  
}

class MonthDisplay extends StatelessWidget {
  const MonthDisplay({super.key, required this.habit, required this.month,
                      required this.updateDateDisplay});
  final Habit habit;
  final int month;
  final Function updateDateDisplay;

  // private helper to add sized box offsets
  void _addOffset(int offset, List<Widget> week) {
    for (int i = 0; i < offset; i++) {
      week.add(SizedBox(width: 50, height: 50));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> weeks = [];
    List<DateData> dateData = habit.calendar[month]!;

    // Add the sized boxes shift the boxes over
    int weekIndex = 0;
    weeks.add([]);
    int offset = DateUtils.firstDayOffset(habit.year, month, 
                                          DefaultMaterialLocalizations());
    _addOffset(offset, weeks[weekIndex]);

    // add all the dates to their correct week
    int dateIndex = 0;
    int i = offset;
    while (dateIndex < dateData.length) {
      while(i < 7 && dateIndex < dateData.length) {
        DateData currDate = dateData[dateIndex];
        weeks[weekIndex].add(
          DateBox(updateDateDisplay: updateDateDisplay, currDate: currDate, habit: habit)
        );
        i++;
        dateIndex++;
      }
      i = 0;
      weekIndex++;
      if (dateIndex < dateData.length) {
        weeks.add([]);
      }
    }

    // add leftover sized boxes to align dates correctly
    int lastRowDates = weeks[weeks.length - 1].length;
    _addOffset(7 - lastRowDates, weeks[weeks.length - 1]);
    
    return Column(
      children: [
        // Month header
        Text(DateFormat(DateFormat.MONTH).format(DateTime(2025, month))),
        // Grid of dates
        // TODO: should switch to grid instead of rows and columns?
        Column(
          children: [
            for (var week in weeks)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: week,
              ),
          ],
        ),
      ],
    );
  }

}

class DateBox extends StatelessWidget {
  const DateBox({
    super.key,
    required this.updateDateDisplay,
    required this.currDate,
    required this.habit,
  });

  final Function updateDateDisplay;
  final DateData currDate;
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: GestureDetector(
        onTap: () {
          updateDateDisplay(currDate);
        },
        child: Card(
          color: currDate.completed ? habit.color : null,
          child: Center(child: Text('${currDate.date.day}')),
        ),
      ),
    );
  }
}