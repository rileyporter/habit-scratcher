import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateData {
  final DateTime date;
  bool completed = false;

  DateData({required this.date});
}

// TODO: make the date detail view slide in with a transition from the package:animation?
// using OpenContainer with an open and closed widget defined
class DateView extends StatefulWidget {
  const DateView({super.key, required this.dateData,
                  required this.completedColor});
  final DateData dateData;  
  // TODO: dedup with App Theme
  final Color completedColor;

  @override
  State<DateView> createState() => _DateViewState();
}

class _DateViewState extends State<DateView> {

  @override
  Widget build(BuildContext context) {
      return Column(
        children: [
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: add left and right arrows to scan through dates
              //       in display view (PageView and PageController instead?)
              // TODO: make this expanded and flexible for different screens
              SizedBox(
                width: 200,
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.dateData.completed = true;
                    });
                  },
                  child: Card(
                    color: widget.dateData.completed ? widget.completedColor : null,
                  ),
                )
              )
            ],
          ),
          SizedBox(height: 50),
          Column(
            children: [
              Text(DateFormat(DateFormat.WEEKDAY).format(widget.dateData.date)),
              Text(DateFormat('${DateFormat.MONTH} ${DateFormat.DAY}')
                  .format(widget.dateData.date)),
              Text(DateFormat(DateFormat.YEAR).format(widget.dateData.date)),
            ],
          ),
          if (widget.dateData.completed)
            Padding(
              padding: const EdgeInsets.symmetric(vertical:30.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    widget.dateData.completed = false;
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                ),
                child: Icon(Icons.refresh, size: 40)
              ),
            ),
        ],
      );
  }
}