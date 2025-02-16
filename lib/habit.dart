import 'package:flutter/material.dart';
import 'date.dart';
import 'dart:math';

const List<Color> COLOR_OPTIONS = [Colors.red,
                                  Colors.pink,
                                  Colors.purple,
                                  Colors.deepPurple,
                                  Colors.indigo,
                                  Colors.blue,
                                  Colors.lightBlue,
                                  Colors.cyan,
                                  Colors.teal,
                                  Colors.green,
                                  Colors.lightGreen,
                                  Colors.lime,
                                  Colors.yellow,
                                  Colors.amber,
                                  Colors.orange,
                                  Colors.deepOrange,
                                  Colors.brown,
                                  Colors.blueGrey];

class Habit {
  static final Random _random = Random();

  final String title;
  late Color color;
  // Map month num -> list[datedata]
  late Map<int, List<DateData>> calendar;
  // TODO: make this adjust to whatever the current year is
  final int year = 2025;
  
  Habit({required this.title, Color? color}) { 
    if (color != null) {
      this.color = color;
    } else {
      this.color = COLOR_OPTIONS[_random.nextInt(COLOR_OPTIONS.length)];
    }

    calendar = {};
    for (int month = 1; month <= 12; month++) {
      List<DateData> dates = [];
      for (int day = 1; day <= DateUtils.getDaysInMonth(year, month); day++) {
        dates.add(DateData(date: DateUtils.dateOnly(DateTime(year, month, day))));
      }
      calendar[month] = dates;
    }
  }
}