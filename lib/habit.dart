import 'package:flutter/material.dart';

class Habit {
  final String title;
  final Color color;
  // TODO: make this adjust to whatever the current year is
  final int year = 2025;

  // Map month num -> list[datedata]
  late Map<int, List<DateData>> calendar;

  Habit({required this.title, required this.color}) {
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