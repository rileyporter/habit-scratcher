import 'package:flutter/material.dart';
import 'date.dart';
import 'dart:math';


class Habit {
  static final Random _random = Random();
  static const List<Color> COLOR_OPTIONS = [Colors.red,
                                  //Colors.yellow,
                                  Colors.orange,
                                  Colors.amber,
                                  //Colors.deepOrange,
                                  //Colors.pink,
                                  //Colors.deepPurple,
                                  //Colors.indigo,
                                  //Colors.blue,
                                  //Colors.lightBlue,
                                  Colors.lightGreen,
                                  Colors.cyan,
                                  Colors.purple,
                                  //Colors.teal,
                                  //Colors.green,
                                  //Colors.lime,
                                  //Colors.brown,
                                  //Colors.blueGrey
                                ];
  
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
        Color randomOpacityWhite = Color.from(alpha: Random().nextDouble(), red: 1.0, green: 1.0, blue: 1.0);
        Color randomCompletedColor = Color.alphaBlend(randomOpacityWhite, this.color);
        dates.add(
          DateData(date: DateUtils.dateOnly(DateTime(year, month, day)), completedColor: randomCompletedColor)
        );
      }
      calendar[month] = dates;
    }
  }
}